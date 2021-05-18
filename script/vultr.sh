#!/bin/bash -eux

apt list --installed >> installed.origin
free -h > mem.origin

## enLIGHTen UBUNTU
apt purge -y alsa* bolt btrfs* containerd crda cryptsetup* docker docker.io dmsetup iw lvm2 lxd* mdadm ntfs-3g open-iscsi sg3* snapd sound-theme* runc telnet thin-provisioning* ubuntu-advantage* wireless* xfsprogs
apt install -y apt-transport-https ca-certificates curl gnupg intel-microcode lsb-release
apt autoremove --purge -y

## DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io

apt upgrade
