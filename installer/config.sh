#!/usr/bin/env bash
#enable for debugging
set -ex
#extra_config.sh is from filer
[ -x config_extra.sh ] && source config_extra.sh

#bios boot or uefi
bios_boot=true
uefi=false
#needed for bios boot to tell where to grub-install
hdd="/dev/sda"
#needed for uefi boot
uefi_fs=""
#always needed except for chrooting
#set to the final logical filesystem location
fs="/dev/sda1"
#should the above filesystem be mounted onto the below mount location? usually yes
mount=true

##stage3 files
#mount location
ml="/mnt/gentoo"
nongentoo_shm=false
#set date using ntpd
ntpd=false

#name and where to get it
#"stage3_http" means the installer will attemp to download it from the url
#"stage3_http_new" means it will automatically
#download stage3 from the gentoo downloads website
stage3_name="stage3-amd64*.tar.xz"
stage3_http_new=true
stage3_http=""
stage3_dir=""

files_name="files"
files_is_tar=false
files_http=""
files_dir="."

kernel_name="config"
kernel_http=""
kernel_dir=""

kernel_fragment_name="config-fragment"
kernel_fragment_http=""
kernel_fragment_dir=""

#qemu guest?
qemuguest=false

##os setup
#webrsync over regular --sync
webrsync=true
#1 default, 5 xorg, 8 plasma
eselect_profile="1"
eselect_locale="2"

##kernel
#set to kernel for just kernel(especially if you have a kernel config)
#or set to all for hardware detection
genkernel_option="all"
#genkernel_option="--menuconfig all"

##setup
interface="eth0"
root_pw="gentooquickinstall"
sysklogd=true
cronie=true
packages="vim gentoolkit"

##continue onto this script
#true will continue to this script
#almost always set to yes except for chrooting or testing
#warning: the scripts have an order of
#begin->stage3->chroot->os_setup->kernel->setup->exit
#so if you set stage3=false, then neither chroot nor anything after
#will be called
stage3_script=true
chroot_script=true
os_setup_script=true
kernel_script=true
setup_script=true
exit_script=true

for f in config_*.sh; do
        if [ -x "$f" ]; then
                source "$f";
        fi
done
