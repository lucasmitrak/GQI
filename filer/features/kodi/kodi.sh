#!/usr/bin/env bash
source config.sh
emerge -u sddm
rc-update add xdm default
emerge -u kodi
if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
fi
