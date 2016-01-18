#/bin/bash
Echo 'copy my-sudo to /etc/sudoers.d'
cp -v ~/github/dotfiles/files/my-sudo /etc/sudoers.d/
# Reload Bash Config
source ~/.bashrc
Echo 'Finished'
