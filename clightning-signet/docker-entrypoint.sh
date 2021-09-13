#!/bin/bash 
set -eo pipefail

initial_config_file()
{
 echo "bitcoin-rpcconnect=${BITCOIN_RPCCONNECT}
bitcoin-rpcuser=${bitcoin_rpcuser}
bitcoin-rpcpassword=${bitcoin_rpcpassword}
alias=${alias}
proxy=${proxy}
log-file=${log_file}
tor-service-password=${tor_service_password}" > /root/.lightning/signet/config
} 

 mkdir -p /root/.lightning/signet/



if [[ ! -f /root/.lightning/signet/config ]]; then
  echo "signet/config file not found in volume, building."
  initial_config_file
else
  echo "signet/config file exists, skipping."
fi

networkdatadir="${LIGHTNINGD_DATA}/${LIGHTNINGD_NETWORK}"
 
exec $@
 