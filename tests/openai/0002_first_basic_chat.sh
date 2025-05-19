#!/bin/bash

# Set variables for the API request
endpoint="https://api.openai.com/v1/responses"
model="gpt-4.1"

prompt=""
response=""
previous_response_id=""
memory=""
iteration_index=0


while [ "$prompt" != "quit"  ];
do
    read -p "Typer your prompt to call the chat or type to quit: " prompt
    if [ "$prompt" == "quit"  ]; then
        echo "Ending this chat"
    else

        # Start building the body request. Yes this could be improved
        body='{
           "model": "'"$model"'" ,
            "input": "'"$prompt"'"
        '

        # Get the response id, if previous response exist
        if [ -n "$response" ]; then
            previous_response_id=$( echo $response | jq  -r .id )
            memory=', "previous_response_id": "'"$previous_response_id"'"  '
        fi
        # Concatenating the values to request_body
        request_body="$body$memory }"

        # Send prompt to Open AI API
        response=$( curl $endpoint \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $OPENAI_API_KEY" \
            -d "$request_body" 
        )

        # Backup response
        echo $response > "./responses/response_0${iteration_index}.json"

        # Getting Text from open ai response
        text=$( echo $response | jq -r .output[0].content[0].text )

        echo "Chat Response 0${iteration_index} : $text"

    fi

    # Clean memory
    iteration_index=$(( $iteration_index + 1 ))
    
done

echo "Hasta la vista Baby..."