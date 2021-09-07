#This is for internal testing only
declare ARCH=x86_64-linux-gnu
python plebnet_generate.py ARCH=x86_64-linux-gnu bitcoind_n=1 lnd_n=1 tor_n=1

#Remove
docker-compose down 
declare n=0
#Create Datafile
sudo rm -rf volumes
mkdir volumes
mkdir volumes/lnd_datadir_$n
mkdir volumes/bitcoin_datadir_$n
mkdir volumes/tor_datadir_$n
mkdir volumes/tor_servicesdir_$n
mkdir volumes/tor_torrcdir_$n
docker-compose build --build-arg ARCH=$ARCH
docker-compose up -d
