#!/bin/bash
set -ex

function create_pool() {
    local name=$1
    local ruleset=$2
    ceph osd pool create $name 8 8 replicated $ruleset
    ceph osd pool application enable $name rbd
}

create_pool rbd disks
create_pool rbd-ssd ssd
create_pool rbd-nvme nvme
create_pool volumes-ssd ssd
create_pool volumes-nvme nvme

