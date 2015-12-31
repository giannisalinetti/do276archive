# Running Ruby To Do App with Kubernetes

The mysql-ext service is not created by run.sh so he database is NOT exposed by default. If needed it can be created using:

$ kubectl create -f mysql-ext-service.yaml

And deleted using:

$ kubectl delete -f mysql-ext-service.yaml

To access the app visit

http://127.0.0.1:30000

