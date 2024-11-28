#!/bin/sh

(
  response=""
  while [ -z "$response" ]; do
    response=$(curl -s -X 'POST' \
      'http://localhost:30000/api/v2/node/reset' \
      -H 'accept: application/json' \
      -H "Authorization: Bearer $DIVA_API_KEY")

    if [ -z "$response" ]; then
      sleep 5
    fi
  done
) &
