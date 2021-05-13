#!/bin/bash -eux

## REFRESH SOURCE
sudo apt update

## INSTALL
### by category
CrossPlatform=""
Development="go-mtpfs kdiff3-qt sqlitebrowser virt-viewer"
Documentation="gimp-help-en"
Editors="libreoffice"
Email="thunderbird"
Fonts=""
GNOME="adwaita-icon-theme-full"
Graphics="flameshot gimp gimp-plugin-registry inkscape"
Internet="curl"
Java="icedtea-netx"
KDE="dolphin-nextcloud filelight kid3 libreoffice-kde5 soundconverter rsibreak"
Libraries="gvfs-fuse limesuite-udev"
Meta=""
MiscGraph=""
MiscText="qemu-kvm qemu-utils"
Multimedia=""
Networking="bridge-utils filezilla iputils-arping iputils-tracepath kleopatra krdc netcat-openbsd network-manager-openvpn nextcloud-desktop nmapsi4 qbittorrent tor wireshark-qt"
Python="python3-pip"
SysAdmin="etckeeper libvirt-daemon libvirt-daemon-system virt-manager"
TeXAuth=""
Utilities="accountwizard keepass2 krename nagstamon rmlint zstd"
VCS="git"
Video="obs-studio openshot-qt vlc-plugin-bittorrent"
Word="aspell-fr"

sudo apt install -y $CrossPlatform $Development $Documentation \
  $Editors $Email $Fonts $GNOME $Graphics $Internet $Java $KDE $Libraries \
  $Meta $MiscGraph $MiscText $Multimedia $Networking \
  $Python $SysAdmin $TeXAuth $Utilities $VCS $Video $Word

## PURGE
### by category
Communication="ippusbxd usb-modeswitch usb-modeswitch-data"
CrossPlatform="cdrdao ntfs-3g"
Debug="libc6-dbg"
Databases="firebird3.0-common firebird3.0-server-core firebird3.0-utils libreoffice-sdbc-firebird"
Development="snapd qml-module-qtquick-virtualkeyboard"
Documentation="gimp-help-common gimp-help-en kdiff3-doc manpages manpages-dev nextcloud-desktop-doc"
Editors="kate libreoffice-java-common"
Email=""
Fonts="fonts-crosextra-caladea fonts-crosextra-carlito fonts-dejavu-extra fonts-hack fonts-kacst fonts-kacst-one fonts-khmeros-core fonts-lao fonts-liberation2 fonts-linuxlibertine fonts-lklug-sinhala fonts-noto-cjk fonts-noto-extra fonts-noto-hinted fonts-noto-mono fonts-noto-ui-core fonts-noto-unhinted fonts-sil-abyssinica fonts-sil-gentium-basic fonts-sil-gentium fonts-sil-padauk fonts-thai-tlwg fonts-tibetan-machine fonts-tlwg-garuda fonts-tlwg-kinnari fonts-tlwg-laksaman fonts-tlwg-loma fonts-tlwg-mono fonts-tlwg-norasi fonts-tlwg-purisa fonts-tlwg-sawasdee fonts-tlwg-typewriter fonts-tlwg-typist fonts-tlwg-typo fonts-tlwg-umpush fonts-tlwg-waree"
GNOME="cups-pk-helper humanity-icon-theme signon-ui-x11 signond ubuntu-mono"
Graphics="blender kde-spectacle"
Internet="libreoffice-script-provider-js"
Java="libreoffice-report-builder libreoffice-report-builder-bin libreoffice-script-provider-bsh"
KDE="kaccounts-integration kalarm kate5-data kio-audiocd knotes konsolekalendar ktnef kwin-addons plasma-discover"
Libraries="libfbclient2 libwacom-bin mesa-vulkan-drivers signon-plugin-password"
Mathematics="libreoffice-nlpsolver"
Meta="fonts-indic kubuntu-wallpapers"
MiscGraph="freerdp2-x11 im-config libreoffice-style-elementary xfonts-scalable xserver-xorg-input-all xserver-xorg-legacy xserver-xorg-input-wacom xserver-xorg-video-all xserver-xorg-video-fbdev xserver-xorg-video-qxl xserver-xorg-video-vmware xserver-xorg-video-amdgpu xserver-xorg-video-intel xserver-xorg-video-radeon xserver-xorg-video-ati xserver-xorg-video-nouveau xserver-xorg-video-vesa xsettingsd"
MiscText="at-spi2-core libreoffice-wiki-publisher libreoffice-sdbc-mysql libreoffice-sdbc-postgresql memtest86+ ubuntu-advantage-tools qemu-utils"
Multimedia=""
Networking="akonadiconsole akregator ibverbs-providers netplan.io telnet"
Python=""
SysAdmin="bolt usb-creator-kde xdg-desktop-portal"
TeXAuth="wbritish"
Utilities="fakeroot os-prober sharutils ubuntu-advantage-tools vim-tiny"
VCS=""
Video=""
Word="printer-driver-brlaser printer-driver-c2esp printer-driver-foo2zjs printer-driver-m2300w printer-driver-min12xxw printer-driver-ptouch printer-driver-pxljr printer-driver-sag-gdi printer-driver-splix wbritish"

sudo apt purge -y $Communication $CrossPlatform $Database $Debug $Development $Documentation \
  $Editors $Email $Fonts $GNOME $Graphics $Internet $Java $KDE $Libraries \
  $Mathematics $Meta $MiscGraph $MiscText $Multimedia $Networking \
  $Python $SysAdmin $TeXAuth $Utilities $VCS $Video $Word

### reinstall only graphical driver use
sudo apt install -y $(apt search $(lspci -v|grep -A16 "VGA controller"|grep driver|rev|cut -d' ' -f1|rev)|grep xserver-xorg-|cut -d/ -f1)

## UPGRADE
sudo apt upgrade -y

## AUTOREMOVE
sudo apt purge -y akonadi-server akonadi-backend-mysql \
  kaddressbook kcalc kde-config-tablet kdepim-addons kdepim-runtime kdepim-themeeditors kmail kmailtransport-akonadi korganizer kwayland-integration kwin-wayland \
  libreoffice-nlpsolver libreoffice-wiki-publisher \
  qtwayland5
sudo apt autoremove --purge -y

echo -e '
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0' | tee -a /etc/sysctl.conf 
sysctl -p /etc/sysctl.conf

sudo nmcli con add ifname br0 type bridge con-name br0
sudo nmcli con add type bridge-slave ifname enp0s31f6 master br0
sudo nmcli con modify br0 bridge.stp no
