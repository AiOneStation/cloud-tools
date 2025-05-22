#!/bin/bash
DISK=$1
# Zap the disk to a fresh, usable state (zap-all is important, b/c MBR has to be clean)
# You will have to run this step for all disks.
sgdisk --zap-all $DISK
# Clean disks such as ssd with blkdiscard instead of dd
blkdiscard $DISK
partprobe $DISK

