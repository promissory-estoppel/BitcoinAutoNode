#!/bin/bash
## Install Dependencies - This is for Ubuntu 16.04 but should work for 14.04 too. Debian is a little different and I will work on that
echo "########### Installing Dependencies and adding repo"
sudo apt install -y wget aptitude nano
##echo you'd be surprised, better to cover all the bases than not enough
sudo apt-get -y install software-properties-common python-software-properties htop iotop
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update 
sudo apt-get -y install curl libevent-dev ufw fail2ban
sudo apt-get -y install git build-essential autoconf libboost-all-dev libssl-dev pkg-config make
sudo apt-get -y install libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev libtool
sudo apt-get -y install libcurl4-openssl-dev db4.8 db4.8++ db4.8-dev++
sudo apt-get -y install automake autogen autotools-dev bsdmaintuils

##I'd recommend some addition in the form of Nixstats or something for outside monitoring as a failsafe, as this is meant to node stats monitoring

echo "########## DB4.8 not necessarily needed but just in case, likewise qt4 and all"
sudo apt-get -y upgrade && apt-get dist-upgrade -y

echo "########### I know that ufw isn't set up ahead of time in Ubuntu, let's set it up, this can be commented out if your settings are good or needs changing"
sudo ufw allow proto tcp from any to any port 22
sudo ufw enable
##this won't disconnect ssh, not as ideal as iptables but cba on a quickie
sudo ufw allow 22/tcp
sudo ufw allow 8333/tcp
sudo ufw allow 8125/udp
sudo ufw allow 2003/tcp
sudo ufw allow 8332/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8000/tcp

echo "######### Creating User"
sudo su -c "useradd builder -s /bin/bash -m -U"

echo "############ Getting it all together first"
cd /home
sudo git clone https://github.com/jlopp/statoshi
sudo git clone http://github.com/jlopp/bitcoin-utils
##sudo sed -i 's/memory          = psutil.phymem_usage()/memory          = psutil.virtual_memory()/g' /home/bitcoin-utils/systemMetricsDaemon.py

echo "########## Preparing Build, change if you will"
cd /home/statoshi
sudo ./autogen.sh
sudo ./configure --enable-cli --disable-gui --enable-hardening --disable-wallet
sudo sed -i 's/127.0.0.1/45.63.13.51/g' /home/statoshi/src/statsd_client.h
sudo make %% make install
randUser=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30`
randPass=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30`

echo "########## Building the basics - Nodejs, forever, statsd, basic build"
sudo apt-get install -y nodejs npm
cd /home
sudo npm install forever -g
sudo git clone https://github.com/etsy/statsd
sudo cp /home/statsd/exampleConfig.js /home/statsd/config.js
sudo sed -i 's/graphiteHost\: \"graphite.example.com\"/graphiteHost\: \"45.63.13.51"\"/g' /home/statsd/config.js


echo "######### Building Bitcoind"
sudo make && make install

echo "######## Setting up Bitcoind"
randUser=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30`
randPass=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30`

echo "sudo -u builder bitcoind -conf=/home/builder/.statoshi/bitcoin.conf -uacomment='$host.YesToCore'" >> /etc/rc.local

echo ""############## "You might need to reboot manually but when you come back plug in the attached bitcoin.conf in $homedir/.bitcoin and you are good to go for part 1 and start bitcoind."

sudo reboot




