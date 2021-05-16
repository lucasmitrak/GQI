#!/usr/bin/env bash
source config.sh
emerge -u lightdm
sed -i -e "s/DISPLAYMANAGER=\"xdm\"/DISPLAYMANAGER=\"lightdm\"/g"  /etc/conf.d/display-manager
emerge -u kodi
if [ $user ]; then
	usermod -a -G audio,cdrom,video,cdrw,usb,users $user
fi
