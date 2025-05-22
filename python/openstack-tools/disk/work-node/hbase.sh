#!/bin/bash
list="sdl sdm sdk"
hostname=$(hostname)  
for i in $list;  
do
parted /dev/$i -s -- mklabel gpt \
  mkpart $hostname-${i}'1'     0% 50% \
  mkpart $hostname-${i}'2' 50% 100%   
done  
