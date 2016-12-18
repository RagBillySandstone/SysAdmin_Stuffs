#!/bin/bash

for homedir in /home/* ; do
	if [ -d "$homedir" ] ; then 
		cp $1 "$homedir"
	fi
done

