#!/usr/bin/env bash
source config.sh
if $kodi; then sed -i -e 's/#autologin-session=/autologin-session=kodi/g' /etc/lightdm/lightdm.conf; fi
if $plasma; then sed -i -e 's/#autologin-session=/autologin-session=plasma/g' /etc/lightdm/lightdm.conf; fi
if [ $user ]; then sed -i -e "s/#autologin-user=/autologin-user=$user/g" /etc/lightdm/lightdm.conf; fi
