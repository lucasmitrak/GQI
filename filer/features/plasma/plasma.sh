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
rc-update add xdm default

emerge -u plasma-meta

if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
fi
