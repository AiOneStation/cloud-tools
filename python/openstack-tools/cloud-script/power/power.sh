#!/bin/bash
#  for i j in  `nova list --fields host --status active|awk -F " " '{print $2,$4}'`; 
#  do 
#      echo $j;
#  done;
declare -A mymap;
nova list --fields host --status active | awk '{print $2,$4}' | while read a b
do
mymap[$b]=$a
echo ----------------------------------
done
for key in ${!mymap[@]}
do
echo "${mymap[$key]}"
done
