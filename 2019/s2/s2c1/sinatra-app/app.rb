require 'sinatra'
require 'sinatra/json'

get '/' do
    json :foo => 'bar'
end