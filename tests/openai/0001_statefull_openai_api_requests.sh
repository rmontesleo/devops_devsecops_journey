#!/bin/bash

echo "############### Fragments to start to build a Chat and remember the conversation ###############"
echo "This script execute 3 prompts to be anwser by OpenAI"
echo "From each response, we get the response id and send to the next request in the attribute previous_response_id "
echo "That allows keep the context of the conversation in an easy way"
echo "The full responses are stored in the responses folder"
echo "The API used is /v1/responses from OpenAI"
echo "The OPENAI_API_KEY must be set as environment variable"
echo "Do 3 prompts that must be related"
echo "Some sample could be"
echo "prompt1: Give me the full filmography from Bill Murray, for each movie get title, director, year, imdb and summary"
echo "prompt2: Which is consider his best movie?"
echo "prompt3: Tell me, with whom, with whom and with which actors he worked the most, and when were his most active years?"
echo "Choose your own prompts.  Good luck."
read "Press enter to continue..."

# Set variables for the script
endpoint="https://api.openai.com/v1/responses"
model="gpt-4.1"

echo ""
echo ""
echo "#####################################################################"
read -p "Type your First prompt and press enter: " userPrompt

# when you need debug the request use the -v after curl command
response=$( curl $endpoint \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "'"$model"'",
    "input": "'"$userPrompt"'" 
}')

echo $response > ./responses/first_response.json

previous_response_id=$( echo $response | jq  -r .id )
text=$( echo $response | jq -r '.output[0].content[0].text' )

echo "First previous_response_id $previous_response_id"
echo "First Chat Response: $text"


echo ""
echo ""
echo "#####################################################################"
read -p "Type your Second prompt and press enter: "  userPrompt

response=$( curl $endpoint \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "'"$model"'" ,
    "input": "'"$userPrompt"'" , 
    "previous_response_id": "'"$previous_response_id"'"
}')

echo $response > ./responses/second_response.json

previous_response_id=$( echo $response | jq  -r .id )
text=$( echo $response | jq -r .output[0].content[0].text )

echo "Second previous_response_id $previous_response_id"
echo "Second Chat Response: $text"

echo ""
echo ""
echo "#####################################################################"
read -p "Type your Last prompt and press enter: "  userPrompt

response=$( curl $endpoint \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "'"$model"'" ,
    "input": "'"$userPrompt"'" , 
    "previous_response_id": "'"$previous_response_id"'"
}')

echo $response > ./responses/last_response.json

previous_response_id=$( echo $response | jq  -r .id )
text=$( echo $response | jq -r .output[0].content[0].text )
echo "Last Chat Response: $text"


echo ""
echo ""
echo " Hasta la vista Baby..."