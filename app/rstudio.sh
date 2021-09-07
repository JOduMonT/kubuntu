RSTUDIOVS=$(curl https://www.rstudio.com/products/rstudio/download/|grep -m1 amd64.deb|cut -d\" -f2)

sudo apt install -y xcb r-base
wget -O /tmp/rstudio.deb $RSTUDIOVS
sudo dpkg -i /tmp/rstudio.deb
sudo apt -y --fix-broken install
