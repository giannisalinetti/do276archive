# encoding: UTF-8
require_relative './item'

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     ENV['MYSQL_PORT_3306_TCP_ADDR'],
  port:     ENV['MYSQL_PORT_3306_TCP_PORT'],
  username: ENV['MYSQL_ENV_MYSQL_USER'],
  password: ENV['MYSQL_ENV_MYSQL_PASSWORD'],
  database: ENV['MYSQL_DB_NAME'],
)

