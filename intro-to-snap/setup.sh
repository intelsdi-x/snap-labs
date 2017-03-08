#!/bin/bash

set -e
set -u
set -o pipefail

_error() {
  echo "${*}" 1>&2 || true; exit 1;
}

_verify_docker() {
  type -p docker > /dev/null 2>&1 || _error "docker needs to be installed"
  type -p docker-compose > /dev/null 2>&1 || _error "docker-compose needs to be installed"
  docker version >/dev/null 2>&1 || _error "docker needs to be configured/running"
}

_verify_docker
echo 'building lab ...'
docker-compose build
echo 'launching lab ...'
docker-compose up -d
echo
echo 'When you are done with the lab execute:'
echo '"docker-compose down"'
