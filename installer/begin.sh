#!/usr/bin/env bash

setterm -blank 0

if $stage3_script; then time ./stage3.sh; fi
