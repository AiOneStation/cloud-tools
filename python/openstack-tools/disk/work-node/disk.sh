#!/bin/bash
parted /dev/nvme0n1 -s -- mklabel gpt \
    mkpart BEGIN_NVME0                   0%   128M \
    mkpart CEPH_BOOTSTRAP_BS_HDB_W       2G    17G \
    mkpart CEPH_BOOTSTRAP_BS_HDC_W      17G    32G \
    mkpart CEPH_BOOTSTRAP_BS_HDD_W      32G    47G \
    mkpart CEPH_BOOTSTRAP_BS_HDE_W      47G    62G \
    mkpart CEPH_BOOTSTRAP_BS_HDF_W      62G    77G \
    mkpart CEPH_BOOTSTRAP_BS_HDG_W      77G    92G \
    mkpart CEPH_BOOTSTRAP_BS_HDB_D      92G   242G \
    mkpart CEPH_BOOTSTRAP_BS_HDC_D     242G   392G \
    mkpart CEPH_BOOTSTRAP_BS_HDD_D     392G   542G \
    mkpart CEPH_BOOTSTRAP_BS_HDE_D     542G   692G \
    mkpart CEPH_BOOTSTRAP_BS_HDF_D     692G   842G \
    mkpart CEPH_BOOTSTRAP_BS_HDG_D     842G   992G \
    mkpart END_NVME0                   992G   100%

parted /dev/nvme1n1 -s -- mklabel gpt \
    mkpart BEGIN_NVME1                   0%   128M \
    mkpart CEPH_BOOTSTRAP_BS_HDH_W       2G    17G \
    mkpart CEPH_BOOTSTRAP_BS_HDI_W      17G    32G \
    mkpart CEPH_BOOTSTRAP_BS_HDJ_W      32G    47G \
    mkpart CEPH_BOOTSTRAP_BS_HDK_W      47G    62G \
    mkpart CEPH_BOOTSTRAP_BS_HDL_W      62G    77G \
    mkpart CEPH_BOOTSTRAP_BS_HDM_W      77G    92G \
    mkpart CEPH_BOOTSTRAP_BS_HDH_D      92G   242G \
    mkpart CEPH_BOOTSTRAP_BS_HDI_D     242G   392G \
    mkpart CEPH_BOOTSTRAP_BS_HDJ_D     392G   542G \
    mkpart CEPH_BOOTSTRAP_BS_HDK_D     542G   692G \
    mkpart CEPH_BOOTSTRAP_BS_HDL_D     692G   842G \
    mkpart CEPH_BOOTSTRAP_BS_HDM_D     842G   992G \
    mkpart END_NVME1                   992G   100%

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

