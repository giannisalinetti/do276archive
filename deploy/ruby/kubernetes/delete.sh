#!/bin/sh

kubectl delete -f ruby-service.yaml
kubectl delete -f ruby.yaml
kubectl delete -f mysql-service.yaml
kubectl delete -f mysql.yaml
kubectl delete -f dbclaim.yaml
kubectl delete -f dbinit.yaml
kubectl delete -f pv.yaml

