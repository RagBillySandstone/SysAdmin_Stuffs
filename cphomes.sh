#!/bin/bash

# copy a file to each user's home directory and grant ownership to
# that user.

for homedir in /home/* ; do
	if [ -d "$homedir" ] ; then 
		cp $1 "$homedir"
		user=`ls -ld $homedir | awk '{print $3}'`
		chown --verbose $user:$user $homedir/$1
	fi
done

