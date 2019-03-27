#!/usr/bin/env bash
source config.sh
emerge -u consolekit
rc-update add consolekit default
emerge -u eudev
rc-update add udev sysinit
emerge -u pulseaudio
if [ $user ]; then
	usermod -a -G audio $user
fi
