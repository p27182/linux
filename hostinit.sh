#!/bin/bash
#exec with sudo in ~/
#dev'd on ubuntu 20.04

#apt updates
apt update && apt upgrade

#install zsh
apt install -y zsh zsh-syntax-highlighting zsh-autosuggestions figlet lolcat 

#get .zshrc
wget https://raw.githubusercontent.com/p27182/linux/main/.zshrc

#change shell to zsh
usermod -s /usr/bin/zsh $USER

#pull x bit from motd scripts
chmod -R -x /etc/update-motd.d/*

#change motd target from motd.dynamic to motd
sed -i -e 's/motd.dynamic/motd/g' /etc/pam.d/login
#comment out noupdate
sed -i -e 's/session    optional   pam_motd.so noupdate/#session    optional   pam_motd.so noupdate/g' /etc/pam.d/login

#get motd file
wget https://raw.githubusercontent.com/p27182/linux/main/00-motd

#add x bit and move to the spot...
chmod +x 00-motd && mv 00-motd /etc/update-motd.d/00-motd





