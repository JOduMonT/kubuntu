#!/bin/bash -eux

cd $HOME
npm uninstall `ls -1 node_modules | tr '/\n' ' '`
rm -Rf node_modules

cd /usr/lib
sudo npm uninstall `ls -1 node_modules | tr '/\n' ' '`
sudo rm -Rf node_modules

sudo apt purge -y nodejs
