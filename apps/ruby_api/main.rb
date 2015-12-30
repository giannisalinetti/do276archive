# encoding: UTF-8
require 'json'
require 'sinatra'
require 'sinatra/cross_origin'
require 'active_record'
require 'will_paginate'
require 'will_paginate/active_record'

configure do
    enable :cross_origin
    set :allow_origin, :any
    set :allow_methods, [:get, :post, :delete, :options]
    set :bind, '0.0.0.0'
    set :port, 30080
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"

  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  200
end

require './models/init'
require './routes/init'



