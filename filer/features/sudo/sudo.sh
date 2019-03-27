#!/usr/bin/env bash
source config.sh
emerge -u sudo
if [ $user ]; then
	usermod -a -G wheel $user
fi
