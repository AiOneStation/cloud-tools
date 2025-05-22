#!/usr/bin/python
import subprocess
import os
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

def modify_line(filename,oldline,newline):
    f = open(filename, 'r+')
    lines = f.readlines()

    for i in range(len(lines)):
        if lines[i].find(oldline) >= 0:
            lines[i] = newline+'\n'
    f.seek(0)  #不要让python记住执行到这里，从文件头还始
    f.truncate()  #清空文件
    f.writelines(lines)
    f.close()

def exec_command(command):
    p = subprocess.Popen(command, shell=True,
                         stdout=subprocess.PIPE, universal_newlines=True)
    p.wait()
    msg=p.stdout.readlines()
    print(msg)
    return msg
print('start to passthrough')
gpu_id='10de:1eb8'
gpu_text = 'options vfio-pci ids='+gpu_id
filename = '/etc/modprobe.d/vfio.conf'
add_line(filename,gpu_text)
exec_command('update-initramfs -u')
modify_line('/etc/default/grub','GRUB_CMDLINE_LINUX_DEFAULT=','GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on vfio-pci.ids='+gpu_id+'"')
exec_command('update-grub')
blacktexts =  'blacklist snd_hda_intel\nblacklist amd76x_edac\nblacklist vga16fb\nblacklist nouveau\nblacklist rivafb\nblacklist nvidiafb\nblacklist rivatv\n'
add_line('/etc/modprobe.d/blacklist.conf',blacktexts)
modeltexts =  'pci_stub\nvfio\nvfio_iommu_type1\nvfio_pci\nkvm\nkvm_intel\n'
add_line('/etc/modules-load.d/modules.conf',modeltexts)
exec_command('echo'+ gpu_id + '> /sys/bus/pci/drivers/virtio-pci/new_id')

