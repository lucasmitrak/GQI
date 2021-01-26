#!/usr/bin/env bash
#partitioning
parted /dev/vda mklabel msdos mkpart primary ext4 0% 100% -s
mkfs -t ext4 /dev/vda1
#copy over configs
cp -rf qemu/* ..
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
