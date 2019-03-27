#!/usr/bin/env bash
source config.sh
if [ $user ]; then
	useradd $user
	usermod -a -G users $user
	echo "$user:$user_pw"|chpasswd
	if [ -a /.* ]; then
		#mv hidden files to home
		mv /.[!.]* /home/$user/
		chown -R $user:$user /home/$user/.[!.]*
	fi
else
	rm /.*
fi
