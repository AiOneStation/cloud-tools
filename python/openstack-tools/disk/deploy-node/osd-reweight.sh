#!/bin/bash
SITE=$1
echo ----------reweight hostname is $SITE--------
ceph osd ls-tree $SITE | while read a
do
    echo ceph osd crush reweight  osd.$a 0
done


