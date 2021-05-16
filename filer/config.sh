#!/usr/bin/env bash
set -ex

#choose which defining features you want included
qemuguest=false
virtualboxguest=false
lvm=false
crypt=false

#enable desired features
#enable or disable bios_boot if or not using it!
bios_boot=true
useradd=false
sudo=false
wpa_supplicant=false
sshd=false
rsyncd=false
cronie=false
apache=false
#local portage overlay
localrepo=false

#xorg options
pulseaudio=false
xorg=false
#kodi creates a kodi media center. disabled by plasma
kodi=false
plasma=false
autologin=false
firefox=false

for f in config_*.sh; do
	if [ -x "$f" ]; then
		source "$f";
	fi
done
