#!/bin/bash
SITE=$1
echo ----------out  hostname is $SITE--------
ceph osd ls-tree $SITE | while read c
do
  ceph osd tree | grep osd.$c | awk '{print $4,$5}' | while read a b
  do
    if [[ "osd.$c" == $a && $b == down ]]; then
      echo ceph osd out $a
      echo ceph osd crush remove $a
      echo ceph auth del $a
      echo ceph osd rm $a
    elif [[ "osd.$c" == $a && $b == up ]]; then
      echo  error --- $a is $b --- error
    fi
  done
done

echo ---------------------------


