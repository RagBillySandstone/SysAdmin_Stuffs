#!/bin/bash

# install the ELK stack on Ubuntu 16.04
# Per http://linoxide.com/ubuntu-how-to/setup-elk-stack-ubuntu-16/

# ElasticSearch recommends Oracle Java, so...
# This will require some user intervention to accept the license agreement
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
apt-get -y install oracle-java8-installer

# Install ElasticSearch
# First add the public GPG key to apt
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
# Create the ElasticSearch source list
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
apt-get -y update
apt-get -y install elasticsearch

# At this point, the config file needs to be changed around a bit
# If I didn't suck so bad at sed/awk/etc, this wouldn't need to be done 
# manually, but it is what it is.
echo -e "\n\nThe ElasticSearch config file needs to be manually updated."
echo "Open /etc/elasticsearch/elsticsearch.yml"
echo "Uncomment the network.host line and replace its value with 'localhost'"
echo "network.host: localhost"
read -rsp $'Press any key to continue...\n' -n1 key
service elasticsearch restart # Start elasticsearch

