#!/bin/sh

kubectl delete -f python-service.yaml
kubectl delete -f python.yaml 
kubectl delete -f mysql-service.yaml
kubectl delete -f mysql.yaml
kubectl delete -f dbclaim.yaml
kubectl delete -f pv.yaml

sleep 6
sudo rm -fr /tmp/work
