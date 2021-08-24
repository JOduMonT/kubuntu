NODE_VS="14"
sudo apt install -y curl
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
sudo sh -c "echo deb https://deb.nodesource.com/node_$NODE_VS.x focal main \
> /etc/apt/sources.list.d/nodesource.list"
sudo apt update
sudo apt install -y nodejs
