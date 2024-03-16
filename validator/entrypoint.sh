#!/bin/bash

case $_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY in
"prysm-holesky.dnp.dappnode.eth")
  BEACON_RPC_PROVIDER="beacon-chain.prysm-holesky.dappnode:4000"
  ;;
"teku-holesky.dnp.dappnode.eth")
  BEACON_RPC_PROVIDER="beacon-chain.teku-holesky.dappnode:4000"
  ;;
"lighthouse-holesky.dnp.dappnode.eth")
  BEACON_RPC_PROVIDER="beacon-chain.lighthouse-holesky.dappnode:4000"
  ;;
"nimbus-holesky.dnp.dappnode.eth")
  BEACON_RPC_PROVIDER="beacon-validator.nimbus-holesky.dappnode:4500"
  ;;
"lodestar-holesky.dnp.dappnode.eth")
  BEACON_RPC_PROVIDER="beacon-chain.lodestar-holesky.dappnode:4000"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY: $_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY"
  BEACON_RPC_PROVIDER=$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY
  ;;
esac

exec validator \
  --accept-terms-of-use \
  --beacon-rpc-provider="${BEACON_RPC_PROVIDER}" \
  --monitoring-host=0.0.0.0 \
  --validators-external-signer-public-keys="http://diva.diva-holesky.public.dappnode:9000/api/v1/eth2/publicKeys" \
  --validators-external-signer-url="http://diva.diva-holesky.public.dappnode:9000" \
  --web \
  --wallet-dir=/jwt \
  --grpc-gateway-host=0.0.0.0 \
  --graffiti="Diva operator"
