### GoLang Linux 64Bits
wget https://golang.org$(curl -s https://golang.org/dl/|grep -m1 linux-amd64|cut -d\" -f4) -O /tmp/go-linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/go-linux-amd64.tar.gz

echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bashrc
export PATH=$PATH:/usr/local/go/bin

## Hugo Extended Linux 64Bits
wget https://github.com$(curl -s https://github.com/gohugoio/hugo/releases|grep extended|grep -m1 64bit.deb|cut -d\" -f2) -O /tmp/hugo_extended_Linux-64bit.deb
sudo dpkg -EGi /tmp/hugo_extended_Linux-64bit.deb
