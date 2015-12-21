#!/bin/bash -x

sudo rm -rf work
mkdir -p work/init
cp -p test/testdata.sql work/init
sudo chcon -Rt svirt_sandbox_file_t work
sudo chown -R 27:27 work

docker run -d --name test-mysql -p 30306:3306 \
 -e MYSQL_USER=testuser -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=contacts \
 -v $PWD/work:/var/lib/mysql/ \
 do276/mysql-55-rhel7
sleep 9
source  /opt/rh/mysql55/enable
# Expected result is single table named "contacts"
mysqlshow -P30306 -h127.0.0.1 -utestuser -psecret contacts
# Expected result is single row for "John Doe"
mysql -P30306 -h127.0.0.1 -utestuser -psecret  contacts < test/query.sql

