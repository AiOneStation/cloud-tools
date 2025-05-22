#!/usr/bin/python
import subprocess
import os

hosts = {}
vms = {}
command = 'nova stop '
p = subprocess.Popen("nova list  --all-tenants --fields host --status active | awk '{print $2,$4}'",shell = True,
        stdout=subprocess.PIPE, universal_newlines=True)
p.wait()
result_lines = p.stdout.readlines()

for line in result_lines:
 if line.find("-")>0:
     lines = line.split(" ", 1)
     groups = hosts.get(lines[1])

     groups
     if groups is None:
         groups = 1;
         hosts.setdefault(lines[1], groups)
     else:
         groups = groups + 1;
         hosts.update({lines[1]:groups})
     if vms.get(groups) is None:
        vms.setdefault(groups, command +lines[0])
     else:
        vms.update({groups:vms.get(groups)+"&"+command +lines[0]})

for key in vms:
    print (key, ' value : ', vms[key])
    p = subprocess.Popen(vms[key], shell=True,
                         stdout=subprocess.PIPE, universal_newlines=True)
    p.wait()

