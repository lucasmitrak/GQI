#!/usr/bin/env bash
set -ex

#select which defining fragments you want in your kernel fragment
virtualboxguest=false
lvm=false
crypt=false
pulseaudio=false

#additional useful fragments
usb30=false
fuse=false
efi_boot=false

for f in config_*.sh; do
        if [ -x "$f" ]; then
                source "$f";
        fi
done
