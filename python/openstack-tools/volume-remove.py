#!/usr/bin/python

import subprocess
import sys
import json

if len(sys.argv) < 2:
    print('Usage: %s volume_id' % sys.argv[0])
    sys.exit(-1)


volume = sys.argv[1]

user_input = raw_input("confim to delete volume "+volume+" (y/n) :")

if user_input.lower() != 'y':
   sys.exit(-1)


print('Delete volume %s:' % volume)

subprocess.call(["cinder", "reset-state","--state", "available", volume])

subprocess.call(["cinder","reset-state", "--reset-migration-status", volume])

subprocess.call(["cinder","reset-state", "--attach-status", "detached", volume])

subprocess.call(["openstack", "volume", "delete", volume])

