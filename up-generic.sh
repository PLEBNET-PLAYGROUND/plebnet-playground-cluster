#This is for internal testing only
: ${ARCH:=x86_64-linux-gnu}
: ${bitcoind=10}
: ${lnd=10}
: ${tor=10}

./plebnet_generate.py ARCH=$ARCH bitcoind=$bitcoind lnd=$lnd tor=$tor

#Remove
docker-compose down
sudo rm -rf volumes


#Create Datafile

mkdir volumes
for (( i=0; i<=$bitcoind; i++ ))
do
    mkdir volumes/bitcoin_datadir_$i
done
for (( i=0; i<=$lnd; i++ ))
do
    mkdir volumes/lnd_datadir_$i
done
for (( i=0; i<=$tor; i++ ))
do
    mkdir -p volumes/tor_datadir_$i
    mkdir -p volumes/tor_servicesdir_$i
    mkdir -p volumes/tor_torrcdir_$i
done

docker-compose build --build-arg ARCH=$ARCH
docker-compose up --remove-orphans -d

