#!/bin/bash
parted /dev/sdb -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDB     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDB_B 128M 100% 

parted /dev/sdc -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDC     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDC_B 128M 100% 

parted /dev/sdd -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDD     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDD_B 128M 100% 

parted /dev/sde -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDE     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDE_B 128M 100% 

parted /dev/sdf -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDF     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDF_B 128M 100% 

parted /dev/sdg -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDG     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDG_B 128M 100% 

parted /dev/sdh -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDH     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDH_B 128M 100% 

parted /dev/sdi -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDI     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDI_B 128M 100% 

parted /dev/sdj -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDJ     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDJ_B 128M 100% 

parted /dev/sdk -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDK     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDK_B 128M 100% 

parted /dev/sdl -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDL     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDL_B 128M 100% 

parted /dev/sdm -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDM     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDM_B 128M 100% 

parted /dev/sdn -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDN     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDN_B 128M 100% 

parted /dev/sdo -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDO     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDO_B 128M 100% 

parted /dev/sdp -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDP     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDP_B 128M 100% 

parted /dev/sdq -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDQ     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDQ_B 128M 100% 

parted /dev/sdr -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDR     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDR_B 128M 100% 

parted /dev/sds -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDS     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDS_B 128M 100% 

parted /dev/sdt -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDT     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDT_B 128M 100% 

parted /dev/sdu -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDU     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDU_B 128M 100% 

parted /dev/sdv -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDV     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDV_B 128M 100% 

parted /dev/sdw -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDW     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDW_B 128M 100% 

