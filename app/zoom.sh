wget -O /tmp/zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i /tmp/zoom_amd64.deb
sudo apt --fix-broken install -y
