#!/usr/bin/env bash
source config.sh
emerge -u lightdm
rc-update add xdm default
emerge -u kodi
if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
fi
