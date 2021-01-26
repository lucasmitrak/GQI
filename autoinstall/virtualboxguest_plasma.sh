#!/usr/bin/env bash
#partitioning
parted /dev/sda mklabel msdos mkpart primary ext4 0% 100% -s
mkfs -t ext4 /dev/sda1
#copy over configs
cp -rf virtualboxguest_plasma/* ..
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
