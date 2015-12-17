# DO276 Ruby/Sinatra To Do List App

Using Ruby 2.2 from SCL

Based on Sinatra 1.4 and ActiveRecord 4.2 using mysq2 handler. They require native extensions, so you need -devel packages and gcc.

May need to change MariaDB package names to use SCL packages.

* Install required packages

`sudo yum -y install rh-ruby22 rh-ruby22-rubygem-json rh-ruby22-ruby-devel mariadb-devel`

* Install gems

`gem install bundler`

`bundle install`

* Start app:

`ruby main.rb`

* Change frontend to access service in port 4567
