#!/bin/bash
if [ $# -ne 3 ]; then
	echo "Usage: $0 project vm host"
	exit 1
fi

OS_PROJECT_NAME=$1
VM=$2
HOST=$3

echo Moving vm $VM to host $HOST
openstack server migrate --os-compute-api-version 2.56 --host $HOST $VM

