#!/usr/bin/env bash
set -ex

#select which defining fragments you want in your kernel fragment
qemu=false
lvm=true
crypt=false
pulseaudio=false

#additional useful fragments
usb30=false
fuse=false
efi_boot=false
