### bleachit
sudo apt install -y bleachbit
mkdir $HOME/.config/bleachbit
wget -O $HOME/.config/bleachbit/bleachbit.ini https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-common-settings/-/raw/master/etc/skel/.config/bleachbit/bleachbit.ini
sudo cp -r $HOME/.config/bleachbit /etc/skel/.config/
