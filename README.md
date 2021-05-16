This is a gentoo quick installer. ![build](https://github.com/lucasmitrak/GQI/workflows/build/badge.svg)

This is meant for people experienced with the gentoo installation

There are three large parts to this GQI: the installer, the filer, and the kfragmenter. The installer is the actual bash scripts that will be run, but it needs the neccessary files for the operation system and optionally a kernel config/fragment. These can be optained from the filer and kfragmenter respectively. First however, you need to partition manually because the GQI will not do it for you. Then put the final logical parition in the installer's config under "fs".
To get what you need from each of these three, you will need to configure the config.sh file, run the associately named script which puts it together(for the filer and kfragmenter), and run the copy.sh script for all three. The config.sh file helps determine the features and circumstances of the machine you are installing on. The associately named script(filer.sh and kfragmenter.sh) put together what you will need for the installer. The copy.sh script copies what you need to a ready-to-go directory called "finished". Copy this directory onto the machine you want to install on and run begin.sh.
Always remember to check and re-check that what is going to be copied to the "finished" directory is correct before running it! If you mess up, you can always correct it and recopy. For the filer, always check the "files" directory and set the files configuration correctly, this incudes hostname, networking information, fstab, and conf/net for networking information. For the installer, check and recheck the config.sh file is correct, this is the core configuration of the entire GQI. For the kfragmenter, check the features you want in the kernel are correct. You can always use your own kernel instead of a kernel fragment and set it in the installer's config.sh file. Once everything is rechecked and ready, copy the "finished" directory onto the computer with the gentoo install CD and run "begin.sh"!

Here is the how-to instructions:
1)Copy the GQI onto the machine. You can do a wget of "https://github.com/lucasmitrak/GQI/archive/master.zip". You can also use git to clone it down and, if you need to, copy it to the machine using a thumb drive.
2)Partition the hard drive. The GQI does not do this for you because everyone has their own way of doing it. Then, create a filesystem on the neccessary devices. Put the final root filesystem in installer's config.sh under "fs".
3)cd into installer. This is the actual installer. Open up and fill out the rest of its config.sh. Make sure to fill out all you need to, but most should not be filled out. If you have questions about what some of these settings do, grep for it in the relevant scripts. After this, run ./copy.sh.
4)cd into filer. Open up config.sh and fill out which features you need and want. For example, if you are running on QEMU, then QEMU should be set to true. The more you include, the more complicated it will be to configure the files and the longer the install will take. Therefore, for your first install, only enable the essentials. After you finish filer's config.sh, run ./filer.sh. After this, cd into the directory configs if it exists and fill out each config file. These are extra config files which may not exist if you do not enable a lot of features, like "useradd". Now cd into the files directory. This is the longest part. cd into each directory and check/fill out each file. The filer.sh copies over files configured for each feature, but still check each one. For example, if you enable QEMU, the neccessary files like /etc/default/grub and /etc/fstab are already configured for QEMU. Any combination of qemu, crypt, lvm, and xorg will have the appropriately configured files present, but still check them. After you check each file in the files directory, run ./copy.sh.
5)cd into kfragmenter. Open up config.sh and enable the fragments you want included in your kernel. These kernel fragments should corespond to what you enabled in filer's config.sh. For example, if you are using QEMU, then set QEMU to true. After this, run ./kfragmenter.sh and then ./copy.sh.
6)Make sure to set installer's config.sh's "kernel_fragment_dir" to "." if you are using the kernel fragmenter. This is the default setting. If you opt to use an entire kernel config, copy the config kernel config file to the finished directory and set installer's config.sh's "kernel_dir" to ".". You can use both a kernel fragment and entire kernel config, it will merge the kernel fragment on top of the kernel config. If you do not want to use the kernel fragment, set installer's config.sh's "kernel_fragment_dir" to "".
6)cd into finished. This is the directory which holds everything needed for the actual install. You could technically configure the entire GQI on another machine and then just copy this directory over at the end. Check the config.sh file, the files directory, and the config-fragment file. After this, begin the install by running ./begin.sh.

If you are using QEMU, I included two autoinstalls scripts that will do the entire process for you! cd into the autoinstall directory and run ./qemu.sh or ./qemu_plasma.sh, depending on if you want a plasma desktop. You do not have to partition, only make sure the GQI is on the desired machine. This will run with a lot of default settings, like "hostname" being "hostname". If you want to configure it or copy the finished directory somewhere else, comment out the last line, cd into finished, configure everything(especially files), and run ./begin.sh manually.

With different hardware, you need to change:
For drive name change:
-config.sh
-fstab
-grub

For network name change:
-config.sh
-conf/net

For cpu count change:
-make.conf
