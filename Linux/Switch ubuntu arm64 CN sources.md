Switch ubuntu arm64 CN sources
```shell
mv /etc/apt/sources.list /etc/apt/sources.list.bak
vim /etc/apt/sources.list
```

for ubuntu 1604
```
#deb http://ports.ubuntu.com/ xenial main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ xenial main restricted universe multiverse
#deb http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse
#deb http://ports.ubuntu.com/ xenial-security main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ xenial-security main restricted universe multiverse
#deb http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse
#deb http://ports.ubuntu.com/ubuntu-ports/ xenial main universe restricted
#deb-src http://ports.ubuntu.com/ubuntu-ports/ xenial main universe restricted #Added by software-properties
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial main universe restricted
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial main universe restricted

deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial main universe restricted
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial main universe restricted
```

for ubuntu 1804
```
#deb http://ports.ubuntu.com/ bionic main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ bionic main restricted universe multiverse
#deb http://ports.ubuntu.com/ bionic-updates main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ bionic-updates main restricted universe multiverse
#deb http://ports.ubuntu.com/ bionic-security main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ bionic-security main restricted universe multiverse
#deb http://ports.ubuntu.com/ bionic-backports main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ bionic-backports main restricted universe multiverse
#deb http://ports.ubuntu.com/ubuntu-ports/ bionic main universe restricted
#deb-src http://ports.ubuntu.com/ubuntu-ports/ bionic main universe restricted #Added by software-properties
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-security main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic main universe restricted
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ bionic main universe restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main universe restricted
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main universe restricted
```
```shell
sudo apt-get update
```
