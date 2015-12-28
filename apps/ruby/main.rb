# encoding: UTF-8
require 'json'
require 'sinatra'
require 'active_record'

configure do
    set :port, 30000    
end

get '/todo' do
  redirect '/todo/index.html'
end
get '/todo/' do
  redirect '/todo/index.html'
end


require './models/init'
require './routes/init'

