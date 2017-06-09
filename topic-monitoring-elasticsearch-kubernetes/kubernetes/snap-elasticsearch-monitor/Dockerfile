FROM intelsdi/snap:alpine
MAINTAINER Emily Gu <77.ears@gmail.com>

ENV SNAP_VERSION='0.16.1'
ENV FILE_PUB_PLUGIN_VER='2'
ENV ELASTICSEARCH_COL_PLUGIN_VER='latest_build'
ENV INFLUXDB_PUB_PLUGIN_VER='15' 


ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-publisher-file/$FILE_PUB_PLUGIN_VER/linux/x86_64/snap-plugin-publisher-file /opt/snap/plugins/snap-plugin-publisher-file
ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-elasticsearch/$ELASTICSEARCH_COL_PLUGIN_VER/linux/x86_64/snap-plugin-collector-elasticsearch /opt/snap/plugins/snap-plugin-collector-elasticsearch
ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-publisher-influxdb/$INFLUXDB_PUB_PLUGIN_VER/linux/x86_64/snap-plugin-publisher-influxdb /opt/snap/plugins/snap-plugin-publisher-influxdb
ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-psutil/0c3954fc7e59a12d410791ccae9983dd94352c9c/linux/x86_64/snap-plugin-collector-psutil /opt/snap/plugins/snap-plugin-collector-psutil
ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-cpu/latest/linux/x86_64/snap-plugin-collector-cpu /opt/snap/plugins/snap-plugin-collector-cpu
ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-meminfo/latest/linux/x86_64/snap-plugin-collector-meminfo /opt/snap/plugins/snap-plugin-collector-meminfo
ADD http://snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-disk/latest/linux/x86_64/snap-plugin-collector-disk /opt/snap/plugins/snap-plugin-collector-disk

RUN chmod 755 /opt/snap/plugins/*

RUN apk update && \
    apk add curl && \
    rm -rf /var/cache/apk/*

COPY example-file-task.yml /opt/snap/tasks/example-file-task.yml 
COPY example-influxdb-task.yml /opt/snap/tasks/example-influxdb-task.yml
COPY example-psutil-task.yml /opt/snap/tasks/example-psutil-task.yml
COPY example-cpu-task.yml /opt/snap/tasks/example-cpu-task.yml
COPY example-disk-task.yml /opt/snap/tasks/example-disk-task.yml
COPY example-mem-task.yml /opt/snap/tasks/example-mem-task.yml

COPY grafana-datasource.json /etc/snap/grafana-datasource.json
COPY snap-elasticsearch-dashboard.json /etc/snap/snap-elasticsearch-dashboard.json
COPY snap-hardware-dashboard.json /etc/snap/snap-hardware-dashboard.json
COPY init_grafana /usr/local/bin/init_grafana
COPY create_tasks /usr/local/bin/create_tasks

CMD ["sh", "-c", "/usr/local/bin/init_snap;  /usr/local/bin/init_grafana; sleep 10; /opt/snap/sbin/snapteld -t ${SNAP_TRUST_LEVEL} -l ${SNAP_LOG_LEVEL}"]