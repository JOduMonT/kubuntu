RAMBOX_VS="0.7.9"
wget -O /tmp/rambox-ce.deb https://github.com/$(curl -s https://github.com/ramboxapp/community-edition/releases/tag/$RAMBOX_VS|grep -m1 amd64.deb|cut -d\" -f2)
sudo dpkg -i /tmp/rambox-ce.deb
