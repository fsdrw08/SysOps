######################
# change source in prc
######################
## backup and remove enterprice source
mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.bak

## download gpg key
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg

## add comunity source
echo "deb http://download.proxmox.wiki/debian/pve buster pve-no-subscription" >/etc/apt/sources.list.d/pve-install-repo.list

## add ali source
cp /etc/apt/sources.list /etc/apt/sources.list.orgin && \
echo "\
deb http://mirrors.aliyun.com/debian/ buster main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib
deb http://mirrors.aliyun.com/debian-security buster/updates main
deb-src http://mirrors.aliyun.com/debian-security buster/updates main
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib">/etc/apt/sources.list

## update source
apt update

## if need to upgrade
apt upgrade

## set up lxc source
grep -rn "download.proxmox.com" /usr/share/perl5/PVE/*   #查找设定下载源的文件
sed -i.bak "s#http://download.proxmox.com/images#https://mirrors.ustc.edu.cn/proxmox/images#g" /usr/share/perl5/PVE/APLInfo.pm
wget -O /var/lib/pve-manager/apl-info/mirrors.ustc.edu.cn https://mirrors.ustc.edu.cn/proxmox/images/aplinfo.dat

############################
# remove un-subscribe pop up
############################
## backup and remove origin js
cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak && vim /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js

## find out below code, change from
if (data.status !== 'Active')
## to
if (false)

## restart service
systemctl restart pveproxy


########################
# clean up origin disk 
# https://nubcakes.net/index.php/2019/03/05/how-to-add-storage-to-proxmox/
########################

## install parted
apt install parted

## set up new partition table (to GPT), change <X> to your target disk letter in /dev/
parted /dev/sd<X> mklabel gpt

#########################
# set up zfs pool (zpool) for disk
#########################
## do it in web ui
## Datacenter -> pve (current node) -> Disks -> ZFS -> Create: ZFS...


#########################
# set up nested zfs in ZFS pool
#########################
## check your target zpool name
zpool list

## markdown the target zpool name as <zpool name>
zfs create <zpool name>/vhd


#########################
# set up directory for nested zfs
#########################
## do it in web ui
## Datacenter -> Storage -> Add -> Directory -> ID, Directory(select the directory you want to set)...

## if need to delete diretory
## https://dannyda.com/2020/05/20/how-to-delete-mounted-directory-from-proxmox-pve-and-make-it-ready-for-other-uses/
## Navigate to Datacenter -> host name/cluster name -> Directory, note down the Device “/dev/disk/by-uuid/xxxxxxxxxxxxxxx”
umount -f /dev/disk/by-uuid/.......
cd /etc/systemd/system
ls -ahlp
rm -f mnt-pve-<foldername>.mount


#########################
# set up raw img file to host files
#########################
## create raw img file 
dd if=/dev/zero of=<file_name>.img bs=4096 count=1000
##or
qemu-img create -f raw <file_name>.img 500G

## set file system in the img file
mkfs -t ext4 <file_name>.img

## create mount point
mkdir /mnt/<mount_point_folder>/

## mount the this kind of loop device
## https://unix.stackexchange.com/questions/316401/how-to-mount-a-disk-image-from-the-command-line/316407#316407
mount -o loop <file_name>.img /mnt/<mount_point_folder>/

## set up in /etc/fstab/
echo "<file_name>.img /mnt/<mount_point_folder>/ ext4 loop,_netdev 0 0"  >> /etc/fstab