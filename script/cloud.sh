apt list --installed >> installed.origin
free -h > mem.origin

echo -e "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" > /etc/apt/sources.list

add-apt-repository -y ppa:cappelikan/ppa
apt update

apt install -y binutils curl etckeeper wget

apt purge -y alsa* bolt btrfs* containerd crda cryptsetup* docker.io dmsetup iw lvm2 lxd* mdadm ntfs-3g open-iscsi sg3* snapd sound-theme* runc telnet thin-provisioning* ubuntu-advantage* wireless* xfsprogs
apt autoremove --purge -y
apt upgrade -y

apt install -y mainline

wget https://raw.githubusercontent.com/speed47/spectre-meltdown-checker/master/spectre-meltdown-checker.sh
bash spectre-meltdown-checker.sh >> cpuvuln.log

wget https://raw.github.com/blackdotsh/curl-speedtest/master/speedtest.sh
bash speedtest.sh >> netspeed.log

dd if=/dev/zero of=/tmp/test1.img bs=1M count=1024 oflag=dsync >> hdwrite.log
dd if=/dev/zero of=/tmp/test2.img bs=512 count=1000 oflag=dsync >> hdlatency.log
hdparm -t /dev/sda1 >> hdparam.log
hdparm -t /dev/vda1 >> hdparam.log

reboot
