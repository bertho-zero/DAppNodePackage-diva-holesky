#!/bin/sh

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY in
"holesky-geth.dnp.dappnode.eth")
  EXECUTION_CLIENT_URL="ws://holesky-geth.dappnode:8546"
  ;;
"holesky-nethermind.dnp.dappnode.eth")
  EXECUTION_CLIENT_URL="ws://holesky-nethermind.dappnode:8546"
  ;;
"holesky-besu.dnp.dappnode.eth")
  EXECUTION_CLIENT_URL="ws://holesky-besu.dappnode:8546"
  ;;
"holesky-erigon.dnp.dappnode.eth")
  EXECUTION_CLIENT_URL="ws://holesky-erigon.dappnode:8545"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY"
  EXECUTION_CLIENT_URL=$_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY
  ;;
esac

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

exec divad \
  --db=/opt/diva/data/diva.db \
  --w3s-address=0.0.0.0 \
  --execution-client-url="${EXECUTION_CLIENT_URL}" \
  --consensus-client-url="${CONSENSUS_CLIENT_URL}" \
  --tracing \
  --log-level=debug \
  --swagger-ui-enabled \
  --contract=0x703848F4c85f18e3acd8196c8eC91eb0b7Bd0797 \
  --master-key="${DIVA_API_KEY}" \
  --genesis-time="${DIVA_GT}" \
  --gvr="${CHAIN_GVR}" \
  --genesis-fork-version="${CHAIN_GFV}" \
  --current-fork-version="${CHAIN_CFV}" \
  --deposit-contract="${CHAIN_DC}" \
  --chain-id="${CHAIN_ID}" \
  --bootnode-address="${DIVA_BOOTNODE}" \
2>&1 | tee /var/log/divad/divad.log
