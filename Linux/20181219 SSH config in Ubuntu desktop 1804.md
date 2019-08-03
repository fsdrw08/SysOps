20181219; SSH config in Ubuntu desktop 1804:

1. Get update and upgrade:
```shell
sudo apt update
sudo apt upgrade  
```

2. Check SSH service status in target server side (Ubuntu):
```shell
ps -e | grep ssh
```
If it output something like "sshd", jump to last step, otherwise,  jump to 3.

3. Install openssh server:
https://thishosting.rocks/how-to-enable-ssh-on-ubuntu/
```shell
sudo apt-get install openssh-server -y
```
Check the port:
```shell
sudo nano /etc/ssh/sshd_config
```
Usually it should be Port 22.

4. Config the firewall ufw:
https://www.configserverfirewall.com/ufw-ubuntu-firewall/ubuntu-check-firewall-status-ufw/
```shell
#Enable ufw
sudo ufw enable
#Config the rules
sudo ufw allow 22
#Verify the settings
sudo ufw status numbered 
```

5. In the client side (Windows 10 PowerShell), run command in below syntax:
```
ssh hostname -l username
```
or
```
ssh username@hostname
```
