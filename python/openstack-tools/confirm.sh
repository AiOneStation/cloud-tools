#!/bin/bash
echo 'Confirm all VERIFY_RESIZE servers'
for i in `openstack server list --all-projects | grep VERIFY_RESIZE | awk -F " " '{print $2}'`; do echo Confirm $i ...; openstack server resize confirm $i; done
