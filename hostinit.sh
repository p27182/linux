#!/bin/bash
#exec with sudo in ~/
#dev'd on ubuntu 20.04

#apt update
apt update

#install things
things="zsh zsh-syntax-highlighting zsh-autosuggestions openssh-server"

read -p "install figlet and lolcat?: " yn
if [ "$yn" == "y" ];
then
  things="$things figlet lolcat"
  motd=y
fi

read -p "install tree, curl, net-tools, & traceroute?: " yn
if [ "$yn" == "y" ];
then
  things="$things curl net-tools tree traceroute"
fi

apt install -y $things

read -p "run apt upgrade?: " yn
if [ "$yn" == "y" ];
then
  apt upgrade
fi

#change shell to zsh
#usermod -s /usr/bin/zsh $USER
chsh -s $(which zsh) $SUDO_USER

if [ "$motd" == "y" ];
then
  #pull x bit from default motd scripts
  chmod -R -x /etc/update-motd.d/*
  #change motd target from motd.dynamic to motd
  sed -i -e 's/motd.dynamic/motd/g' /etc/pam.d/login
  #comment out noupdate
  sed -i -e 's/session    optional   pam_motd.so noupdate/#session    optional   pam_motd.so noupdate/g' /etc/pam.d/login
  #get motd file
  echo "downloading motd..."
  wget -q https://raw.githubusercontent.com/p27182/linux/main/00-motd
  #add x bit and move to the spot...
  chmod +x 00-motd && mv 00-motd /etc/update-motd.d/00-motd
fi

read -p "disable IPv6?: " yn
if [ "$yn" == "y" ]; 
then
  # create disable ipv6 conf file
  echo "net.ipv6.conf.all.disable_ipv6=1" > /etc/sysctl.d/99-disable-ipv6.conf
  echo "net.ipv6.conf.default.disable_ipv6=1" > /etc/sysctl.d/99-disable-ipv6.conf
  echo "net.ipv6.conf.lo.disable_ipv6=1" > /etc/sysctl.d/99-disable-ipv6.conf
  if ! sysctl --system >/dev/null 2>&1 ; 
  then
    sysctl -p
  fi
fi

echo "downloading .zshrc..."
if [ -n "$SUDO_USER" ]; then
    orig_user="${SUDO_USER:-$USER}"
	sudo -u "$orig_user" wget -q https://raw.githubusercontent.com/p27182/linux/main/.zshrc
	sudo -i -u $SUDO_USER 
else
  wget -q https://raw.githubusercontent.com/p27182/linux/main/.zshrc
  su $USER
fi
