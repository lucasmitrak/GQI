#!/usr/bin/env bash
source config.sh
emerge -u rsync
rc-update add rsyncd default
