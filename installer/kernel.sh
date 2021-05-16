#!/usr/bin/env bash
source config.sh
[ -x pre_kernel.sh ] && ./pre_kernel.sh
#download neccessary packages for the kernel
emerge -u pciutils genkernel gentoo-sources

#if optional kernel config file exists
if [ -f /$kernel_name ]; then
	#copy to location
	cp /$kernel_name /usr/src/linux/.config
elif [ -f /$kernel_fragment_name ] || $qemu; then
	cd /usr/src/linux && make defconfig
	cd /
fi
#enable qemu guest support
if $qemu; then
	cd /usr/src/linux && make kvmconfig
	cd /
fi
#if optional fragment kernel config file exists
if [ -f /$kernel_fragment_name ]; then
	#add it to the kernel
	/usr/src/linux/scripts/kconfig/merge_config.sh -m -O /usr/src/linux /usr/src/linux/.config /config-fragment
fi

#use genkernel option as kernel to compile kernel or all for hardware detection
genkernel $genkernel_option
[ -x post_kernel.sh ] && ./post_kernel.sh
if $setup_script; then ./setup.sh; fi
