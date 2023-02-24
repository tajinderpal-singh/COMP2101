#!/bin/bash
# This is a script for Virtual Web Creation in Ubuntu 20.04
# Installing lxd to launch a container
echo "installing lxd..."
sudo snap install lxd

# Testing if lxdbr0 interface exists or not and running command lxd init
ip address show lxdbr0 | sed 'd' && echo "lxdbr0 interface exists" ||
echo "lxdbr0 interface does not exist and hence running 'lxd init' command" && lxd init --auto

# Launching a container named COMP2101-S22 running Ubuntu 20.04 server
echo "launching container..."
lxc launch ubuntu:20.04 COMP2101-S22

# Getting Ip address of the container and updating it to the /etc/hosts file with hostname COMP2101-S22
IPAddress=$(lxc list COMP2101-S22 | awk '{print $6}' | sed '1d;2d;3d;$d')
echo "The current ip address used by COMP2101-S22 is $IPAddress"
sudo -- sh -c -e "echo '$IPAddress      COMP2101-S22' >> /etc/hosts" &&
echo "The ip address with hostname is updated to file /etc/hosts"

# Installing Apache2 in the container
echo "Updating and Installing Apache2..."
lxc exec COMP2101-S22 -- apt -y update
lxc exec COMP2101-S22 -- apt install -y apache2

# Retrieving the default web page from the container's web service
sudo apt install curl
curl http://COMP2101-S22 && echo "Success!! The default web page of container COMP2101-S22 can be accessed." ||
echo "Failed!! Unable to retrieve the default web page of the container."
