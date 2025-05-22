#!/usr/bin/python
from __future__ import print_function

import subprocess
import os


disksmap = {}
vmsmap = {}
projectmap = {}
disks  = subprocess.check_output(["cinder","list","--all-tenants"])
for disk in disks.splitlines():
    disk_attrs=disk.split("|")
    if len(disk_attrs) > 6 and disk_attrs[1].find("ID") == -1:
       #print(disks)
       disk_size = int(disk_attrs[5]) 
       ## print(disk_attrs[7])
       vm_id = disk_attrs[8]
       if disksmap.get(vm_id) is None:
          disksmap.setdefault(vm_id,disk_size)
       else:
          disksmap.update({vm_id:disksmap.get(vm_id)+disk_size})          
disksmap.update({"ID":"DISK_SIZE"})

projects  = subprocess.check_output(["openstack","project","list"])
for project in projects.splitlines():
    project_attrs=project.split("|")
    if len(project_attrs) >= 2:
       project_id = project_attrs[1]
       project_name = project_attrs[2]
       projectmap.setdefault(project_id,project_name)

vms  = subprocess.check_output(["nova","list", "--fields","name,tenant_id,flavor:vcpus,flavor:ram,networks","--all-tenants"])
for vm in vms.splitlines():
    lines = vm.split("|")
    for line in lines:
       if projectmap.get(line) is None:
          print(line,end="|")
       else:
          print(projectmap.get(line),end="|")
    if len(lines) > 2:
       print(disksmap.get(lines[1]))
      # print(lines[1])



