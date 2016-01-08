# Running Python To Do App with Kubernetes

Already done by the Vagrant box install.sh:
* edited /etc/kubernetes/apiserver, changed 1 line:
KUBE_ADMISSION_CONTROL="--admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota"
* Removed ServiceAccount
* This gets around the problem when creating a pod that it cannot find a token for the default service account.

The mysql-ext service is not created by run.sh so he database is NOT exposed by default. If needed it can be created using:

$ kubectl create -f mysql-ext-service.yaml

And deleted using:

$ kubectl delete -f mysql-ext-service.yaml

To test the application, access http://localhost:30080/todo from your developer workstation
