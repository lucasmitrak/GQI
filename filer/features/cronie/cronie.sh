#!/usr/bin/env bash
source config.sh
emerge -u cron
rc-update add cronie default
if [ $user ]; then
	gpasswd -a $user cron
fi
