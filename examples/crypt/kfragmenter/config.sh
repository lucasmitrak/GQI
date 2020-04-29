#!/usr/bin/env bash
set -ex

#select which defining fragments you want in your kernel fragment
lvm=false
crypt=true
pulseaudio=false

#additional useful fragments
usb30=false
fuse=false
efi_boot=false
