kubectl delete deployments heapster --namespace kube-system
kubectl delete deployments monitoring-grafana --namespace kube-system
kubectl delete deployments monitoring-influxdb --namespace kube-system
kubectl delete deployments snap-elasticsearch --namespace kube-system
kubectl delete rc es-data --namespace kube-system
kubectl delete svc heapster monitoring-grafana monitoring-influxdb elasticsearch --namespace kube-system
