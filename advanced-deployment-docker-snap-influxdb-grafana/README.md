# Snap + Grafana + InfluxDB in a hurry with Docker Compose

The intent of this example is to share a docker-compose file that can be used
to start the latest published containers for [Snap](http://github.com/intelsdi-x/snap),
[Grafana](http://grafana.org) and [Influxdb](https://www.influxdata.com/time-series-platform/influxdb/).

Before you can get started [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose/) need to be installed and properly configured.

# Setup

1. Run `./snap/get_plugins.sh` to pull down the latest psutil and InfluxDB plugin
2. Run `docker-compose up`

That's it!

![img](https://www.dropbox.com/s/ak4vtk3az2r12tk/docker-compose-up.gif?raw=1)

## Things to know

### Volumes

Volumes are used for grafana to support adding a plugin which requires the 
container to be restarted (see [Installing Grafana Snap app](#installing-the-grafana-snap-app)).  A local 
volume is also used by the snap container for loading plugins and starting tasks
on startup.

If you do a `docker-compose down` the grafana-volume will be deleted.

### get_plugin.sh script

This script downloads the latest Snap psutil collector and 
[InfluxDB](https://github.com/intelsdi-x/snap-plugin-publisher-influxdb) 
publisher and provides them to the Snap container through a local volume.

## Installing the Grafana Snap app

1. Run `./snap/get_plugins.sh` (If you have already done this step **skip it**)
2. Run `docker exec -it grafana bash` to enter the Grafana container
   1. Run `grafana plugin install snap` to install the Snap app
3. Run `docker restart grafana` to restart grafana so the plugin will 
take effect

Installing the Grafana Snap App:
![img2](https://www.dropbox.com/s/umtwrhhm3w5itld/install-snap-grafana-app.gif?raw=1)

Configuring a Snap datasource and creating a task within Grafana:
![img3](https://www.dropbox.com/s/31p35l4t9ti0gri/configure-snap-datasource.gif?raw=1)