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

create_volume_type ebs-g1 "弹性存储-g1 (高效云盘)"      rbd-1     public     3000   120000000
create_volume_type ebs-g2 "弹性存储-g2 (高效云盘x2)"    rbd-1     public     6000   240000000
create_volume_type ebs-g3 "弹性存储-g3 (高效云盘x3)"    rbd-1     private    9000   360000000
create_volume_type ebs-g4 "弹性存储-g4 (高效云盘x4)"    rbd-1     private   12000   480000000
create_volume_type ebs-g5 "弹性存储-g5 (高效云盘x5)"    rbd-1     private   15000   600000000
create_volume_type ebs-g6 "弹性存储-g6 (高效云盘x6)"    rbd-1     private   18000   720000000
create_volume_type ebs-g7 "弹性存储-g7 (高效云盘x7)"    rbd-1     private   21000   840000000
create_volume_type ebs-g8 "弹性存储-g8 (高效云盘x8)"    rbd-1     private   24000   960000000
create_volume_type ebs-g9 "弹性存储-g9 (高效云盘x9)"    rbd-1     private   27000  1200000000

create_volume_type ebs-s1 "弹性存储-s1 (SSD云盘)"       rbd-ssd   private   20000   120000000
create_volume_type ebs-s2 "弹性存储-s2 (SSD云盘x2)"     rbd-ssd   private   40000   240000000
create_volume_type ebs-s3 "弹性存储-s3 (SSD云盘x3)"     rbd-ssd   private   60000   360000000
create_volume_type ebs-s4 "弹性存储-s4 (SSD云盘x4)"     rbd-ssd   private   80000   480000000
create_volume_type ebs-s5 "弹性存储-s5 (SSD云盘x5)"     rbd-ssd   private  100000   600000000
create_volume_type ebs-s6 "弹性存储-s6 (SSD云盘x6)"     rbd-ssd   private  120000   720000000
create_volume_type ebs-s7 "弹性存储-s7 (SSD云盘x7)"     rbd-ssd   private  140000   840000000
create_volume_type ebs-s8 "弹性存储-s8 (SSD云盘x8)"     rbd-ssd   private  160000   960000000
create_volume_type ebs-s9 "弹性存储-s9 (SSD云盘x9)"     rbd-ssd   private  180000  1200000000

create_volume_type ebs-n1 "弹性存储-n1 (NVME云盘)"      rbd-nvme  private   40000   120000000
create_volume_type ebs-n2 "弹性存储-n2 (NVME云盘x2)"    rbd-nvme  private   80000   240000000
create_volume_type ebs-n3 "弹性存储-n3 (NVME云盘x3)"    rbd-nvme  private  120000   360000000
create_volume_type ebs-n4 "弹性存储-n4 (NVME云盘x4)"    rbd-nvme  private  160000   480000000
create_volume_type ebs-n5 "弹性存储-n5 (NVME云盘x5)"    rbd-nvme  private  200000   600000000
create_volume_type ebs-n6 "弹性存储-n6 (NVME云盘x6)"    rbd-nvme  private  240000   720000000
create_volume_type ebs-n7 "弹性存储-n7 (NVME云盘x7)"    rbd-nvme  private  280000   840000000
create_volume_type ebs-n8 "弹性存储-n8 (NVME云盘x8)"    rbd-nvme  private  320000   960000000
create_volume_type ebs-n9 "弹性存储-n9 (NVME云盘x9)"    rbd-nvme  private  360000  1200000000

create_volume_type ibs-s1 "实例存储-s1 (SSD本地盘)"     lvm-ssd   private   20000   200000000
create_volume_type ibs-s2 "实例存储-s2 (SSD本地盘x2)"   lvm-ssd   private   40000   400000000
create_volume_type ibs-s3 "实例存储-s3 (SSD本地盘x3)"   lvm-ssd   private   60000   600000000
create_volume_type ibs-s4 "实例存储-s4 (SSD本地盘x4)"   lvm-ssd   private   80000   800000000
create_volume_type ibs-s5 "实例存储-s5 (SSD本地盘x5)"   lvm-ssd   private  100000  1000000000
create_volume_type ibs-s6 "实例存储-s6 (SSD本地盘x6)"   lvm-ssd   private  120000  1200000000
create_volume_type ibs-s7 "实例存储-s7 (SSD本地盘x7)"   lvm-ssd   private  140000  1400000000
create_volume_type ibs-s8 "实例存储-s8 (SSD本地盘x8)"   lvm-ssd   private  160000  1600000000
create_volume_type ibs-s9 "实例存储-s9 (SSD本地盘x9)"   lvm-ssd   private  180000  1800000000

create_volume_type ibs-n1 "实例存储-n1 (NVME本地盘)"    lvm-nvme  private   40000   400000000
create_volume_type ibs-n2 "实例存储-n2 (NVME本地盘x2)"  lvm-nvme  private   80000   800000000
create_volume_type ibs-n3 "实例存储-n3 (NVME本地盘x3)"  lvm-nvme  private  120000  1200000000
create_volume_type ibs-n4 "实例存储-n4 (NVME本地盘x4)"  lvm-nvme  private  160000  1600000000
create_volume_type ibs-n5 "实例存储-n5 (NVME本地盘x5)"  lvm-nvme  private  200000  2000000000
create_volume_type ibs-n6 "实例存储-n6 (NVME本地盘x6)"  lvm-nvme  private  240000  2400000000
create_volume_type ibs-n7 "实例存储-n7 (NVME本地盘x7)"  lvm-nvme  private  280000  2800000000
create_volume_type ibs-n8 "实例存储-n8 (NVME本地盘x8)"  lvm-nvme  private  320000  3200000000
create_volume_type ibs-n9 "实例存储-n9 (NVME本地盘x9)"  lvm-nvme  private  360000  3600000000

