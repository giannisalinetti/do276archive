#!/bin/sh 
if [ ! -d "/tmp/work" ]; then
  echo "Create database volume..."
  mkdir -p /tmp/work/initdb
  cp db.sql /tmp/work/initdb 
  sudo chown -R 27:27 /tmp/work
  sudo chcon -Rt svirt_sandbox_file_t /tmp/work
else
  rm -fr /tmp/work/init
fi

kubectl delete pv pv0001
kubectl delete pvc dbclaim
kubectl create -f pv.yaml
kubectl create -f dbclaim.yaml

kubectl create -f mysql.yaml
exit
kubectl create -f mysql-service.yaml
kubectl create -f wildfly.yaml
kubectl create -f wildfly-service.yaml
