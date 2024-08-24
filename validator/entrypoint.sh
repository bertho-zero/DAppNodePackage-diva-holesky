#!/bin/bash

case $_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY in
"prysm-holesky.dnp.dappnode.eth")
  CONSENSUS_CLIENT_URL="http://beacon-chain.prysm-holesky.dappnode:3500"
  ;;
"teku-holesky.dnp.dappnode.eth")
  CONSENSUS_CLIENT_URL="http://beacon-chain.teku-holesky.dappnode:3500"
  ;;
"lighthouse-holesky.dnp.dappnode.eth")
  CONSENSUS_CLIENT_URL="http://beacon-chain.lighthouse-holesky.dappnode:3500"
  ;;
"nimbus-holesky.dnp.dappnode.eth")
  CONSENSUS_CLIENT_URL="http://beacon-validator.nimbus-holesky.dappnode:4500"
  ;;
"lodestar-holesky.dnp.dappnode.eth")
  CONSENSUS_CLIENT_URL="http://beacon-chain.lodestar-holesky.dappnode:3500"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY: $_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY"
  EXECUTION_CLIENT_URL=$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY
  ;;
esac

exec /home/user/nimbus_validator_client \
  --doppelganger-detection=false \
  --non-interactive \
  --web3-signer-update-interval=120 \
  --beacon-node="${CONSENSUS_CLIENT_URL}" \
  --suggested-fee-recipient=0xDeb5A7ff81d445AC7f86fd7A9d800763C058B494 \
  --graffiti=Diva \
  --web3-signer-url=http://diva.diva-holesky.public.dappnode:9000
