#!/bin/sh 
if [ ! -d "data" ]; then
  echo "Create database volume..."
  mkdir -p data initdb
  cp db.sql initdb 
  sudo chown -R 27:27 data initdb
  sudo chcon -Rt svirt_sandbox_file_t data initdb
else
  sudo rm -fr initdb/*
fi

docker run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -v $PWD/data:/var/lib/mysql -v $PWD/initdb:/var/lib/mysql/init -p 30306:3306 do276/mysql-55-rhel7

docker run -d --name=todoapi -e MYSQL_DB_NAME=items --link mysql:mysql -p 30080:8080 do276/todoapi_jee

docker run -d --name=todoui -p 30000:80 do276/todo_frontend

