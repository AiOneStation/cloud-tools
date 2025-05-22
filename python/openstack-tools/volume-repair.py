#!/usr/bin/python

import subprocess
import sys
import json

filters = sys.argv[1:]

ret = subprocess.check_output(["openstack", "volume", "list", "--format", "json"] + filters)
volumes = json.loads(ret)

for v in volumes:
    image = "volumes/volume-" + v["ID"]
    print("Repairing {0} ({1})".format(image, v["Name"]))
    subprocess.call(["rbd", "feature", "disable", image, "exclusive-lock", "object-map", "fast-diff", "deep-flatten"])

