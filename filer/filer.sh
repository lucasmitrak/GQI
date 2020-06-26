#!/usr/bin/env bash
source config.sh

#set requirements of advanced features
#if host_gentoo, rsyncd true
if $host_gentoo; then rsyncd=true; fi
#if host_files or host_git, apache true
if $host_files || $host_git; then apache=true; fi
#if kodi or plasma, xorg true
if $kodi || $plasma; then xorg=true; fi
#if kodi or plasma, xorg true
if ! $kodi && ! $plasma; then autologin=false; fi
#can only have one
if $plasma; then kodi=false; fi

#make files directory
mkdir -p files
#copy default files over
cp -r bases/default/* files
#copy specific files over
$xorg && cp -r bases/xorg/* files
$xorg && $qemu && cp -r bases/xorg_qemu/* files
$qemu && cp -r bases/qemu/* files
$lvm && cp -r bases/lvm/* files
$crypt && cp -r bases/crypt/* files
$crypt && $qemu && cp -r bases/crypt_qemu/* files
$lvm && $crypt && cp -r bases/lvm_crypt/* files
if ($lvm || $crypt); then
	[ ! -d fscripts ] && mkdir fscripts
	cp features/lvm/pre_setup.sh fscripts
fi
function add_feature {
	#copy files
	filesd="features/$1/files/."
	if [ -a $filesd ]; then
		cp -r $filesd files/
	fi
	#copy, add config_extra.sh
	configd="features/$1"
	confign="config_$1.sh"
	if [ -f $configd/$confign ]; then
		[ ! -d fscripts ] && mkdir fscripts
		[ ! -f fscripts/config_extra.sh ] && echo "#!/usr/bin/env bash">>fscripts/config_extra.sh
		echo "source $confign">>fscripts/config_extra.sh
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
}
#add each requested feature using the above function
if $bios_boot; then
	add_feature "bios_boot"
fi
if $useradd; then
	add_feature "useradd"
fi
if $sudo; then
	add_feature "sudo"
fi
if $wpa_supplicant; then
	add_feature "wpa_supplicant"
fi
if $sshd; then
	add_feature "sshd"
fi
if $rsyncd; then
	add_feature "rsyncd"
fi
if $dmcrypt; then
	add_feature "dmcrypt"
fi
if $apache; then
	add_feature "apache"
fi
if $local_overlay; then
	add_feature "local_overlay"
fi
if $mutt; then
	add_feature "mutt"
fi
if $rtorrent; then
	add_feature "rtorrent"
fi
if $rsnapshot; then
	add_feature "rsnapshot"
fi
if $host_gentoo; then
	add_feature "host_gentoo"
fi
if $host_files; then
	add_feature "host_files"
fi
if $host_git; then
	add_feature "host_git"
fi
if $pulseaudio; then
	add_feature "pulseaudio"
fi
if $xorg; then
	add_feature "xorg"
fi
if $kodi; then
	add_feature "kodi"
fi
if $plasma; then
	add_feature "plasma"
fi
if $firefox; then
	add_feature "firefox"
fi
if $autologin; then
	add_feature "autologin"
fi
if $lvm; then
	add_feature "lvm"
fi
if $crypt; then
	add_feature "crypt"
fi
