#!/usr/bin/env bash
set -ex
function chmodx_copy {
	[ ! -d ../finished ] && mkdir ../finished
	if [ -f $1 ]; then
		cp $1 ../finished
		chmod +x ../finished/$1
	fi
}
function copy_dir {
	[ ! -d ../finished ] && mkdir ../finished
	[ -d $1 ] && cp -r $1 ../finished
}
function chmodx_copy_in_dir {
	[ ! -d ../finished ] && mkdir ../finished
	if [ -d $1 ]; then
		for script in $1/*; do
			cp $script ../finished
			scriptn=$(basename $script)
			chmod +x ../finished/$scriptn
		done
	fi
}
copy_dir "files"
chmodx_copy_in_dir "fscripts"
chmodx_copy_in_dir "configs"
