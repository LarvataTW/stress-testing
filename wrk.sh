#!/usr/bin/env bash

source .env

TIME=$(date +'%Y%m%d%H%M%S')
TOKEN="${TOKEN}"

curl \
  --request POST \
  --url "${LOGIN_URL}" \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data "{'email':'${USERNAME}', 'password':'${PASSWORD}'}"

sleep 1

for CONNECTION in 50 100 200 300; do
  FILENAME="${NAME}"_"${CONNECTION}"_"${TIME}".log
  touch $FILENAME
done
