#!/bin/bash
swapoff -a
sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab
echo 4194303 > /proc/sys/kernel/pid_max
echo "128" > /sys/block/sda/queue/read_ahead_kb
echo 528283972 > /proc/sys/fs/file-max

if  grep -q scsi_mod.use_blk_mq=1 /etc/default/grub ;then
   sed -i 's/scsi_mod.use_blk_mq=1/scsi_mod.use_blk_mq=0/g' /etc/default/grub
   sed -i 's/dm_mod.use_blk_mq=y/dm_mod.use_blk_mq=n/g' /etc/default/grub
   update-grub
   reboot
else
   echo do not exec update-grub
fi


#for hdd in sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl
#do
#    echo "deadline" >/sys/block/${hdd}/queue/scheduler
    /sbin/blockdev --setra 8192 /dev/sda
    echo 512 > /sys/block/sda/queue/nr_requests
#done
