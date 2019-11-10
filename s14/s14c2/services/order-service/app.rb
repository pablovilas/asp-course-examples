require 'sinatra'
require 'sinatra/contrib'
require 'faraday'
require 'faraday_middleware'
require 'rack'
require 'diplomat'

class App < Sinatra::Base

    @@orders = [
        { id: 1, user: { name: 'Jhon', address: 'Av. Street 123' }, products: [1, 2] },
        { id: 2, user: { name: 'Charlie', address: 'Av. Street 500' }, products: [1, 3, 4] },
        { id: 3, user: { name: 'Susan', address: 'Av. Street 200' }, products: [1, 4] }
    ]
    
    Diplomat.configure do |config|
        config.url = "http://host.docker.internal:8500"
    end

    product_service = Diplomat::Service.get('product-service')
    conn = Faraday.new(url: "http://#{product_service.ServiceAddress}:#{product_service.ServicePort}") do |faraday|
        faraday.use FaradayMiddleware::ParseJson
        faraday.adapter Faraday.default_adapter
        faraday.response :json, parser_options: { symbolize_names: true }
    end

    before do
        content_type :json      
    end

    get '/health' do
        { ok: true }.to_json
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