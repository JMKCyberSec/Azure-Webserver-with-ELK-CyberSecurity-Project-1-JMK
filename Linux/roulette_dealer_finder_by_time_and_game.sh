#!/bin/bash
 

echo "Welcome to Dealer Finder where you enter the Game, Date and Time to find out who was dealing."
echo "Please enter Blackjack Roulette or Texas     NOTE: Case Sensitive"
read game

if [ "$game" = Roulette ]
then 
        echo "Please enter Date in MMDD format"
        read udate
        echo "Please enter AM or PM "
        read ampm
        echo "Please enter time in 00:00:00 format"
        read utime
                cat "$udate"_Dealer_schedule | grep -iw "$ampm" | grep "$utime" | awk '{print $5,$6}'
        .
elif [ "$game" = Blackjack ]
then
        echo "Please enter Date in MMDD format"
        read udate
        echo "Please enter AM or PM "
        read ampm
        echo "Please enter time in 00:00:00 format"
        read utime
                cat "$udate"_Dealer_schedule | grep -iw "$ampm" | grep "$utime" | awk '{print $3,$4}'
        .
elif [ "$game" = Texas ]
then 
        echo "Please enter Date in MMDD format"
        read udate
        echo "Please enter AM or PM "
        read ampm
        echo "Please enter time in 00:00:00 format"
        read utime
                cat "$udate"_Dealer_schedule | grep -iw "$ampm" | grep "$utime" | awk '{print $7,$8}'
        .
else echo Please Run Script Again 

fi

