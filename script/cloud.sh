apt list --installed >> installed.origin
free -h > mem.origin

echo -e "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" > /etc/apt/sources.list

add-apt-repository -y ppa:cappelikan/ppa
apt update

apt install -y binutils curl etckeeper make schedtool wget zram-tools

apt purge -y alsa* bolt btrfs* containerd crda cryptsetup* docker.io dmsetup iw lvm2 lxd* mdadm ntfs-3g open-iscsi sg3* snapd sound-theme* runc telnet thin-provisioning* ubuntu-advantage* wireless* xfsprogs
apt autoremove --purge -y
apt upgrade -y

apt install -y mainline

### Ananicy (https://github.com/Nefelim4ag/Ananicy#installation)
git clone https://github.com/Nefelim4ag/Ananicy.git /tmp/Ananicy
/tmp/Ananicy/package.sh debian
sudo dpkg -i /tmp/Ananicy/ananicy-*.deb
sudo systemctl enable ananicy
sudo systemctl start ananicy

wget -O /usr/lib/sysctl.d/99-sysctl-garuda.conf https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/sysctl.d/99-sysctl-garuda.conf

### NOHANG
add-apt-repository -y ppa:oibaf/test
apt update
apt install -y nohang
systemctl enable --now nohang-desktop.service

### common-settings (from Garuda)
wget -O /usr/lib/udev/rules.d/50-sata.rules https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/udev/rules.d/50-sata.rules
wget -O /usr/lib/udev/rules.d/60-ioschedulers.rules https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/udev/rules.d/60-ioschedulers.rules

### Performance Tweak (from Garuda)
wget -O wget -O /usr/lib/udev/rules.d/69-hdparm.rules https://gitlab.com/garuda-linux/themes-and-settings/settings/performance-tweaks/-/raw/master/usr/lib/udev/rules.d/69-hdparm.rules
for config in cpu-governor energy_performance_preference pcie_aspm_performance power_dpm_force_performance_level power_dpm_state ;do
    wget -O /usr/lib/tmpfiles.d/$config.conf https://gitlab.com/garuda-linux/themes-and-settings/settings/performance-tweaks/-/raw/master/usr/lib/tmpfiles.d/$config.conf
done

echo 'fs.inotify.max_user_watches=524288' > /etc/sysctl.d/99-fs_inotify.conf

## CPU Vulnerability Scan
wget https://raw.githubusercontent.com/speed47/spectre-meltdown-checker/master/spectre-meltdown-checker.sh
bash spectre-meltdown-checker.sh >> cpuvuln.log

## SpeedTest
wget https://raw.github.com/blackdotsh/curl-speedtest/master/speedtest.sh
bash speedtest.sh >> netspeed.log

## HardDrive Test
dd if=/dev/zero of=/tmp/test1.img bs=1M count=1024 oflag=dsync >> hdwrite.log
dd if=/dev/zero of=/tmp/test2.img bs=512 count=1000 oflag=dsync >> hdlatency.log
hdparm -t /dev/sda1 >> hdparam.log
hdparm -t /dev/vda1 >> hdparam.log

reboot
