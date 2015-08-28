# Running Java EE To Do App with Kubernetes

edited /etc/kubernetes/apiserver, changed 1 line:
KUBE_ADMISSION_CONTROL="--admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota"

Removed ServiceAccount

This gets around the problem when creating a pod that it cannot find a token for the default service account.


