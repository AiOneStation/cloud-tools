#!/usr/bin/python

import subprocess
import sys
import json

if len(sys.argv) < 2:
    print('Usage: %s volume_id' % sys.argv[0])
    sys.exit(-1)


volume = sys.argv[1]

print('Change volume %s in use:' % volume)

subprocess.call(["cinder","reset-state","--state","in-use",volume])

subprocess.call(["cinder","reset-state","--reset-migration-status",volume])

subprocess.call(["cinder","reset-state","--attach-status","attached",volume])


