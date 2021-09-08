if [[ $# -ne 1 ]];
then 
    echo "up-x64.sh (# of instances)"
    exit
fi

#This is for internal testing only
declare ARCH=x86_64-linux-gnu
python plebnet_generate.py ARCH=x86_64-linux-gnu bitcoind_n=$1 lnd_n=$1 tor_n=$1

#Remove
docker-compose down 
sudo rm -rf volumes
 
#Create Datafile

mkdir volumes
declare n=$1
for (( i=0; i<=n-1; i++ ))
do
    mkdir volumes/lnd_datadir_$i
    mkdir volumes/bitcoin_datadir_$i
    mkdir volumes/tor_datadir_$i
    mkdir volumes/tor_servicesdir_$i
    mkdir volumes/tor_torrcdir_$i
done
docker-compose build --build-arg ARCH=$ARCH
docker-compose up -d

 