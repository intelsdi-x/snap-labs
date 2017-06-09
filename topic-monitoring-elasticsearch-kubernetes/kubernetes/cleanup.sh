#!/bin/sh

kubectl delete deployments snap-elasticsearch --namespace kube-system
kubectl delete rc es-data heapster influxdb-grafana --namespace kube-system
kubectl delete svc  elasticsearch monitoring-grafana monitoring-influxdb --namespace kube-system
