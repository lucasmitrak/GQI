#!/usr/bin/env bash
set -ex

#choose which defining features you want included
qemu=false
lvm=false
crypt=false

#enable desired features
#enable or disable bios_boot if or not using it!
bios_boot=true
useradd=true
sudo=true
wpa_supplicant=false
sshd=false
rsyncd=false
#local portage overlay
local_overlay=false
dmcrypt=false
apache=false

#more advanced features
#this means either they require more advanced configuration/setup
#or require something from above. if you enable it here but not their requirements above,
#it will be enabled automatically. for example, host_gentoo will enable rsync
mutt=false
rtorrent=false
rsnapshot=false
#host the gentoo repo over rsync
host_gentoo=false
#use apache to host a public files directory and git repo
host_files=false
host_git=false

#xorg options
pulseaudio=true
xorg=true
#kodi creates a kodi media center. disabled by plasma
kodi=false
plasma=true
