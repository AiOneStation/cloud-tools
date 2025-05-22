获取hosts文件里面所有主机
hosts=$(ansible all  --list-hosts -i  /etc/fzyun/rooks)
获取主机组中的主机
ansible k8smaster[0]  --list-hosts -i  /etc/fzyun/rooks
获取hosts文件里面变量
BK_DOMAIN=$(ansible k8smaster  -m debug -a "var=domain"  -i  /etc/fzyun/hosts)
BK_DOMAIN=$(echo $BK_DOMAIN|grep "domain"| xargs -d \" |awk  'NR==1{ print $(NF-1)}')
