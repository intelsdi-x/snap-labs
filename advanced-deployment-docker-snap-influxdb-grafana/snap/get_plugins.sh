#!/bin/bash

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for i in "snap-plugin-publisher-influxdb" "snap-plugin-collector-psutil"
do
(cd "${__dir}"/plugins && wget -O ${i} http://snap.ci.snap-telemetry.io/plugins/${i}/latest/linux/x86_64/${i} && chmod 755 ${i})
done
