#!/usr/bin/env bash
source config.sh

#set requirements of advanced features
#if kodi or plasma, xorg true
if $kodi || $plasma; then xorg=true; fi
#if kodi or plasma, xorg true
if ! $kodi && ! $plasma; then autologin=false; fi
#can only have one
if $plasma; then kodi=false; fi
if $kodi; then plasma=false; fi

#make files directory
mkdir -p files
#copy default files over
cp -r bases/default/* files
#copy specific files over
$xorg && cp -r bases/xorg/* files
$xorg && $qemuguest && cp -r bases/xorg_qemuguest/* files
$xorg && $virtualboxguest && cp -r bases/xorg_virtualboxguest/* files
$qemuguest && cp -r bases/qemuguest/* files
$lvm && cp -r bases/lvm/* files
$crypt && cp -r bases/crypt/* files
$crypt && $qemuguest && cp -r bases/crypt_qemuguest/* files
$lvm && $crypt && cp -r bases/lvm_crypt/* files

function add_feature {
	#copy files
	filesd="features/$1/files/."
	if [ -a $filesd ]; then
		cp -r $filesd files/
	fi
	#copy related installer config
	configd="features/$1"
	confign="config_$1.sh"
	if [ -f $configd/$confign ]; then
		[ ! -d configs ] && mkdir configs
		cp "$configd/$confign" configs
	fi
	#copy, add post_setup.sh
	fscriptd="features/$1"
	fscriptn="$1.sh"
	if [ -f $fscriptd/$fscriptn ]; then
		[ ! -d fscripts ] && mkdir fscripts
		[ ! -f fscripts/post_setup.sh ] && echo "#!/usr/bin/env bash">>fscripts/post_setup.sh
		echo "./$fscriptn">>fscripts/post_setup.sh
		cp "$fscriptd/$fscriptn" fscripts
	fi
	#copy rare pre_setup fscript (only for lvm and crypt)
	if [ -f $fscriptd/pre_setup.sh ]; then
		[ ! -d fscripts ] && mkdir fscripts
		cp $fscriptd/pre_setup.sh fscripts
	fi
}
#add each requested feature using the above function
if $bios_boot; then add_feature "bios_boot"; fi
if $useradd; then add_feature "useradd"; fi
if $sudo; then add_feature "sudo"; fi
if $wpa_supplicant; then add_feature "wpa_supplicant"; fi
if $sshd; then add_feature "sshd"; fi
if $rsyncd; then add_feature "rsyncd"; fi
if $cronie; then add_feature "cronie"; fi
if $dmcrypt; then add_feature "dmcrypt"; fi
if $apache; then add_feature "apache"; fi
if $localrepo; then add_feature "localrepo"; fi
if $pulseaudio; then add_feature "pulseaudio"; fi
if $xorg; then add_feature "xorg"; fi
if $kodi; then add_feature "kodi"; fi
if $plasma; then add_feature "plasma"; fi
if $firefox; then add_feature "firefox"; fi
if $autologin; then add_feature "autologin"; fi
if $lvm; then add_feature "lvm"; fi
if $crypt; then add_feature "crypt"; fi
if $virtualboxguest; then add_feature "virtualboxguest"; fi
