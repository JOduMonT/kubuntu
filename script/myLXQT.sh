#!/bin/bash -eux

sudo apt update

PPA_APPS="brave codium inkscape libreoffice obs openshot zoom"
CrossPlatform=""
Development="go-mtpfs sqlitebrowser virt-viewer"
Documentation="gimp-help-en"
Editors="libreoffice"
Email=""
Fonts=""
GNOME=""
Graphics=""
Internet="curl"
Java="icedtea-netx"
KDE=""
Libraries="gvfs-fuse limesuite-udev"
Meta=""
MiscGraph=""
MiscText="qemu-kvm qemu-utils"
Multimedia=""
Networking="bridge-utils iputils-arping iputils-tracepath netcat-openbsd network-manager nm-tray qbittorrent wireshark-qt"
Python=""
SysAdmin="etckeeper libvirt-daemon libvirt-daemon-system virt-manager"
TeXAuth=""
Utilities="keepass2 zstd"
VCS="git"
Video="obs-studio openshot-qt vlc-plugin-bittorrent"
Word=""

sudo apt install -y $CrossPlatform $Development $Documentation \
  $Editors $Email $Fonts $GNOME $Graphics $Internet $Java $KDE $Libraries \
  $Meta $MiscGraph $MiscText $Multimedia $Networking \
  $Python $SysAdmin $TeXAuth $Utilities $VCS $Video $Word

for APP in $PPA_APPS
do
  curl -s https://raw.githubusercontent.com/JOduMonT/Ubuntu/main/app/$APP.sh| sudo bash
done

sudo apt purge -y \
  cloud-init* cups-pk-helper* \
  distro-info \
  eatmydata \
  finalrd \
  htop \
  im-config* \
  kpartx \
  libwacom-bin* lximage-qt \
  mesa-vulkan-drivers* \
  os-prober* \
  thermald \
  ubuntu-advantage-tools* \
  qlipper qps \
  xserver-xorg-input-all* xserver-xorg-legacy* xserver-xorg-video-fbdev* xserver-xorg-video-intel* xserver-xorg-video-vesa*
sudo apt autoremove --purge -y

apt install -y intel-microcode xserver-xorg-video-intel

sudo apt upgrade -y
