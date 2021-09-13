#!/usr/bin/env bash 
set -eo pipefail
echo "connect = ${BITCOIN-RPCCONNECT}"
initial_config_file()
{
  echo "
bitcoin-rpcconnect=${BITCOIN-RPCCONNECT}
bitcoin-rpcuser=${bitcoin-rpcuser}
bitcoin-rpcpassword=${bitcoin-rpcpassword}
alias=${alias}
proxy=${proxy}
log-file=${log-file}
tor-service-password=${tor-service-password}
" > /root/.lightning/signet/config
} 

if [[ ! -f /root/.lightning/signet/config ]]; then
  mkdir -p /root/.lightning/signet/
  echo "signet/config file not found in volume, building."
  initial_config_file
else
  echo "signet/config file exists, skipping."
fi

networkdatadir="${LIGHTNINGD_DATA}/${LIGHTNINGD_NETWORK}"
 
exec $@
 