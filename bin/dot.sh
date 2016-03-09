#/bin/bash
#if [[ ! $INSTALL_SCRIPT ]]; then
#    echo "(!) Error: You must use the ./install.sh script."
#    exit
#fi
cp ~/github/dotfiles/files/.aliases ~
cp ~/github/dotfiles/files/.bash_profile ~
cp ~/github/dotfiles/files/.bashrc ~
cp ~/github/dotfiles/files/.exports ~
cp ~/github/dotfiles/files/.functions ~
sudo cp ~/github/dotfiles/files/my-sudo.txt /etc/sudoers.d/
#cp ~/github/dotfiles/files/py-require.txt ~

# Reload Bash Config
source ~/.bashrc

echo "(+) Complete! Make sure to $ source ~/.bashrc"
