#!/bin/bash
if [ $# -ne 7 ]; then
	echo "Usage: $0 PROJECT VM_FORMAT VM_INDEX VM_COUNT HOST_FORMAT HOST_INDEX HOST_COUNT"
	echo "Examples:"
	echo "    $0 mbd mbd3-node%02d 1 19 dc3-n0%02d 81 19"
	exit 1
fi

OS_PROJECT_NAME=$1
VM_FORMAT=$2
VM_INDEX=$3
VM_COUNT=$4
HOST_FORMAT=$5
HOST_INDEX=$6
HOST_COUNT=$7

for ((i=0; i<$VM_COUNT; i++)); do
	let host_id=$HOST_INDEX+$i
        host=$(printf "$HOST_FORMAT" $host_id)
	let vm_id=$VM_INDEX+$i
	vm=$(printf "$VM_FORMAT" $vm_id)
	echo Moving $vm to $host...
	openstack server migrate --os-compute-api-version 2.56 --host $host $vm;
done
