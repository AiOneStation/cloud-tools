#!/bin/bash

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg --insecure| sudo apt-key add -
echo 'deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

#部署节点按照kubectl
apt update
apt install -y kubectl=1.24.8-00
install -d  /root/.kube

#部署kubernetes
ansible-playbook yml/run-k8s.yml -i  /etc/fzyun/rooks
#使用kubectl
chown $(id -u):$(id -g) /root/.kube/config
#kubectl命令补全
crictl completion > /etc/bash_completion.d/crictl
kubectl completion bash > /etc/bash_completion.d/kubectl
kubeadm completion bash > /etc/bash_completion.d/kubeadm
grep 'source /usr/share/bash-completion/bash_completion' $HOME/.bashrc || echo 'source /usr/share/bash-completion/bash_completion' >> $HOME/.bashrc
#安装helm
cp bin/helm /usr/local/bin/
bin/krew-linux_amd64 install krew
chmod 755 /usr/local/bin//helm
cp ~/.krew/bin/kubectl-krew /usr/local/bin
kubectl krew install rook-ceph
cp ~/.krew/bin/kubectl-rook_ceph /usr/local/bin

#创建网络
kubectl create -f yml/calico.yaml

#master节点取消污点
kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-
kubectl taint nodes --all node-role.kubernetes.io/master:NoSchedule-
