#!/usr/bin/env bash
source config.sh
[ -x pre_exit.sh ] && ./pre_exit.sh
#depclean
emerge --depclean
#read all news
eselect news read all
#remove updates of config files
find /etc -name '._cfg????_*' -exec rm "{}" \;
#remove sh files
rm /*.sh
#remove stage3 and files
[ -f /$stage3_name ] && rm /$stage3_name
[ -f /$files_name ] && rm /$files_name
[ -f /$kernel_name ] && rm /$kernel_name
[ -f /$kernel_fragment_name ] && rm /$kernel_fragment_name
[ -x post_exit.sh ] && ./post_exit.sh
