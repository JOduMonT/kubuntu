bash <(curl -sk https://raw.githubusercontent.com/litespeedtech/ls-cloud-image/master/Setup/nodejssetup.sh)
bash <(curl -sk https://raw.githubusercontent.com/litespeedtech/ls-cloud-image/master/Cloud-init/per-instance.sh)

apt install -y ufw
ufw allow 22,53,80,443,7080,8088/tcp
ufw default reject
echo "y" > ufw enable
reboot
