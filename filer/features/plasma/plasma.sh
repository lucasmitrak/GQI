#!/usr/bin/env bash
source config.sh

emerge -u elogind
rc-update add elogind boot
emerge -u eudev
rc-update add udev sysinit
emerge -u sys-apps/dbus
rc-update add dbus default
emerge -u polkit
emerge -u udisks

emerge -u lightdm
sed -i -e "s/DISPLAYMANAGER=\"xdm\"/DISPLAYMANAGER=\"lightdm\"/g"  /etc/conf.d/display-manager

emerge -u plasma-meta
emerge -u konsole

if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
fi
