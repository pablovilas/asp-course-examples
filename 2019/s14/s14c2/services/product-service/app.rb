require 'sinatra'
require 'sinatra/contrib'
require 'rack'

class App < Sinatra::Base

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

    get '/health' do
        { ok: true }.to_json
    end

    get '/products' do
        @@products.to_json
    end

    get '/products/:id' do
        @@products.find { |product| product[:id] == params["id"].to_i }.to_json
    end

end