#! /bin/bash
#install epel
sudo dnf install epel-release -y   #https://mirrors.tuna.tsinghua.edu.cn/help/epel/
sudo dnf update -y


#install docker and docker-compose
sudo dnf config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
#please update the containerd version if there is new available
cd /tmp && wget https://download.docker.com/linux/centos/7/x86_64/edge/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo dnf install containerd.io-1.2.6-3.3.el7.x86_64.rpm -y
sudo dnf install -y docker-ce #--nobest
sudo mkdir /etc/docker/
FILE="/etc/docker/daemon.json"
/bin/cat <<EOF >$FILE
{
  "registry-mirrors" : [
    "http://registry.docker-cn.com",
    "http://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ],
  "insecure-registries" : [
    "registry.docker-cn.com",
    "docker.mirrors.ustc.edu.cn"
  ],
  "debug" : true,
  "experimental" : true
}
EOF

#systemctl daemon-reload

# set current user into docker group
sudo usermod -aG docker $USER
#enable and start docker service 
sudo systemctl enable --now docker

#get latest docker-compose version
sudo dnf install jq
LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')

echo "Enter Root password for install docker-compose"
sudo -i << EOF
curl -L https://get.daocloud.io/docker/compose/releases/download/$LATEST_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
EOF


#install pip3
sudo dnf install python3-pip
sudo pip3 install docker -i https://pypi.tuna.tsinghua.edu.cn/simple
sudo pip3 install docker-compose -i https://pypi.tuna.tsinghua.edu.cn/simple


#disable firewalld
systemctl stop firewalld && systemctl disable firewalld #&& sudo reboot

#or enable firewalld with allow HTTP protocol <- did not work
#sudo firewall-cmd --add-service=http --permanent
#sudo firewall-cmd --add-service=https --permanent



#install ansible and awx
sudo dnf install -y ansible
cd /tmp && git clone https://gitee.com/mirrors/Ansible-AWX.git
#scp "D:\Users\Public\Downloads\awx-9.2.0.tar.gz" admin@192.168.1.82:/tmp
#cd /tmp && tar -xvzf awx-9.2.0.tar.gz


/bin/cat <<EOF > /tmp/awx-9.2.0/installer/new-inventory
localhost ansible_connection=local ansible_python_interpreter="/usr/bin/env python3"
[all:vars]
dockerhub_base=ansible
awx_task_hostname=awx
awx_web_hostname=awxweb
postgres_data_dir="/var/lib/pgdocker"
host_port="80"
host_port_ssl="443"
docker_compose_dir="/var/lib/awx/"
pg_username=awx
pg_password=awxpass
pg_database=awx
pg_port="5432"
rabbitmq_password=awxpass
rabbitmq_erlang_cookie=cookiemonster
admin_user=admin
admin_password=password
create_preload_data=True
secret_key=awxsecret
awx_official=true
project_data_dir="/var/lib/awx/projects"
EOF


#sudo ansible-playbook -i /tmp/inventory install.yml
sudo ansible-playbook -i /tmp/awx-9.2.0/installer/new-inventory /tmp/awx-9.2.0/installer/install.yml
