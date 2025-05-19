#!/bin/bash

echo "This script test basic while loops"

echo ""
echo "While loop evaluating if the option is different (-ne) form 6 "
option=-1
while [ $option -ne 6 ]
do
    read -p "Type your option from 1 to 6 (6 to  exit)" option
    echo "Selecte option is $option"
    echo ""
done
