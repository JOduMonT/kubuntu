wget -qO - http://images.45drives.com/repo/keys/aptpubkey.asc | apt-key add -
curl -o /etc/apt/sources.list.d/45drives.list http://images.45drives.com/repo/debian/45drives.list
apt update
apt install -y cockpit cockpit-pcp cockpit-file-sharing
