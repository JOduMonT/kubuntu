OBS_VS="4.9.1"
NDI_VS="4_4.5.1-1"

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y obs-studio

wget https://github.com/Palakis/obs-ndi/releases/download/$OBS_VS/libndi$NDI_VS_amd64.deb
sudo dpkg -i libndi*
