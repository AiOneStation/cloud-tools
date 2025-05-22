#删除因为安装失败，而出现的多余osd
#!/bin/bash
SITE=$1

cat overage.txt | awk '{print $3,$4}' | while read a b
do
  if [[ $a == *osd* && $b == down ]]; then
    echo ceph osd out $a
    echo ceph osd crush remove $a
    echo ceph auth del $a
    echo ceph osd rm $a
  elif [[ $b == up ]]; then
    echo  error --- $a is $b --- error
    exit
  else
    echo --- hostname is  $a
  fi
done

echo ---------------------------


