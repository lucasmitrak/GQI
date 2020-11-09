#!/usr/bin/env bash
source config.sh
emerge -u virtualbox-guest-additions
rc-update add virtualbox-guest-additions default
rc-update add dbus default
if [ $user ]; then
	usermod -a -G vboxguest $user
fi
