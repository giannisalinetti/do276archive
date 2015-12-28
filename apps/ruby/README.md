# DO276 Ruby/Sinatra To Do List App

Using Ruby 2.2 from SCL

Based on Sinatra 1.4 and ActiveRecord 4.2 using mysq2 handler. They require native extensions, so you need -devel packages and gcc.

May need to change MariaDB package names to use SCL packages.

* Have mysqh55 from SCL installed and database created and populated using scripts from ../jee/src/main/resources/sql/

`$ sudo su -`

`# source /opt/rh/mysql55/enable`

`# mysql`

`mysql> create database items;`

`mysql> grant all on items.* to user1@"%" identified by 'mypa55' ;`

`mysql> grant all on items.* to user1@"127.0.0.1" identified by 'mypa55' ;`

`$ mysql -h127.0.0.1 -uuser1 -pmypa55 items < ../jee/src/main/resources/sql/create.sql`

`$ mysql -h127.0.0.1 -uuser1 -pmypa55 items < ../jee/src/main/resources/sql/load.sql `

* Install required packages

`sudo yum -y install rh-ruby22 rh-ruby22-rubygem-json rh-ruby22-ruby-devel mysql55 mysql55-scldevel`

* Enable ruby and mysql from SCL:

`$  source /opt/rh/mysql55/enable`

`$ source /opt/rh/rh-ruby22/enable`

* Install gems

`gem install bundler`

`bundle install`

* Start app:

`ruby main.rb`

* Access app as http://localhost:30000/todo


* You can also test only the API as: 

`curl -s 'http://localhost:30000/todo/api/items?sortFields=id&sortDirections=asc&page=1' | python -m json.tool`

