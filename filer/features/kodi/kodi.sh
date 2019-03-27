#!/usr/bin/env bash
source config.sh
emerge -u kodi
if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
	echo "exec kodi-standalone">>/home/$user/.xinitrc
	echo "startx">>/home/$user/.bash_profile
	echo "c9:2345:respawn:/sbin/agetty --autologin $user tty9">>/etc/inittab
fi
