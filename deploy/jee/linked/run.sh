#!/bin/sh 
if [ ! -d "work" ]; then
  echo "Create database volume..."
  mkdir -p work/init
  cp db.sql work/init
  sudo chcon -Rt svirt_sandbox_file_t work
  sudo chown -R 27:27 work
else
  sudo rm -fr work/init
fi

docker run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -v $PWD/work:/var/lib/mysql -p 30306:3306 do276/mysql-55-rhel7

docker run -d -e MYSQL_DB_NAME=items --link mysql:mysql --name todo -p 30080:8080 do276/todojee
