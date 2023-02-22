#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############
title=$(date +%A |
sed 's/Monday/Work/' |
sed 's/Tuesday/Enjoy/' |
sed 's/Wednesday/Play/' |
sed 's/Thursday/Family/' |
sed 's/Friday/Party/' |
sed 's/Saturday/Holiday/' |
sed 's/Sunday/Environment/')
USER=$USER
hostname=$(hostname)
today=$(date +%A)
time=$(date +%H:%M)

###############
# Main Variable for output#
###############

myvar="Welcome to planet $hostname, '$title $USER!'.
It is $today at $time"

cowsay $myvar
