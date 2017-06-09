# Snap Elasticsearch Collector for Monitoring

This repository explores 2 different tools, docker-compose and kubernetes, to simplify monitoring the health of an Elasticsearch cluster. Both tools run an example of the [Snap Framework](https://github.com/intelsdi-x/snap) and the [Elasticsearch Collector Plugin](https://github.com/intelsdi-x/snap-plugin-collector-elasticsearch) that collects the health data of Elasticsearch nodes in a cluster. InfluxDB and Grafana are used to visualize the data collected.

View blog post [Snap Elasticsearch Collector for Monitoring](https://medium.com/intel-sdi/monitor-the-systems-you-love-on-kubernetes-6dcb256bd63c#.7eumolc6r) for details. 

## Run with docker-compose
Prerequisite is having docker-machine and docker-compose installed.

After Docker is ready, run command:
```
$ docker-compose -f docker-compose/snap-es-monitor.yml up -d
```
Dashboard is available at: http://[dockerhost]:3000

## Run with Kubernetes
Prerequisite is having either Kubernetes or Minikube installed.

After Minikube is ready, run command:
```
$ kubectl create -f kubernetes/deployment --namespace kube-system
```

Dashboard is availabe at: http://127.0.0.1:3000 after the port forwarding.

