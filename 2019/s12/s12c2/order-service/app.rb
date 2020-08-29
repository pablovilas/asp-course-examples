require 'sinatra'
require 'sinatra/contrib'
require 'rack'
require 'faraday'
require 'faraday_middleware'
require 'circuitbox/faraday_middleware'

class App < Sinatra::Base

    @@orders = [
        { id: 1, user: { name: 'Jhon', address: 'Av. Street 123' }, products: [1, 2] },
        { id: 2, user: { name: 'Charlie', address: 'Av. Street 500' }, products: [1, 3, 4] },
        { id: 3, user: { name: 'Susan', address: 'Av. Street 200' }, products: [1, 4] }
    ]
    
    conn = Faraday.new(:url => 'http://localhost:9292/') do |faraday|
        faraday.options[:open_timeout] = 2
        faraday.options[:timeout] = 5
        faraday.use Circuitbox::FaradayMiddleware, circuit_breaker_options: { exceptions: Circuitbox::FaradayMiddleware::DEFAULT_EXCEPTIONS << Faraday::ConnectionFailed, volume_threshold: 10, sleep_window: 10 }
        faraday.use FaradayMiddleware::ParseJson
        faraday.adapter Faraday.default_adapter
        faraday.response :json, parser_options: { symbolize_names: true }
    end

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
            if response.success?
                products << response.body
            else
                puts "Cannot populate product: #{product_id}"
            end
        end
        order[:products] = products
        return order.to_json
    end

end