sudo apt install -y gnupg2
wget -O /tmp/percona.deb https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
sudo dpkg -i /tmp/percona.deb
sudo percona-release setup ps80
sudo apt update
sudo apt install -y percona-server-server
