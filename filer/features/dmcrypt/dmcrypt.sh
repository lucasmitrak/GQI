#!/usr/bin/env bash
emerge -u cryptsetup
rc-update add dmcrypt boot
