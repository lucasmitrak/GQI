#!/usr/bin/env bash
source config.sh
[ -x pre_os_setup.sh ] && ./pre_os_setup.sh
#update bash settings
source /etc/profile
#download overlays
if $webrsync; then
	emerge-webrsync
else
	emerge --sync
fi
#remove notification of news
eselect news read all
#set profile
eselect profile set $eselect_profile
#update world
emerge -vuND world
#config timezone-data
##emerge --config timezone-data
#generate locale
##locale-gen
#set locale with eselect
##eselect locale set $eselect_locale
#update enviroment
##env-update
#update bash settings
##source /etc/profile
[ -x post_os_setup.sh ] && ./post_os_setup.sh
if $kernel_script; then
	./kernel.sh
fi
