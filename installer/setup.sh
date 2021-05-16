#!/usr/bin/env bash
source config.sh
[ -x pre_setup.sh ] && ./pre_setup.sh
#install netifrc
emerge -u netifrc
#create network interface service
ln -s /etc/init.d/net.lo /etc/init.d/net.$interface
#add network interface service to init
rc-update add net.$interface default
#set root password
echo "root:$root_pw"|chpasswd
if $sysklogd; then
	emerge -u sysklogd
fi
if $cronie; then
	emerge -u cron
	rc-update add cronie default
fi
#install dhcp client
emerge -u dhcpcd
#install boot loader
emerge -u grub
#install grub
if $uefi; then
	grub-install --target=x86_64-efi --efi-directory=/boot
elif $bios_boot; then
	grub-install $hdd
fi
mkdir -p /boot/grub
#generate config
grub-mkconfig -o /boot/grub/grub.cfg
#emerge misc packages
emerge -u $packages
[ -x post_setup.sh ] && ./post_setup.sh
if $exit_script; then ./exit.sh; fi
