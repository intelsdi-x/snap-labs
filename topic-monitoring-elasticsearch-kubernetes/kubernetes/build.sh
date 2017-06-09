#!/bin/sh

set -e
set -u


cmd="docker build -t candysmurfhub/snap-es-mon-k8s:latest"

${cmd} -f "snap-elasticsearch-monitor/Dockerfile" .
