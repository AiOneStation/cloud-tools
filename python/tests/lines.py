#!/usr/bin/python

import sys,os
f=open('data.txt','r+')

lines=f.readlines()

for i in range(len(lines)):
    if lines[i].find('test1')>=0:
        lines[i] = 'test-new\n'
f.seek(0)#不要让python记住执行到这里，从文件头还始
f.truncate()#清空文件
f.writelines(lines)
f.close()