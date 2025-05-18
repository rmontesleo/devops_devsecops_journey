
echo "############### Fragments to start to build a Chat and remember the conversation ###############"


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