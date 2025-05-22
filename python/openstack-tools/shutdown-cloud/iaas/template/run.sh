#!/bin/sh
## docker build -t push.fzyun.io/kolla/monitor:v1.1 .
docker pull docker.fzyun.io/kolla/monitor:v1.2
VAR="br0"
HOST_IP=$(ifconfig $VAR | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}')
echo $HOST_IP
if docker ps | grep  libvirt_monitor; then
    echo "镜像已经启动"
    exit
fi

docker run -d --network=host --volume=/sys:/host/sys:ro --volume=/proc:/host/proc:ro --volume=/host/sys --volume=/host/proc --restart=always -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro -v /var/run/libvirt:/var/run/libvirt:ro --name libvirt_monitor docker.fzyun.io/kolla/monitor:v1.2 --libvirturi qemu+tcp://$HOST_IP/system --dburi 'root:aPuYeuVwqhrwTJTIpNtXAvYjzbNow0mN0RJUP0xl@tcp(mysql.testcs.fzyun.io:3306)/flow_monitor?charset=utf8'

#'root:aPuYeuVwqhrwTJTIpNtXAvYjzbNow0mN0RJUP0xl@tcp(mysql.testcs.fzyun.io:3306)/flow_monitor?charset=utf8'
#'monit:Founder@monit88@tcp(mysql1.fzyun.io:3306)/monit?charset=utf8'
