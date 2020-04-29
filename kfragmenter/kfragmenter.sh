#!/usr/bin/env bash
source config.sh
$lvm && cat configfragments/config_lvm-fragment>>config-fragment
$crypt && cat configfragments/config_crypt-fragment>>config-fragment
$pulseaudio && cat configfragments/config_pulseaudio-fragment>>config-fragment
$usb30 && cat configfragments/config_usb30-fragment>>config-fragment
$fuse && cat configfragments/config_fuse-fragment>>config-fragment
$efi_boot && cat configfragments/config_efi_boot-fragment>>config-fragment
