#!/bin/sh 
if [ ! -d "/tmp/work" ]; then
  echo "Create database volume..."
  mkdir -p /tmp/work/init /tmp/work/data
  cp db.sql /tmp/work/init
  sudo chown -R 27:27 /tmp/work
  sudo chcon -Rt svirt_sandbox_file_t /tmp/work
else
  rm -fr /tmp/work/init/*
fi

kubectl create -f pv.yaml
kubectl create -f dbclaim.yaml
kubectl create -f dbinit.yaml
kubectl create -f mysql.yaml
kubectl create -f mysql-service.yaml
kubectl create -f php.yaml
kubectl create -f php-service.yaml
