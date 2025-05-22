#!/usr/bin/python

hdd_num = 12
nvme_num = 2
disk_size = 128 # MB
wal_size = 20 # GB
db_size = 85 # GB

p = disk_size
print("parted /dev/nvme0n1 -s -- mklabel gpt \\")
print("    mkpart BEGIN_NVME0                   0%  128M \\")
for i in range(hdd_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_HD%c      %4dM  %4dM \\" % (i + 66, p, p + disk_size))
    p += disk_size

p= 2
for i in range(hdd_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_HD%c_W    %4dG  %4dG \\" % (i + 66, p, p + wal_size))
    p += wal_size
print("    mkpart END_NVME0                  %4dG  100%% \\" % (p))


p = 2
print("parted /dev/nvme1n1 -s -- mklabel gpt \\")
print("    mkpart BEGIN_NVME1                   0%  128M \\")
for i in range(hdd_num):
    print("    mkpart CEPH_BOOTSTRAP_BS_HD%c_D    %4dG  %4dG \\" % (i + 66, p, p + db_size))
    p += db_size
print("    mkpart END_NVME1                  %4dG  100%% \\" % (p))



for i in range(hdd_num):
    print("parted /dev/sd%c -s -- mklabel gpt mkpart CEPH_BOOTSTRAP_BS_HD%c_B 0%% 100%%" % (i + 98, i + 66))

print("")

