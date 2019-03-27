#!/usr/bin/env bash
set -ex
function chmodx_copy {
	[ ! -d ../finished ] && mkdir ../finished
	if [ -f $1 ]; then
		cp $1 ../finished
		chmod +x ../finished/$1
	fi
}
chmodx_copy "begin.sh"
chmodx_copy "chroot.sh"
chmodx_copy "config.sh"
chmodx_copy "exit.sh"
chmodx_copy "kernel.sh"
chmodx_copy "os_setup.sh"
chmodx_copy "setup.sh"
chmodx_copy "stage3.sh"
