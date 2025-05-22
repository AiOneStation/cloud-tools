#!/usr/bin/python
import subprocess
import os
import re

def find_line(filename,findline):
    findlines = set()
    if not os.path.exists(filename):
        return {}
    f = open(filename, "r")
    lines = f.readlines()
    for i in range(len(lines)):
        if lines[i].find(findline) >= 0:
            findlines.add(lines[i])
    f.close()
    return findlines


def add_line(filename,writeline):
    if not os.path.exists(filename):
        os.mknod(filename)
    f = open(filename, "r")
    writeable = True
    line = f.read()
    if line.find(writeline) >= 0:
        writeable = False
    if line:
        writeline = writeline
    f.close()
    if writeable:
        f = open(filename, "a")
        f.write(writeline)
        f.close()

def add_lines(filename,writelines):
    for i in writelines:
       add_line(filename,i+'\n')

def modify_line(filename,oldline,newline):
    f = open(filename, 'r+')
    lines = f.readlines()
    for i in range(len(lines)):
        if lines[i].find(oldline) >= 0:
            lines[i] = newline+'\n'
    f.seek(0)
    f.truncate()
    f.writelines(lines)
    f.close()

def exec_command(command):
    p = subprocess.Popen(command, shell=True,
                         stdout=subprocess.PIPE, universal_newlines=True)
    p.wait()
    msg=p.stdout.readlines()
    print(msg)
    return msg

print('start to pci passthrough')

modulesline = {'\nvfio_pci','vfio','nvfio_iommu_type1','vfio_virqfd'}
add_lines('d://test.txt', modulesline)



