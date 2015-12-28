#!/bin/bash

source /opt/rh/mysql55/enable
source /opt/rh/rh-ruby22/enable 

export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_PORT_3306_TCP_PORT=3306
export MYSQL_ENV_MYSQL_USER=user1
export MYSQL_ENV_MYSQL_PASSWORD=mypa55
export MYSQL_DB_NAME=items

ruby main.rb

