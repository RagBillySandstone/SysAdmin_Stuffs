#!/bin/bash

# install the ELK stack on Ubuntu 16.04
# Per http://linoxide.com/ubuntu-how-to/setup-elk-stack-ubuntu-16/

# 1:
# ElasticSearch recommends Oracle Java, so...
# This will require some user intervention to accept the license agreement
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
apt-get -y install oracle-java8-installer

# 2:
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
update-rc.d elasticsearch defaults 95 10 # Start the daemon on system boot

# 3:
# Install logstash
# Create the logstash source list from the same repo as elasticsearch
# Hence no need to import the public key
wget https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.3.4-1_all.deb
dpkg -i logstash_2.3.4-1_all.deb # Install the package
service logstash start 			# Start the daemon
update-rc.d logstash defaults 97 8 # Start the daemon on boot
rm --force logstash*.deb		# Remove the package file

# Apparently there is a problem running this with systemctl which can be 
# Mediated with the Ruby Gem "Pleaserun"
# https://github.com/jordansissel/pleaserun
apt-install ruby
gem install pleaserun
# create the systemd daemon file
# This generated a "File already exists" error on my system for
# /etc/logstash/logstash.conf
pleaserun -p systemd -v default --install /opt/logstash/bin/logstash agent -f /etc/logstash/logstash.conf
systemctl start logstash	# Start the daemon
systemctl status logstatus	# Check the status of the daemon


# 4:
# Configure logstash
# Create directory for storing certificate and key for logstash
mkdir -p /var/lib/logstash/private
chown logstash:logstash /var/lib/logstash/private
chmod go-rwx /var/lib/logstash/private

# Create certificates and key
openssl req -config /etc/ssl/openssl.cnf -x509  -batch -nodes -newkey rsa:2048 -keyout /var/lib/logstash/private/logstash-forwarder.key -out /var/lib/logstash/private/logstash-forwarder.crt -subj /CN=localhost

# To avoid "TLS handshake error" add the server to /etc/ssl/openssl.conf
echo -e "\n\n# Avoid TLS handshake error\n[v3_ca] subjectAltName = IP:127.0.0.1" >> /etc/ssl/openssl.cnf

# Copy some logstash config files to the config directory
cp 02-beats-input.conf 30-elasticsearch-output.conf 10-syslog-filter.conf /etc/logstash/conf.d/

