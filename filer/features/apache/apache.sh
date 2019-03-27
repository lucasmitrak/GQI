#!/usr/bin/env bash
source config.sh
emerge -u apache
rc-update add apache2 default
