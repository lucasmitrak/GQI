#!/usr/bin/env bash
source config.sh
[ -x pre_chroot.sh ] && ./pre_chroot.sh
#move these scripts over
cp *.sh $ml
#enter enviroment and start next shell
[ -x post_chroot.sh ] && ./post_chroot.sh
if $os_setup_script; then
	chroot $ml /os_setup.sh
fi
