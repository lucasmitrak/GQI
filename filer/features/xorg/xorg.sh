#!/usr/bin/env bash
source config.sh
emerge -u xorg-server
if [ $user ]; then
	usermod -a -G video $user
fi
env-update
source /etc/profile
