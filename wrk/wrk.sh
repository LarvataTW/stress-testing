#!/usr/bin/env bash

source .env

TIME=$(date +'%Y%m%d%H%M%S')
TOKEN="${TOKEN}"

curl \
  --request POST \
  --url "${LOGIN_URL}" \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data "{\"email\":\"${EMAIL}\",\"password\":\"${PASSWORD}\"}"

sleep 1

for CONNECTION in 50 100 200 300; do
  FILENAME=result/"${APPLICATION}"_"${CONNECTION}"_"${TIME}".log
  touch $FILENAME

  wrk \
    -c ${CONNECTION} \
    -t ${THREADS} \
    -d ${DURATION}s \
    -H "Authorization: Bearer ${TOKEN}" \
    --latency \
    --timeout 1000 \
    "${TARGET_URL}" >> $FILENAME
done
