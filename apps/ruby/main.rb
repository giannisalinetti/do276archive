# encoding: UTF-8
require 'json'
require 'sinatra'
require 'active_record'

configure do
    set :bind, '0.0.0.0'
    set :port, 30080
end

get '/todo' do
  redirect '/todo/index.html'
end
get '/todo/' do
  redirect '/todo/index.html'
end


require './models/init'
require './routes/init'

