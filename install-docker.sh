#!/bin/bash
# Install Docker on Ubuntu  according to the instructions at
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/

# Copyright 2017, Stephen Castaneda stepehn.c976@gmail.com
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Run this as a non-privileged user
if [ "$EUID" -eq 0 ]
    then echo "Please run as a non-privileged user."
    exit
fi

# First, uninstall any existing Docker.
# This will not remove anything under /var/lib/docker
sudo apt-get remove docker docker-engine docker.io

# The linux-extra packages allow Docker to use aufs (Why???)
sudo apt-get update
sudo apt-get -y install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Install Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify the key fingerprint, which should be:
# 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88

# setup the stable repository, which is also necessary for edge or test
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

# Update the cache
sudo apt-get update

# Install the latest version of Docker CE
sudo apt-get -y install docker-ce

# Check the install by running Hello World
sudo docker run hello-world
