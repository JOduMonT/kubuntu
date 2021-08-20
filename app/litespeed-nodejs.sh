bash <(curl -sk https://raw.githubusercontent.com/litespeedtech/ls-cloud-image/master/Setup/nodejssetup.sh)
bash <(curl -sk https://raw.githubusercontent.com/litespeedtech/ls-cloud-image/master/Cloud-init/per-instance.sh)

apt install -y ufw
ufw allow 443 # need udp for QUIC https/3
ufw allow 22/tcp
ufw allow 53/tcp
ufw allow 80/tcp
ufw allow 7080/tcp
ufw default reject
echo "y" > ufw enable
reboot
