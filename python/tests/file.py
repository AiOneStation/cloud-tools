#coding:utf-8
#!/usr/bin/python
# Filename: map.py

import os
import re




line='SAS Address(1): 0x500056b36789abeb'
#line = "Cats are smarter than dogs"


# matchObj = re.search(r'10de:[0-9a-z]*', line)
if re.match(r"SAS Address[(]0[)]:*", line.strip()):
    sas = line.split(":")[1].strip()
    print(sas)

print('end')
# if matchObj:
#    print("matchObj.group() : ", matchObj.group())
#    gpu_id = matchObj.group().split(":")
#    print(gpu_id[0])
#    print(gpu_id[1])
#
# line = ''
# if line:
#     print('11111')