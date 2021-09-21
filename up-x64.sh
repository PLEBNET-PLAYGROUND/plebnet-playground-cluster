if [[ $# -ne 1 ]];
then 
    echo "up-x64.sh (# of instances)"
    exit
fi

#This is for internal testing only
declare TRIPLET=x86_64-linux-gnu
declare torcount=$(expr $1 / 8 + 1)
python plebnet_generate.py TRIPLET=x86_64-linux-gnu bitcoind=$1 lnd=$1 tor=$torcount

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
  
#    mkdir volumes/tor_torrcdir_1
done
for (( i=0; i<=torcount-1; i++ ))
do 
    mkdir volumes/tor_datadir_$i
    mkdir volumes/tor_servicesdir_$i
    mkdir volumes/tor_torrcdir_$i
done

docker-compose build --build-arg TRIPLET=$TRIPLET
docker-compose up -d

 
