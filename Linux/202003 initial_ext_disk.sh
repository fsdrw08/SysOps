parted -l
sudo parted -a optimal --script /dev/sdb 'mklabel gpt mkpart data 0% 100%'
sudo mkfs.ext4 /dev/sdb1
cd / && sudo mkdir ext/var/lib/awx -p
sudo mount /dev/sdb1 /mnt
sudo echo "/dev/sdb1 /ext ext4 defaults 0 0"  >> /etc/fstab
sudo umount -v /mnt
