# Running PHP To Do App with Kubernetes

The mysql-ext service is not created by run.sh so he database is NOT exposed by default. If needed it can be created using:

$ kubectl create -f mysql-ext-service.yaml

And deleted using:

$ kubectl delete -f mysql-ext-service.yaml

Access the application as http://localhost:30000/
