#!/bin/bsh

# Install Docker on the local Ubuntu machine
# https://www.digitalocean.com/community/tutorials/docker-explained-how-to-containerize-python-web-applications

# Make sure aufs support is available
apt-get -y install linux-image-extra-`uname -r`

# Add docker repository key to apt-key for package verification:
sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"

# Add the docker repository to aptitude sources:
sh -c "echo deb http://get.docker.io/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"

apt-get update && apt-get -y install lxc-docker

# Ubuntu's default firewall (UFW: Uncomplicated Firewall) denies all forwarding 
# traffic by default, which is needed by docker.
# Manually edit /etc/default/ufw, replacing DEFAULT_FORWARD_POLICY="DROP" with
# DEFAULT_FORWARD_POLICY="ACCEPT" then reload with sudo ufw reload


