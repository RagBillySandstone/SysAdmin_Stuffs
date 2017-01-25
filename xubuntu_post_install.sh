#!/bin/bash

# A script to run after a new install of Ubuntu
# This is the kind of thing that I shold be doing with a "DevOps" tool


# Obviously, we want to start with updating the system
apt-get update && apt-get dist-upgrade

# Install some favorite software and fonts
apt-get -y install terminator vim nautilus-dropbox keepassx git \
	ttf-anonymous-pro ipython ruby tree synaptic vlc libreoffice \
	xubuntu-restricted-extras libavcodec-extra 

# If you want to play DVDs, uncomment the following lines
#apt-get -y install libdvdread4
#/usr/share/doc/libdvdread4/install-css.sh

# install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt-get install --fix-broken --assume-yes
rm --force ./google-chrome*.deb

# Install Sublime 3 
add-apt-repository -y ppa:webupd8team/sublime-text-3
apt-get -y update
apt-get -y install sublime-text-installer


# And get rid of some softwares I don't use
apt-get -y remove firefox 

# Remove packages that were installed automatically and no longer needed
apt -y autoremove

# Per http://www.binarytides.com/better-xubuntu-14-04/, this will speed up
#	the user interface

#echo "gtk-menu-popup-delay = 0 
#gtk-menu-popdown-delay = 0 
#gtk-menu-bar-popup-delay = 0 
#gtk-enable-animations = 0 
#gtk-timeout-expand = 0
#gtk-timeout-initial = 0
#gtk-timeout-repeat = 0" > ~/home/*/.gtkrc-2.0

