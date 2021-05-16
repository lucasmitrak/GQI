#!/usr/bin/env bash
source config.sh
emerge -u xorg-server
rc-update add display-manager default
if [ $user ]; then
	usermod -a -G video $user
fi
env-update
source /etc/profile
