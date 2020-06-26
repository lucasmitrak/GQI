#!/usr/bin/env bash
source config.sh
if $kodi; then sed -i -e 's/Session=/Session=kodi.desktop/g' /usr/share/sddm/sddm.conf.d/00default.conf; fi
if $plasma; then sed -i -e 's/Session=/Session=plasma.desktop/g' /usr/share/sddm/sddm.conf.d/00default.conf; fi
if [ $user ]; then sed -i -e "s/User=/User=$user/g" /usr/share/sddm/sddm.conf.d/00default.conf; fi
