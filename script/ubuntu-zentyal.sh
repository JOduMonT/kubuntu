apt update
apt upgrade -y
apt install -y gnupg software-properties-common
add-apt-repository -y ppa:oisf/suricata-stable
apt-get update
wget -O /tmp/zentyal_installer.sh https://zentyal.com/zentyal_installer.sh
bash /tmp/zentyal_installer.sh
