#!/bin/sh

MIGRATION_LOCK_4="/var/diva/migration_locks/migration_004.sh.lock"

# don't execute migration 4 now
touch $MIGRATION_LOCK_4

(
  sleep 5

  echo "Node needs to be restarted and synced, the proccess may take a while..."

  is_alive(){
    is_syncing=true
    while [ "$is_syncing" != "false" ]; do
      sync_response=$(curl -s -X GET \
        "http://localhost:30000/api/v2/protocol/info" \
        -H "accept: application/json" \
        -H "Authorization: Bearer $DIVA_API_KEY")



      is_syncing=$(echo "$sync_response" | jq -r '.data.is_syncing')

      if [ "$is_syncing" == "true" ]; then
        echo "Node started."
        sleep 5
        return 0
      elif [ "$is_syncing" == "false" ]; then
        echo "Node started."
        return 0
      else
        echo "Node is starting..."
        sleep 30
      fi
    done
    return 1
  }

  echo "Waiting for the node to be started..."
  is_alive
  while [ $? -ne 0 ]; do
    sleep 5
    is_alive
  done

  # execute migration 4 after restart
  rm $MIGRATION_LOCK_4

  response=""
  while [ -z "$response" ]; do
    response=$(curl -s -X 'POST' \
      'http://localhost:30000/api/v2/node/reset' \
      -H 'accept: application/json' \
      -H "Authorization: Bearer $DIVA_API_KEY")

    if [ -z "$response" ]; then
      echo "Node is starting, it can take around 1 min. Retrying reset..."
      sleep 30
    fi
  done
  echo "Reset completed."
) &
