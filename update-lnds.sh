docker-compose stop
dirs=$(ls -d volumes/lnd*)
for f in $dirs
do
    num=$(echo $f | tr -d 'volumes/lnd_datadir_')
    echo $num 
    sudo echo "tor.skip-proxy-for-clearnet-targets=true" >> ${f}/lnd.conf 
done