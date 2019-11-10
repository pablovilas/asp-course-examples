require 'sinatra'
require 'sinatra/contrib'
require 'rack'

class App < Sinatra::Base

    @@orders = [
        { id: 1, user: { name: 'Jhon', address: 'Av. Street 123' }, products: [1, 2] },
        { id: 2, user: { name: 'Charlie', address: 'Av. Street 500' }, products: [1, 3, 4] },
        { id: 3, user: { name: 'Susan', address: 'Av. Street 200' }, products: [1, 4] }
    ]

    before do
        content_type :json      
    end

    get '/' do
        { ok: true }.to_json
    end

    get '/orders' do
        @@orders.to_json
    end

    get '/orders/:id' do
        @@orders.find { |order| order[:id] == params["id"].to_i }.to_json
    end

end