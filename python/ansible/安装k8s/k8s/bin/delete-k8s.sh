#! /bin/bash
# 停止相关服务
kubeadm reset -f

systemctl stop kubelet etcd
#删除所有容器
crictl rm -f `crictl ps -aq`
# 删除/var/lib/kubelet/目录，删除前先卸载，否则会删除不干净
for m in $(sudo tac /proc/mounts | sudo awk '{print $2}'|sudo grep /var/lib/kubelet);do
	  sudo umount $m||true
  done
  rm -rf /var/lib/kubelet/
  #删除/run/kubernetes/ 目录
  rm -rf /run/kubernetes/
#
apt remove -y  kubelet kubectl kubeadm kubernetes-cni --allow-change-held-packages
apt remove -y containerd.io
apt autoremove -y
rm -rf /var/lib/etcd
rm -rf /var/lib/kubelet
rm -rf /var/lib/calico
rm -rf /data/etcd
rm -rf /opt/cni
rm -rf /var/etcd/calico-data
rm -rf /usr/local/bin/Documentation
rm -rf /root/.kube
rm -rf /etc/cni/net.d
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /etc/cni/
rm -rf /etc/kubernetes
rm -rf $HOME/.kube/config
rm -rf /usr/libexec/kubernetes
rm -rf /etc/containerd/

# 这边有个坑，转发规则如果不清除，导致新的网络不通
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
ipvsadm -C

#删除网络配置

ifconfig cni0 down
ifconfig tunl0 down
ip link delete cni0

apt clean all
systemctl daemon-reload
systemctl reset-failed

# 删除系统参数
sudo rm -rf /etc/modules-load.d/kubernetes.conf
sudo rm -rf /etc/modules-load.d/containerd.conf
sudo rm -rf /etc/sysctl.d/kubernetes.conf
