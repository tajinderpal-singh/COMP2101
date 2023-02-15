#!/bin/bash
#
# this script rolls a pair of six-sided dice and displays both the rolls
#

# Task 1:
#  put the number of sides in a variable which is used as the range for the random number
#  put the bias, or minimum value for the generated number in another variable
#  roll the dice using the variables for the range and bias i.e. RANDOM % range + bias
echo "The range is" ${range= 6}
echo "The minimum value for generated number is" ${bias=1}
die02=$(( RANDOM % range + bias ))
die01=$(( RANDOM % range + bias ))
echo "Rolling first time...."
echo "Rolled dice get numbers $die01, $die02"

# Task 2:
#  generate the sum of the dice
sum=$(( die01 + die02 ))
echo "The sum of the dice is $sum"
#  generate the average of the dice
av=$(( sum/2 ))
echo "The average of the dice is $av"

#  display a summary of what was rolled, and what the results of your arithmetic were

# Tell the user we have started processing
echo "Second time, Rolling..."
# roll the dice and save the results
die1=$(( RANDOM % 6 + 1))
die2=$(( RANDOM % 6 + 1 ))
# display the results
echo "Rolled $die1, $die2"
