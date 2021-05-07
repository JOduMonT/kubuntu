wget -O /tmp/rambox-ce.deb https://github.com/$(curl -s https://github.com/ramboxapp/community-edition/releases/tag/0.7.7|grep -m1 amd64.deb|cut -d\" -f2)
sudo dpkg -i /tmp/rambox-ce.deb
