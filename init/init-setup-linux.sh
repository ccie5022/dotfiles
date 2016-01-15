#!/bin/bash

## initial setup script

UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile
ln -s ~/Documents/Sync/pass-store .password-store

mkdir ~/tmp/

## update & upgrade
sudo apt-get update
sudo apt-get -y upgrade

## double check we have these
sudo apt-get -y install aptitude subversion subversion-tools git sudo zip stow

## use stow to configure rcfiles
stow vim
stow rcfiles

# setup vim
#cd ~/dotfiles/vim/.vim/
#mkdir bundle
#cd bundle
#wget https://github.com/VundleVim/Vundle.vim/archive/master.zip
#unzip master.zip
#mv Vundle.vim-master vundle
#rm master.zip
#cd

# config git
echo "Configuring Git"
git config --global user.name "ccie5022"
git config --global user.email billyc5022@gmail.com
git config --global push.default simple


## install platinum searcher
echo "Installing Platinum Searcher"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            mkdir $HOME/bin/
            cd $HOME/Downloads/
            wget https://github.com/monochromegane/the_platinum_searcher/releases/download/v1.7.8/pt_linux_amd64.tar.gz
            tar xvfz pt_linux_amd64.tar.gz
            cp pt_linux_amd64/pt $HOME/bin/
            break;;
        No )
            break;;
    esac
done


echo "Setup Build and Misc Tools ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get -y install build-essential automake autoconf2.13 autoconf-archive gnu-standards autoconf-doc libtool gettext
            sudo apt-get -y install linux-headers-`uname -r`
            sudo apt-get -y install curl wget pwgen s3cmd dnsutils pandoc htop ufw pass ruby-dev
			sudo apt-get -y install imagemagick graphicsmagick
            break;;
        No )
            break;;
    esac
done


# data tools
echo "Setup Data Tools?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
			sudo apt-get -y install r-base-core r-base-dev r-cran-plyr r-cran-timeseries r-cran-ggplot2 gnuplot
			break;;
		No )
			break;;
	esac
done


# desktop install
echo "Install Desktop packages"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
			sudo apt-get -y install xclip gpick
			cd /usr/share/fonts/truetype
			sudo unzip $HOME/dotfiles/extras/fonts.zip
			cd
			break;;
		No )
			break;;
	esac
done


# web services
echo "Install Node JS?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
			sudo apt-get -y install nodejs
			break;;
		No )
			break;;
	esac
done


# web services
echo "LAMP Stack?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
			sudo apt-get -y install mysql-client mysql-server memcached apache2
			sudo apt-get -y install php5 php5-cli php5-common php5-curl php5-dev php5-memcached php5-mysql php5-xcache php5-xdebug php5-mcrypt php5-json

            curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
            chmod +x wp-cli.phar
            mv wp-cli.phar $HOME/bin/wp

			break;;
		No )
			break;;
	esac
done

