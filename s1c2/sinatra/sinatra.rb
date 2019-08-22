require 'sinatra'
require 'sinatra/json'

class App < Sinatra::Base
    # render text
    get '/hello' do
        'Hello from ASP!'
    end

    # render json
    get '/hello.json' do
        json message: 'Hello from ASP!'
    end

    # render html
    get '/hello.html' do
        send_file 'index.html'
    end
end