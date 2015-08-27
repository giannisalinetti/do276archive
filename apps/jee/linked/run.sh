#!/bin/sh 
docker run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 mysql

docker run -d -e MYSQL_DB_NAME=items --link mysql:mysql --name eap -p 8080:8080 todojee
