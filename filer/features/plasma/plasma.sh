#!/usr/bin/env bash
source config.sh

emerge -u dbus
rc-update add dbus default
emerge -u consolekit
rc-update add consolekit default
emerge -u polkit
emerge -u udisks
emerge -u eudev
rc-update add udev sysinit

emerge -u plasma-desktop

if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
	echo "exec ck-launch-session dbus-launch --sh-syntax --exit-with-session startkde">>/home/$user/.xinitrc
fi
