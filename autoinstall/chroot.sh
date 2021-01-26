#!/usr/bin/env bash
#copy over configs
cp -rf chroot/* ..
cd ../filer
./filer.sh
./copy.sh
cd ../installer
./copy.sh
cd ../kfragmenter
./kfragmenter.sh
./copy.sh
cd ../finished
./begin.sh
