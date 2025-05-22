#!/bin/bash

parted /dev/nvme0n1 -s -- mklabel gpt \
    mkpart BEGIN_NVME0                   0%   128M \
    mkpart CEPH_BOOTSTRAP_BS_HDA_W       2G    32G \
    mkpart CEPH_BOOTSTRAP_BS_HDB_W      32G    62G \
    mkpart CEPH_BOOTSTRAP_BS_HDC_W      62G    92G \
    mkpart CEPH_BOOTSTRAP_BS_HDA_D      92G   392G \
    mkpart CEPH_BOOTSTRAP_BS_HDB_D     392G   692G \
    mkpart CEPH_BOOTSTRAP_BS_HDC_D     692G   992G \
    mkpart END_NVME0                   992G   100%

parted /dev/nvme1n1 -s -- mklabel gpt \
    mkpart BEGIN_NVME1                   0%   128M \
    mkpart CEPH_BOOTSTRAP_BS_HDD_W       2G    32G \
    mkpart CEPH_BOOTSTRAP_BS_HDE_W      32G    62G \
    mkpart CEPH_BOOTSTRAP_BS_HDF_W      62G    92G \
    mkpart CEPH_BOOTSTRAP_BS_HDD_D      92G   392G \
    mkpart CEPH_BOOTSTRAP_BS_HDE_D     392G   692G \
    mkpart CEPH_BOOTSTRAP_BS_HDF_D     692G   992G \
    mkpart END_NVME1                   992G   100%

parted /dev/nvme2n1 -s -- mklabel gpt \
    mkpart BEGIN_NVME2                   0%   128M \
    mkpart CEPH_BOOTSTRAP_BS_HDG_W       2G    32G \
    mkpart CEPH_BOOTSTRAP_BS_HDH_W      32G    62G \
    mkpart CEPH_BOOTSTRAP_BS_HDJ_W      62G    92G \
    mkpart CEPH_BOOTSTRAP_BS_HDG_D      92G   392G \
    mkpart CEPH_BOOTSTRAP_BS_HDH_D     392G   692G \
    mkpart CEPH_BOOTSTRAP_BS_HDJ_D     692G   992G \
    mkpart END_NVME2                   992G   100%

parted /dev/nvme3n1 -s -- mklabel gpt \
    mkpart BEGIN_NVME3                   0%   128M \
    mkpart CEPH_BOOTSTRAP_BS_HDK_W       2G    32G \
    mkpart CEPH_BOOTSTRAP_BS_HDL_W      32G    62G \
    mkpart CEPH_BOOTSTRAP_BS_HDM_W      62G    92G \
    mkpart CEPH_BOOTSTRAP_BS_HDK_D      92G   392G \
    mkpart CEPH_BOOTSTRAP_BS_HDL_D     392G   692G \
    mkpart CEPH_BOOTSTRAP_BS_HDM_D     692G   992G \
    mkpart END_NVME3                   992G   100%


parted /dev/sda -s -- mklabel gpt \
    mkpart CEPH_BOOTSTRAP_BS_HDA     0% 128M \
    mkpart CEPH_BOOTSTRAP_BS_HDA_B 128M 100%

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

# I盘为系统盘，不能格式化

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


