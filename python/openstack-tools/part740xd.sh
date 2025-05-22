#!/usr/bin/python

hdd_num = 16
nvme_num = 2
disk_size = 96 # MB
wal_size = 2 # GB
db_size = 49 # GB

p = disk_size
print("parted /dev/nvme0n1 -s -- mklabel gpt \\")
for i in range(hdd_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_SSD%c     %4dM  %4dM \\" % (i + 65, p, p + disk_size))
    p += disk_size
for i in range(nvme_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_NVME%d    %4dM  %4dM \\" % (i, p, p + disk_size))
    p += disk_size

p = 2
for i in range(hdd_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_SSD%c_W   %4dG  %4dG \\" % (i + 65, p, p + wal_size))
    p += wal_size
for i in range(nvme_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_NVME%d_W  %4dG  %4dG \\" % (i, p, p + wal_size))
    p += wal_size

p = 40
print("    mkpart CEPH_BOOTSTRAP_BS_NVME0_B  %4dG   100%%\n" % p)

p = 0
print("parted /dev/nvme1n1 -s -- mklabel gpt \\")
for i in range(hdd_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_SSD%c_D   %4dG  %4dG \\" % (i + 65, p, p + db_size))
    p += db_size

print("    mkpart CEPH_BOOTSTRAP_BS_NVME1_B  %4dG   100%%\n" % p)

for i in range(hdd_num):
    print("parted /dev/sd%c -s -- mklabel gpt mkpart CEPH_BOOTSTRAP_BS_SSD%c_B 0%% 100%%" % (i + 97, i + 65))

print("")

#i = hdd_num + 1
#print("pvcreate /dev/sd%c" % (i + 97))
#print("vgcreate cinder-lvm-ssd /dev/sd%c" % (i + 97))
#print("vgdisplay\n")

