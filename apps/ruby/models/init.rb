# encoding: UTF-8
require_relative './item'

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     '127.0.0.1',
  username: 'user1',
  password: 'mypa55',
  database: 'items'
)

