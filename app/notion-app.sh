wget -O /tmp/notion-app.deb https://github.com/$(curl https://github.com/notion-enhancer/notion-repackaged/releases/|grep .deb|grep -vm1 enhanced|cut -d\" -f2)
sudo dpkg -i /tmp/notion.deb
