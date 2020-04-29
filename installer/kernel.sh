#!/usr/bin/env bash
source config.sh
[ -x pre_kernel.sh ] && ./pre_kernel.sh
#download neccessary packages for the kernel
emerge -u pciutils genkernel gentoo-sources

#if optional kernel config file exists
if [ -f /config ]; then
	#copy to location
	cp /config /usr/src/linux/.config
elif [ -f /config-fragment ] || $guest_qemu; then
	cd /usr/src/linux && make defconfig
	cd /
fi
#enable qemu guest support
if $guest_qemu; then
	cd /usr/src/linux && make kvmconfig
	cd /
fi
#if optional fragment kernel config file exists
if [ -f /config-fragment ]; then
	#add it to the kernel
	/usr/src/linux/scripts/kconfig/merge_config.sh -m -O /usr/src/linux /usr/src/linux/.config /config-fragment
fi

#use genkernel option as kernel to compile kernel or all for hardware detection
genkernel $genkernel_option
[ -x post_kernel.sh ] && ./post_kernel.sh
./setup.sh
