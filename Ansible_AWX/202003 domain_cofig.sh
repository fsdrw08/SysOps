#! /bin/bash
#run this script after AWX installed
#install pywinrm in awx_task and awx_web
docker exec -it $(docker ps -aqf "name=awx_task") pip3 install pywinrm -i http://mirrors.aliyun.com/pypi/simple/ #--trusted-host mirrors.aliyun.com
docker exec -it $(docker ps -aqf "name=awx_web") pip3 install pywinrm -i http://mirrors.aliyun.com/pypi/simple/ #--trusted-host mirrors.aliyun.com

#modify resolv.conf to let awx know the DC
docker exec -it $(docker ps -aqf "name=awx_task") /bin/cat <<EOF >> /etc/resolv.conf
xx.xxx.xx.xxx domaincontroller.company.com domaincontroller
EOF
docker exec -it $(docker ps -aqf "name=awx_web") /bin/cat <<EOF >> /etc/resolv.conf
xx.xxx.xx.xxx domaincontroller.company.com domaincontroller
EOF

#modify /etc/krb5.conf
docker exec -it $(docker ps -aqf "name=awx_task") cp /etc/krb5.conf /etc/krb5.conf.bak
docker exec -it $(docker ps -aqf "name=awx_task") sed '1,17!d' /etc/krb5.conf
docker exec -it $(docker ps -aqf "name=awx_task") /bin/cat << EOF >> /etc/krb5.conf
    default_realm = COMPANY.COM
    default_ccache_name = KEYRING:persistent:%{uid}

[realms]
  COMPANY.COM = {
     kdc = DC.company.com
     admin_server = DC.company.com
  }

[domain_realm]
  company.com = COMPANY.COM
  .company.com = COMPANY.COM
EOF

docker exec -it $(docker ps -aqf "name=awx_web") cp /etc/krb5.conf /etc/krb5.conf.bak
docker exec -it $(docker ps -aqf "name=awx_web") sed '1,17!d' /etc/krb5.conf
docker exec -it $(docker ps -aqf "name=awx_web") /bin/cat << EOF >> /etc/krb5.conf
    default_realm = COMPANY.COM
    default_ccache_name = KEYRING:persistent:%{uid}

[realms]
  COMPANY.COM = {
     kdc = DC.company.com
     admin_server = DC.company.com
  }

[domain_realm]
  company.com = COMPANY.COM
  .company.com = COMPANY.COM
EOF