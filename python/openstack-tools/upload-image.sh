#!/bin/bash
openstack image create $1 \
    --file $2 \
    --disk-format raw \
    --container-format bare \
    --property hw_disk_bus=scsi \
    --property hw_scsi_models=virtio-scsi \
    --property hw_video_model=qxl \
    --property hw_qemu_guest_agent=yes \
    --property os_require_quiesce=yes \
    --public

