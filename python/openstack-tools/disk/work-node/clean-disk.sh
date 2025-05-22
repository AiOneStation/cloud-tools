#!/bin/bash
DISK=$1
# Zap the disk to a fresh, usable state (zap-all is important, b/c MBR has to be clean)
# You will have to run this step for all disks.
# sgdisk –zzap-all需要重启后才生效
sgdisk --zap-all $DISK
# Clean hdds with dd
dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync
partprobe $DISK

