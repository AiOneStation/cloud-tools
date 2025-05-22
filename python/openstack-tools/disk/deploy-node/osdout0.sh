#!/bin/bash
SITE=$1

cat $SITE.txt | awk '{print $4}' | while read a
do
  if [[ $a == *osd* ]]; then
    echo ceph osd out $a
    echo ceph osd crush remove $a
    echo ceph auth del $a
    echo ceph osd rm $a
  else
    echo --- hostname is  $a
  fi
done


