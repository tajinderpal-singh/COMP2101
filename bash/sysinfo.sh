#!/bin/bash
# This is a script to display the computer information.

#System's fully-qualified domain name (FQDN)
echo "Fully-qualified domain name(FQDN) of system: $(hostname -f)"

# Host information including operating system name and version
echo " Important host information is as follow:"
hostnamectl

# IP Addresses that the machine has, excluding IP addresses on the 127 network
# Output obtained from command ip address is filtered using grep command
# Then the output from grep comand is manipulated using awk command
echo "IP Addresses available excluding address on 127 network:"
ip address |
grep 'inet' |
grep -v "127" |
awk '{print $2}' |
cut -f1 -d'/'

# Amount of space available in the root filesystem
# The space amount is represented in Human-friendly number
echo "Root Filesystem Status:"
  df -H /dev/sda3
