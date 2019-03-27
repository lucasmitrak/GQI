#!/usr/bin/env bash
source config.sh
emerge -u ssh
rc-update add sshd default
