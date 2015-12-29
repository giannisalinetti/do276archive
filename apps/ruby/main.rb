# encoding: UTF-8
require 'json'
require 'sinatra'
require 'active_record'
require 'will_paginate'
require 'will_paginate/active_record'

configure do
    set :port, 8080    
end

get '/todo' do
  redirect '/todo/index.html'
end
get '/todo/' do
  redirect '/todo/index.html'
end


require './models/init'
require './routes/init'

