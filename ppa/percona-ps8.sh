sudo apt install -y gnupg2
wget -O - https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb | sudo dpkg -i
sudo apt update
sudo percona-release setup ps80
sudo apt install -y percona-server-server
