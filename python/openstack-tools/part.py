#!/usr/bin/python
import sys

if len(sys.argv) < 2:
    print('Usage: %s hdd nvme' % sys.argv[0])
    sys.exit(-1)

hdd_num = int(sys.argv[1])
nvme_num = int(sys.argv[2])
disk_size = 128 # MB
wal_size = 30 # GB
db_size = 300 # GB

group = hdd_num / nvme_num
h = 66
for i in range(nvme_num):
    print("parted /dev/nvme%dn1 -s -- mklabel gpt \\" % i)
    # print("    mkpart CEPH_BOOTSTRAP_BS_NVME%d       0%%  %4dM \\" % (i, disk_size))
    print("    mkpart BEGIN_NVME%d                   0%%  %4dM \\" % (i, disk_size))

    p = 2
    for j in range(group):
        print("    mkpart CEPH_BOOTSTRAP_BS_HD%c_W    %4dG  %4dG \\" % (h + j, p, p + wal_size))
        p += wal_size

    for j in range(group):
        print("    mkpart CEPH_BOOTSTRAP_BS_HD%c_D    %4dG  %4dG \\" % (h + j, p, p + db_size))
        p += db_size

    # print("    mkpart CEPH_BOOTSTRAP_BS_NVME%d_B  %4dG   100%%\n" % (i, p))
    print("    mkpart END_NVME%d                  %4dG   100%%\n" % (i, p))
    h += group

for i in range(hdd_num):
    print("parted /dev/sd%c -s -- mklabel gpt \\" % (i + 98))
    print("    mkpart CEPH_BOOTSTRAP_BS_HD%c     0%% %dM \\" % (i + 66, disk_size))
    print("    mkpart CEPH_BOOTSTRAP_BS_HD%c_B %dM 100%% \n" % (i + 66, disk_size))

