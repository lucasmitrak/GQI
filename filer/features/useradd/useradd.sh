#!/usr/bin/env bash
source config.sh
if [ $user ]; then
	useradd $user
	usermod -a -G users $user
	echo "$user:$user_pw"|chpasswd
fi
