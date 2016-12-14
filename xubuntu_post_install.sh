#!/bin/bash

# A script to run after a new install of Ubuntu
# This is the kind of thing that I shold be doing with a "DevOps" tool


# Obviously, we want to start with updating the system
apt-get update && apt-get dist-upgrade

# Install some favorite software and fonts
apt-get -y install terminator vim nautilus-dropbox keepassx git \ 
	ttf-anonymous-pro ipython 

# install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install --fix-broken --assume-yes
rm --force ./google-chrome*.deb

# And get rid of some softwares I don't use
apt-get -y remove firefox 

# Remove packages that were installed automatically and no longer needed
apt -y autoremove

