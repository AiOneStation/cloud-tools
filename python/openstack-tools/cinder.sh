#!/bin/bash
set -ex

function create_volume_type() {
    local name=$1
    local description=$2
    local backend=$3
    local visibility=$4
    local limit_iops=$5
    local limit_bytes=$6

    openstack volume type create $name \
        --description "$description" \
        --property volume_backend_name=$backend \
        --$visibility

    openstack volume qos create $name-qos \
        --consumer "front-end" \
        --property "read_iops_sec=$limit_iops" \
        --property "write_iops_sec=$limit_iops" \
        --property "read_bytes_sec=$limit_bytes" \
        --property "write_bytes_sec=$limit_bytes"

    openstack volume qos associate $name-qos $name
}

function update_volume_type() {
    local name=$1
    local description=$2
    local backend=$3
    local visibility=$4
    local limit_iops=$5
    local limit_bytes=$6

    openstack volume qos set $name-qos \
        --property "read_iops_sec=$limit_iops" \
        --property "write_iops_sec=$limit_iops" \
        --property "read_bytes_sec=$limit_bytes" \
        --property "write_bytes_sec=$limit_bytes"
}

update_volume_type ibs-n3 "实例存储-n3 (NVME本地盘x3)"  lvm-nvme  private  500000  5000000000
update_volume_type ibs-n2 "实例存储-n2 (NVME本地盘x2)"  lvm-nvme  private  200000  2000000000
update_volume_type ibs-n1 "实例存储-n1 (NVME本地盘)"    lvm-nvme  private  100000  1000000000

update_volume_type ibs-s3 "实例存储-s3 (SSD本地盘x3)"   lvm-ssd   private  200000  2000000000
update_volume_type ibs-s2 "实例存储-s2 (SSD本地盘x2)"   lvm-ssd   private  100000  1000000000
update_volume_type ibs-s1 "实例存储-s1 (SSD本地盘)"     lvm-ssd   private   50000   500000000

update_volume_type ebs-n3 "弹性存储-n3 (NVME云盘x3)"    rbd-nvme  private  500000  4000000000
update_volume_type ebs-n2 "弹性存储-n2 (NVME云盘x2)"    rbd-nvme  private  200000  2000000000
update_volume_type ebs-n1 "弹性存储-n1 (NVME云盘)"      rbd-nvme  private   50000  1000000000

update_volume_type ebs-s3 "弹性存储-s3 (SSD云盘x3)"     rbd-ssd   private  180000  2000000000
update_volume_type ebs-s2 "弹性存储-s2 (SSD云盘x2)"     rbd-ssd   private   60000  1000000000
update_volume_type ebs-s1 "弹性存储-s1 (SSD云盘)"       rbd-ssd   private   20000   500000000

update_volume_type ebs-g3 "弹性存储-g3 (高效云盘x3)"    rbd-1     private   20000   800000000
update_volume_type ebs-g2 "弹性存储-g2 (高效云盘x2)"    rbd-1     public    10000   400000000
update_volume_type ebs-g1 "弹性存储-g1 (高效云盘)"      rbd-1     public     5000   200000000

