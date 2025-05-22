     name: 在ansible的执行路径执行命令
      shell:
        cmd: cp bin/helm /usr/local/bin/
        executable: /bin/bash
        chdir: "{{ lookup('env', 'PWD') }}"
      when:
        - inventory_hostname == groups['k8smaster']|first

从每一个task开始
ansible-playbook playbook.yml --start-at="install packages"
ansible-playbook yml/run-k8s.yml -i  /etc/fzyun/rooks --start-at="install packages"