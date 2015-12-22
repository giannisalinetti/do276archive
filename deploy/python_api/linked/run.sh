#!/bin/sh 
if [ ! -d "work" ]; then
  echo "Create database volume..."
  mkdir -p work/init
  cp db.sql work/init 
else
  sudo rm -rf work/*
fi

sudo chown -R 27:27 work
sudo chcon -Rt svirt_sandbox_file_t work

docker run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -v $PWD/work:/var/lib/mysql -p 30306:3306 do276/mysql-55-rhel7

docker run -d --name=todoapi -e MYSQL_DB_NAME=items --link mysql:mysql -p 30080:8080 do276/todoapi_python

docker run -d --name=todoui -p 30000:80 do276/todo_frontend