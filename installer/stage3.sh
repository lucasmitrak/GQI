#!/usr/bin/env bash
source config.sh
[ -x pre_stage3.sh ] && ./pre_stage3.sh
mkdir -p $ml
#mount filesystem
if $mount; then
	mount $fs $ml
fi
if $uefi; then
	mkdir -p $ml/boot
	mount -t vfat $uefi_fs $ml/boot
fi
if $ntpd; then
	#update time
	ntpd -q -g
fi
#if download newest stage3
if $stage3_http_new; then
	#download latest stage3 build
	wget -r -l1 -np -nd -A stage3-amd64-2*.tar.xz http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/ -P $ml
fi
#if download stage3
if [ $stage3_http ]; then
	#download custom stage3 build
	wget $stage3_http -P $ml
fi
if [ $stage3_dir ]; then
	cp $stage3_dir/$stage3_name $ml
fi

#unpack it
tar xpf $ml/$stage3_name -C $ml
#copy DNS info
cp -L /etc/resolv.conf $ml/etc/
#mount neccessary filesystems
mount -t proc /proc $ml/proc
mount --rbind /sys $ml/sys
mount --rbind /dev $ml/dev
if $nongentoo_shm; then
	#mount --bind /run $ml/run
	#mount --bind /dev/shm $ml/dev/shm
	#mount --bind /dev/pts $ml/dev/pts
	test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
	mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm
	chmod 1777 /dev/shm
fi
#if download files
if [ $files_http ]; then
	wget $files_http -P $ml
fi
#if local files
if [ $files_dir ]; then
		cp -r $files_dir/$files_name $ml
fi
if $files_is_tar; then
	tar xpf $ml/$files_name -C $ml
elif [ $files_name ]; then
	cp -r $ml/$files_name/* $ml
	chown -R root:root /etc /var/db
fi
#if download kernel config
if [ $kernel_http ]; then
        wget $kernel_http -P $ml
fi
#if local kernel config
if [ $kernel_dir ]; then
        cp $kernel_dir/$kernel_name $ml
fi
#if download kernel-fragment config
if [ $kernel_fragment_http ]; then
        wget $kernel_fragment_http -P $ml
fi
#if local kernel-fragment config
if [ $kernel_fragment_dir ]; then
        cp $kernel_fragment_dir/$kernel_fragment_name $ml
fi
[ -x post_stage3.sh ] && ./post_stage3.sh
if $chroot_script; then ./chroot.sh; fi
