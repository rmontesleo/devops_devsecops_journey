#!/bin/bash


# Set variables for the script
endpoint="https://api.openai.com/v1/responses"
model="gpt-4.1"
prompt=""
response_id=""
memory=""

while [ "$prompt" != "quit"  ];
do
    read -p "Typer your prompt to call the chat or type to quit: " prompt
    if [ "$prompt" == "quit"  ]; then
        echo "Ending this chat"
    else
        body='{
           "model": "'"$model"'" ,
            "input": "'"$prompt"'"
        '

        read -p "Get the response id: " response_id
        if [ -n "$response_id" ]; then
            memory=', "previous_response_id": "'"$response_id"'"  '
        fi
        # Concatenating the values to request_body
        request_body="$body$memory }"

        echo "Sendind request body $request_body "
    fi

    memory=""
    response_id=""
done

echo "Hasta la vista Baby..."