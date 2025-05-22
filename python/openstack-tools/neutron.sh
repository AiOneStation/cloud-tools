#!/bin/bash
set -ex

function create_network() {
    local name=$1
    local bandwidth=$2
    shift 2
    openstack network qos policy create $name "$@"
    openstack network qos rule create --type bandwidth-limit --max-kbps $bandwidth --egress $name
    openstack network qos rule create --type bandwidth-limit --max-kbps $bandwidth --ingress $name
}

create_network default-qos 2048888 --share --default
create_network service-qos 10248888 --share

