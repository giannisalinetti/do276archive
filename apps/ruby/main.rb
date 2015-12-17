# encoding: UTF-8
require 'json'
require 'sinatra'
require 'sinatra/cross_origin'
require 'active_record'

configure do
    enable :cross_origin
    set :allow_origin, :any
    set :allow_methods, [:get, :post, :delete, :options]
    
    ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
    ActiveRecord::Base.establish_connection(
      adapter:  'mysql2',
      host:     '127.0.0.1',
      username: 'todo',
      password: 'redhat',
      database: 'todo'
    )
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"

  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  200
end

require './models/init'
require './routes/init'



