#!/usr/bin/python
import sys

if len(sys.argv) < 2:
    print('Usage: %s vm number' % sys.argv[0])
    sys.exit(-1)

vm = sys.argv[1]
hdd_num = int(sys.argv[2])
dev = 98

for i in range(hdd_num):
    print("LABEL=%s-%d\t/mnt/data%d\text4\tdefaults\t0\t0" % (vm, i, i))

print("")

for i in range(hdd_num):
    print("mkfs.ext4 -F /dev/sd%c" % (dev + i))
    print("e2label /dev/sd%c %s-%d" % (dev + i, vm, i))
    print("mkdir -p /mnt/data%d" % (i))
    print("")

print("sleep 1s")
print("lsblk -f")

