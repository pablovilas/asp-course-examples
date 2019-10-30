require 'sinatra'
require 'newrelic_rpm'
require 'sinatra/contrib'
require 'rack'
require 'faraday'
require 'faraday_middleware'
require 'zipkin-tracer'

class App < Sinatra::Base

    ZIPKIN_TRACER_CONFIG = {
        service_name: 'catalog-service',
        sample_rate: 1.0,
        json_api_host: 'http://localhost:9411'
    }.freeze

    use ZipkinTracer::RackHandler, ZIPKIN_TRACER_CONFIG

    @@products = [
        { id: 1, name: 'Coke 600ml' },
        { id: 2, name: 'Cookies 100grs' },
        { id: 3, name: 'Chocolate 50grs' },
        { id: 4, name: 'Candies 10un' },
        { id: 5, name: 'Milk 1ltr' },
        { id: 6, name: 'Water 500ml' },
        { id: 7, name: 'Wine .75ltr' },
        { id: 8, name: 'Sugar 1kg' },
        { id: 9, name: 'Soap 2un' }
    ]

    before do
        content_type :json      
    end

    get '/products' do
        @@products.to_json
    end

    get '/products/:id' do
        @@products.find { |product| product[:id] == params["id"].to_i }.to_json
    end

end