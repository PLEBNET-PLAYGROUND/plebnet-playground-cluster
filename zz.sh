
for i in {0..24} 
do 
#echo "Talking to playground-lnd-${i}..."
#echo "Connecting to playground cloud seed node 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e@104.131.10.218:9735"
#    docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon disconnect 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e
#    docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect --perm 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e@xrybvh4myas4rr3p6itf5ib6zqtrfb5gyb5246bakifev5s62rlicyad.onion:9735 
#    ./getcoins.py -n playground-lnd-${i} 
#   docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon walletbalance | jq .total_balance
    #docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon openchannel 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e 80000000 40000000 --min_confs 0
     if ! test -z "$publicIPConnect" 
     then
         echo $publicIPConnect
         docker exec -it playground-lnd-$i lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $publicIPConnect

     fi
     hostIp=$(docker exec -it playground-lnd-${i} hostname -i | tr -d '\n')
   # nodeConnect=$(docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon getinfo | jq .uris[] | tr -d  '"')
     pubkey=$(docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon getinfo | jq .identity_pubkey | tr -d '"' | tr -d '\n')
   
     publicIPConnect=$pubkey@$hostIp
      echo $publicIPConnect
done
