#!/bin/bash -eux

apt list --installed >> installed.origin
free -h > mem.origin

add-apt-repository universe
apt update

apt purge -y alsa* bolt btrfs* containerd crda cryptsetup* docker.io dmsetup iw lvm2 lxd* mdadm ntfs-3g open-iscsi sg3* snapd sound-theme* runc telnet thin-provisioning* ubuntu-advantage* wireless* xfsprogs

apt install -y curl intel-microcode

apt autoremove --purge -y

apt upgrade -y

byobu-enable
reboot
