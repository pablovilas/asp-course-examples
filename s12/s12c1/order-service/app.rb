require 'sinatra'
require 'newrelic_rpm'
require 'sinatra/contrib'
require 'rack'
require 'faraday'
require 'faraday_middleware'
require 'zipkin-tracer'

class App < Sinatra::Base

    @@orders = [
        { id: 1, user: { name: 'Jhon', address: 'Av. Street 123' }, products: [1, 2] },
        { id: 2, user: { name: 'Charlie', address: 'Av. Street 500' }, products: [1, 3, 4] },
        { id: 3, user: { name: 'Susan', address: 'Av. Street 200' }, products: [1, 4] }
    ]
    
    conn = Faraday.new(:url => 'http://localhost:9292/') do |faraday|
        faraday.use ZipkinTracer::FaradayHandler, 'catalog-service'
        faraday.use FaradayMiddleware::ParseJson
        faraday.adapter Faraday.default_adapter
        faraday.response :json, parser_options: { symbolize_names: true }
    end

    ZIPKIN_TRACER_CONFIG = {
        service_name: 'order-service',
        sample_rate: 1.0,
        json_api_host: 'http://localhost:9411'
    }.freeze

    use ZipkinTracer::RackHandler, ZIPKIN_TRACER_CONFIG

    before do
        content_type :json      
    end

    get '/orders' do
        @@orders.to_json
    end

    get '/orders/:id' do
        order = @@orders.find { |order| order[:id] == params["id"].to_i }.clone
        products = []
        order[:products].each do |product_id|
            response = conn.get "/products/#{product_id}"
            products << response.body
        end
        order[:products] = products
        return order.to_json
    end

end