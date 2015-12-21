#!/bin/sh 
if [ ! -d "data" ]; then
  echo "Create database volume..."
  mkdir -p data initdb
  chcon -Rt svirt_sandbox_file_t data initdb
  chmod o+rwx data
  cp db.sql initdb 
else
  rm -fr initdb/*
fi

docker run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -v `pwd`/data:/var/lib/mysql -v `pwd`/initdb:/docker-entrypoint-initdb.d -p 30306:3306 mysql

docker run -d --name=todoapi -e MYSQL_DB_NAME=items --link mysql:mysql -p 30080:8080 do276/todoapi_python

docker run -d --name=todoui --link todoapi:todoapi -p 30000:80 do276/todo_frontend

