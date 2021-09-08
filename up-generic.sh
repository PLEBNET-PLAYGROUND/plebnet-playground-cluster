#This is for internal testing only
: ${ARCH:=x86_64-linux-gnu}
: ${nodes=1}

python plebnet_generate.py ARCH=$ARCH nodes=$nodes

#Remove
docker-compose down 
sudo rm -rf volumes


#Create Datafile

mkdir volumes
for (( i=0; i<=$nodes-1; i++ ))
do
    mkdir volumes/lnd_datadir_$i
    mkdir volumes/bitcoin_datadir_$i
    mkdir volumes/tor_datadir_$i
    mkdir volumes/tor_servicesdir_$i
    mkdir volumes/tor_torrcdir_$i
done
docker-compose build --build-arg ARCH=$ARCH
docker-compose up --remove-orphans -d

