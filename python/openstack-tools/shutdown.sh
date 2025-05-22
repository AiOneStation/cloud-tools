#!/bin/bash
HOST=$1
echo Stopping vms on $1...
SERVERS=$(openstack server list --host $HOST --all-projects --format value --column ID)
openstack server stop $SERVERS


