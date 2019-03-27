#!/usr/bin/env bash
source config.sh
[ -x pre_chroot.sh ] && ./pre_chroot.sh
#move these scripts over
cp *.sh $ml
#enter enviroment and start next shell
chroot $ml /os_setup.sh
[ -x post_chroot.sh ] && ./post_chroot.sh
