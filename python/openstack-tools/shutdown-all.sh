#!/bin/bash
SERVERS=$(openstack server list --all-projects --format value --column ID --status ACTIVE)
echo Stopping $SERVERS ...
openstack server stop $SERVERS

