#!/usr/bin/env bash
set -ex
function copy {
	[ ! -d ../finished ] && mkdir ../finished
	[ -f $1 ] && cp $1 ../finished
}
copy "config-fragment"
