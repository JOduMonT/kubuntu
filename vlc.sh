### vlc
sudo apt install -y vlc
mkdir $HOME/.config/vlc
wget -O $HOME/.config/vlc/vlcrc https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/etc/skel/.config/vlc/vlcrc
sudo cp -r $HOME/.config/vlc /etc/skel/.config/
