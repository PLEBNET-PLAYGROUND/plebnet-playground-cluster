
for i in {0..4}
do
#echo "Talking to playground-lnd-${i}..."
#echo "Connecting to playground cloud seed node 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e@104.131.10.218:9735"
#    docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon disconnect 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e
#    docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect --perm 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e@xrybvh4myas4rr3p6itf5ib6zqtrfb5gyb5246bakifev5s62rlicyad.onion:9735
#    ./getcoins.py -n playground-lnd-${i}
#   docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon walletbalance | jq .total_balance
    #docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon openchannel 03ee9d906caa8e8e66fe97d7a76c2bd9806813b0b0f1cee8b9d03904b538f53c4e 80000000 40000000 --min_confs 0
    echo i=$i
    #echo line 13
    LND_ID_1=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==1')
    LND_ID_2=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==2')
    LND_ID_3=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==3')
    LND_ID_4=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==4')
    LND_ID_5=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==5')
    LND_ID_6=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==6')
    LND_ID_7=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==7')
    LND_ID_8=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==8')
    LND_ID_9=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==9')
    LND_ID_10=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==10')
    LND_ID_11=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==11')
    LND_ID_12=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==12')
    LND_ID_13=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==13')
    LND_ID_14=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==14')
    LND_ID_15=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==15')
    LND_ID_16=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==16')
    LND_ID_17=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==17')
    LND_ID_18=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==18')
    LND_ID_19=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==19')
    LND_ID_20=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==20')
    LND_ID_21=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==21')
    LND_ID_22=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==22')
    LND_ID_23=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==23')
    LND_ID_24=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==24')
    LND_ID_25=$(docker ps | awk '/lnd/'|awk ' {print $1}' | awk 'NR==25')
     #echo line 39
    if ! test -z "$publicIPConnect"; then
        #docker exec -it $LND_ID_0 sh -c "lncli --network=signet getnetworkinfo"
        #docker exec -it $LND_ID_1 sh -c "lncli --network=signet getnetworkinfo"
        #docker exec -it $LND_ID_2 sh -c "lncli --network=signet getnetworkinfo"
        #docker exec -it $LND_ID_3 sh -c "lncli --network=signet getnetworkinfo"
        #docker exec -it $LND_ID_4 sh -c "lncli --network=signet getnetworkinfo"
        #docker exec -it $LND_ID_5 sh -c "lncli --network=signet getnetworkinfo"
        #docker exec -it $LND_ID_0 sh -c "ADDRESS=$publicIPConnect && export ADDRESS && lncli --network=signet --macaroonpath=/root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $ADDRESS"
        docker exec -it $LND_ID_1 sh -c "lncli"
        docker exec -it $LND_ID_1 sh -c "export"
        docker exec -it $LND_ID_1 sh -c "export $publicIPConnect"
        #docker exec -it $LND_ID_1 sh -c "ADDRESS=$publicIPConnect && export $ADDRESS && echo $ADDRESS && lncli --network=signet --macaroonpath=/root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $ADDRESS:9735"
        #docker exec -it $LND_ID_2 sh -c "ADDRESS=$publicIPConnect && export $ADDRESS && echo $ADDRESS && lncli --network=signet --macaroonpath=/root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $ADDRESS:9735"
        #docker exec -it $LND_ID_3 sh -c "ADDRESS=$publicIPConnect && export $ADDRESS && echo $ADDRESS && lncli --network=signet --macaroonpath=/root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $ADDRESS:9735"
        #docker exec -it $LND_ID_4 sh -c "ADDRESS=$publicIPConnect && export $ADDRESS && echo $ADDRESS && lncli --network=signet --macaroonpath=/root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $ADDRESS:9735"
        #docker exec -it $LND_ID_5 sh -c "ADDRESS=$publicIPConnect && export $ADDRESS && echo $ADDRESS && lncli --network=signet --macaroonpath=/root/.lnd/data/chain/bitcoin/signet/admin.macaroon connect $ADDRESS:9735"
        #docker exec -it $LND_ID_0 sh -c "lncli --network=signet listpeers"
        #docker exec -it $LND_ID_1 sh -c "lncli --network=signet listpeers"
        #docker exec -it $LND_ID_2 sh -c "lncli --network=signet listpeers"
        #docker exec -it $LND_ID_3 sh -c "lncli --network=signet listpeers"
        #docker exec -it $LND_ID_4 sh -c "lncli --network=signet listpeers"
        #docker exec -it $LND_ID_5 sh -c "lncli --network=signet listpeers"

    fi
    hostIp=$(docker exec -it playground-lnd-${i} hostname -i | tr -d '\n')
    # nodeConnect=$(docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon getinfo | jq .uris[] | tr -d  '"')
    pubkey=$(docker exec -it playground-lnd-${i} lncli --macaroonpath /root/.lnd/data/chain/bitcoin/signet/admin.macaroon getinfo | jq .identity_pubkey | tr -d '"' | tr -d '\n')

    publicIPConnect=$pubkey@$hostIp
    echo $publicIPConnect
done
