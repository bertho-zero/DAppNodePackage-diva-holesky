#!/bin/sh

response=$(curl -s -X 'GET' \
  'http://localhost:30000/api/v2/participant/dkgs' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $DIVA_API_KEY")

old_dkgs=$(echo "$response" | jq -r '. | if .error then 1 else 0 end')

if [ "$old_dkgs" -eq 1 ] 2>/dev/null; then
  code=$(echo "$response" | jq -r '.error.code')

  if [ "$code" == "PARTICIPANT_DELETING_ALL_DKGS" ]; then
    curl -s -X 'DELETE' \
      'http://localhost:30000/api/v2/participant/dkgs' \
      -H 'accept: application/json' \
      -H "Authorization: Bearer $DIVA_API_KEY"
  fi
fi
