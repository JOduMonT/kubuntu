#!/bin/bash -eux

## inspired by Garuda Linux
# 
## references
## - https://gitlab.com/garuda-linux/themes-and-settings
## - https://wiki.archlinux.org/index.php/improving_performance
#
# TODO
## 1. control if the script is run more than once

### FSTAB +NOATIME
sudo sed -ie 's/defaults/defaults,noatime/g' /etc/fstab

### Real-time kernel
sudo add-apt-repository -y ppa:damentz/liquorix
sudo apt update
sudo apt install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64

### Ananicy (https://github.com/Nefelim4ag/Ananicy#installation)
sudo apt install -y make schedtool

git clone https://github.com/Nefelim4ag/Ananicy.git /tmp/Ananicy
/tmp/Ananicy/package.sh debian
sudo dpkg -i /tmp/Ananicy/ananicy-*.deb

sudo systemctl enable ananicy
sudo systemctl start ananicy

### ZRAM (SWAP)
sudo swapoff -a
sudo sed -i "/sw/d" /etc/fstab

sudo apt install -y zram-tools

sudo bash -c 'cat << EOF > /etc/modules-load.d/zram.conf
zram
EOF'

sudo bash -c 'cat << EOF > /etc/modprobe.d/zram.conf
options zram num_devices=1
EOF'

sudo bash -c 'cat << EOF > /etc/udev/rules.d/99-zram.rules
KERNEL=="zram0", ATTR{disksize}="512M",TAG+="systemd"
EOF'

sudo bash -c 'cat << EOF > /etc/systemd/system/zram.service
[Unit]
Description=Swap with zram
After=multi-user.target

[Service]
Type=oneshot 
RemainAfterExit=true
ExecStartPre=/sbin/mkswap /dev/zram0
ExecStart=/sbin/swapon /dev/zram0
ExecStop=/sbin/swapoff /dev/zram0

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl enable zram
sudo systemctl start zram

#### SWAP CONF (from Garuda)
sudo wget -O /usr/lib/systemd/zram-generator.conf https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/systemd/zram-generator.conf

### NOHANG
sudo add-apt-repository -y ppa:oibaf/test
sudo apt update
sudo apt install -y nohang
sudo systemctl enable --now nohang-desktop.service

### common-settings (from Garuda)
sudo wget -O /usr/lib/udev/rules.d/50-sata.rules https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/udev/rules.d/50-sata.rules
sudo wget -O /usr/lib/udev/rules.d/60-ioschedulers.rules https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/udev/rules.d/60-ioschedulers.rules

### Performance Tweak (from Garuda)
sudo wget -O wget -O /usr/lib/udev/rules.d/69-hdparm.rules https://gitlab.com/garuda-linux/themes-and-settings/settings/performance-tweaks/-/raw/master/usr/lib/udev/rules.d/69-hdparm.rules
for config in cpu-governor energy_performance_preference pcie_aspm_performance power_dpm_force_performance_level power_dpm_state ;do
    sudo wget -O /usr/lib/tmpfiles.d/$config.conf https://gitlab.com/garuda-linux/themes-and-settings/settings/performance-tweaks/-/raw/master/usr/lib/tmpfiles.d/$config.conf
done

### sysctl.d (from Garuda)
sudo wget -O /usr/lib/sysctl.d/99-sysctl-garuda.conf https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/usr/lib/sysctl.d/99-sysctl-garuda.conf

#### config for static web generator such as node.js, hugo, ...
sudo bash -c 'cat << EOF >> /etc/sysctl.d/99-sysctl.conf
fs.inotify.max_user_watches=524288
EOF'
