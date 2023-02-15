#!/bin/bash
# This is a script to display the computer information.

#System's fully-qualified domain name (FQDN)
fqdn=$(hostname -f)

# Host information including operating system name and version
hostname=$(hostname)
operatingsystem=$(hostnamectl | grep 'Operating System' | awk '{print $3,$4,$5}')
version=$(hostnamectl | grep 'Kernel' | awk '{print $2,$3}')

# IP Addresses that the machine uses to send and receive data from the interface
# Output obtained from command ip address is filtered using grep command
# Then the output from grep comand is manipulated using awk command
IPaddress=$(ip address |
grep 'inet' |
grep '192' |
awk '{print $2}' |
cut -f1 -d'/')

# Amount of space available in the root filesystem
# The space amount is represented in Human-friendly number
RootFilespace=$(df -H /dev/sda3 |
awk '{print $4}' |
sed '1d')

# Summary of the report including all the variables mentioned above
cat<<EOF

My Report for $hostname
=========
FQDN: $fqdn
Operating System name and version: $operatingsystem/$version
IP Address: $IPaddress
Root Filesystem Free Space: $RootFilespace
=========

EOF
