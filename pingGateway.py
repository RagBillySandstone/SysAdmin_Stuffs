#!/usr/bin/env python

# pingDefault.py -- pings the machine's default gateway 
# In most home networks, this is 192.168.0.1, but this script does not 
# 	make that assumption
# It does, however, assume linux ping utility

# Linux is notorious for dropping WiFi connections, especially on laptops
# I found that pinging Google.com every few minutes seems to help
# Eventually it occurred to me that all that was really necessary was to
# ping the wireless router. Setting cron to run this script every five mins
# doesn't completely alleviate the problem, but helps

import os

try:
	import netifaces
except ImportError:
	print "We need to install netifaces"
	os.system('sudo apt-get install python-netifaces')
	import netifaces

gws=netifaces.gateways()

try:
# I found this line in a Google search. I admittedly do not understand the
# gws['default'][netifaces.AF_INET][0] thing. The same results seem to be 
# returned with 
# gws['default'][2][0]  -- Which I DO understand 
	response = os.system("ping -c 1 -w 2 > /dev/null " + gws['default'][netifaces.AF_INET][0])

except KeyError:
	print 'No connection found'
	exit(2)

# Check the response

if response == 0:
	print 'Gateway is up'
	exit(0)
else:
	print 'Gateway is down'
	exit(1)

