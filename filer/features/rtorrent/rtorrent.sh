#!/usr/bin/env bash
source config.sh
emerge -u rtorrent
rc-update add rtorrentd default
