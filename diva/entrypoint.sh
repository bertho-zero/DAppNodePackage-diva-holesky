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

MIGRATIONS_DIR="/etc/diva/migrations"
LOCKS_DIR="/var/diva/migration_locks"

mkdir -p "$LOCKS_DIR"

find "$MIGRATIONS_DIR" -name "migration_*.sh" | sort | while read migration; do
  migration_name=$(basename "$migration")
  lock_file="$LOCKS_DIR/$migration_name.lock"

  if [ ! -f "$lock_file" ]; then
    echo "Running migration $migration_name..."
    sh "$migration"
    touch "$lock_file"
    echo "Migration $migration_name completed."
  else
    echo "Migration $migration_name has already been executed."
  fi
done

exec divad \
  --db=/var/diva/config/diva.db \
  --w3s-address=0.0.0.0 \
  --log-level=info \
  --swagger-ui-enabled \
  --master-key="${DIVA_API_KEY}" \
  --execution-client-url="${EXECUTION_CLIENT_URL}" \
  --consensus-client-url="${CONSENSUS_CLIENT_URL}" \
  --chain=holesky \
  --enable-participant \
2>&1 | tee /var/log/divad/divad.log
