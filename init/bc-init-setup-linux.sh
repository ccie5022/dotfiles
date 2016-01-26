#!/bin/bash

## initial setup script

# Install the Repositories and Apps I need
#
echo "Adding Respositories"
sudo add-apt-repository -y ppa:ansible/ansible
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/atom
sudo add-apt-repository -y ppa:gnome-terminator/ppa

## update & upgrade
sudo apt-get update
sudo apt-get -y upgrade
#
echo "Setup Build and Misc Tools ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get -y install git-all git open-vm-tools intel-microcode initramfs-tools ssh python-setuptools python-pip ipython python-crypto python-yaml python-jinja2  atom whois curl htop terminator netmiko ansible
            break;;
        No )
            break;;
    esac
done


# config git
echo "Configuring Git"
git config --global user.name "ccie5022"
git config --global user.email billyc5022@gmail.com
git config --global push.default simple
