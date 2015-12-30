#!/bin/sh

# SCL does not provides -lmysqlclient needs RHEL7 mariadb-libs and mariadb-devel
#source /opt/rh/mysql55/enable
source /opt/rh/rh-ruby22/enable

# using bundler from rh-ruby22-rubygem-bundler
#gem install bundler
bundle install


