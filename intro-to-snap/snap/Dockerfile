FROM intelsdi/snap:xenial_test

RUN apt-get update && \
    apt-get install -y bzip2 sysstat jq less tree vim || apt-get install -y -o Acquire::http::No-Cache=True -o Acquire::BrokenProxy=true bzip2 sysstat jq less tree vim

ADD https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-psutil/8/linux/x86_64/snap-plugin-collector-psutil /opt/snap/plugins/
ADD https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-psutil/latest/linux/x86_64/snap-plugin-collector-psutil /tmp/
ADD https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io/plugins/snap-plugin-publisher-file/latest/linux/x86_64/snap-plugin-publisher-file /opt/snap/plugins/
ADD https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io/plugins/snap-plugin-publisher-influxdb/latest/linux/x86_64/snap-plugin-publisher-influxdb /opt/snap/plugins/

RUN chmod 755 /opt/snap/plugins/*

COPY psutil-influxdb-http.yml /opt/snap/tasks/
