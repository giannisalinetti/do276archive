# DO276 Ruby/Sinatra To Do List App

Using Ruby 2.2 from SCL

Based on Sinatra 1.4 and ActiveRecord 4.2 using mysq2 handler. They require native extensions, so you need -devel packages and gcc.

* Review ../ruby/README.md for packages and mysql database initialization

* Install gems

`gem install bundler`

`bundle install`

* Start app:

`ruby main.rb`

* Have front end installed into http24-httpd and configure it to listen port 30000

* Access app as http://localhost:30000/todo

* You can also test the API as:

`curl -s 'http://localhost:30080/todo/api/items?sortFields=id&sortDirections=asc&page=1' | python -m json.tool`

