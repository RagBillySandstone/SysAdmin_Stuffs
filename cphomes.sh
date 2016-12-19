#!/bin/bash

# copy a file to each user's home directory and grant ownership to
# that user. I asked a question on StackExchange regarding this:
# http://unix.stackexchange.com/questions/331174/how-can-i-copy-a-file-to-every-users-home-dir-in-bash/

for homedir in /home/* ; do
	if [ -d "$homedir" ] ; then 
		cp $1 "$homedir"
		user=`ls -ld $homedir | awk '{print $3}'`
		chown --verbose $user:$user $homedir/$1
	fi
done

