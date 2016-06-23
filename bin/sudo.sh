#!/bin/sh
echo 'copy my-sudo to /etc/sudoers.d'
cp -v ~/github/dotfiles/files/my-sudo.txt /etc/sudoers.d/
# Reload Bash Config
echo 'Finished'
