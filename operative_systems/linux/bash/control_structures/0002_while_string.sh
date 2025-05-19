#!/bin/bash

echo "This script test basic while loops evaluating string values"
echo 'REMEMBER: Use the double quotation around the variables "$prompt" , "$option", etc'

echo ""
echo "While loop evaluatin if the option is different from the word quit"
prompt=""
while [ "$prompt" != "quit" ]; 
do
    read -p "Type your prompt to call the chat or type quit: " prompt
    if [ "$prompt" == "quit" ]; then
        echo "Ending this program."
    else
        echo "Sending the prompt:  $prompt"
    fi
    echo ""
done

