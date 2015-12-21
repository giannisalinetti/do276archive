#!/bin/bash -x

sudo rm -rf data init
mkdir -p data init
cp -p test/testdata.sql init
sudo chcon -Rt svirt_sandbox_file_t data init
sudo chown -R 27:27 data init

docker run -d --name test-mysql -p 30306:3306 \
 -e MYSQL_USER=testuser -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=contacts \
 -v $PWD/data:/var/lib/mysql/data \
 -v $PWD/init:/var/lib/mysql/init \
 do276/mysql-55-rhel7
sleep 9
source  /opt/rh/mysql55/enable
# Expected result is single table named "contacts"
mysqlshow -P30306 -h127.0.0.1 -utestuser -psecret contacts
# Expected result is single row for "John Doe"
mysql -P30306 -h127.0.0.1 -utestuser -psecret  contacts < test/query.sql

