#!/bin/bash

echo "#################### First Query"
curl https://api.openai.com/v1/responses \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "gpt-4.1",
    "input": "My Name is Inigo Montoya, prepare to die"
}'


echo "################### Second query"

prompt02="Who am I?"

curl https://api.openai.com/v1/responses \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "gpt-4.1",
    "input": "'"$prompt02"'"    
}'


echo "################### 3th query"

endpoint="https://api.openai.com/v1/responses"
model="gpt-4.1"
prompt03="Why the sky is blue?"

curl $endpoint \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "'"$model"'",
    "input": "'"$prompt02"'"    
}'


echo "################### 4th query"

endpoint="https://api.openai.com/v1/responses"
model="gpt-4.1"
prompt03="Why the sky is blue?"

response=$(curl $endpoint \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "'"$model"'",
    "input": "'"$prompt02"'"    
}')

echo $response | jq

echo "###############  5th query"

endpoint="https://api.openai.com/v1/responses"
model="gpt-4.1"

read -p "Type your prompt and press enter: " userPrompt

echo "User prompt is $userPrompt"


response=$( curl -v $endpoint \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
    "model": "'"$model"'",
    "input": "'"$userPrompt"'" 
}')

echo $response | jq



