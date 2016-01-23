#!/bin/sh
echo 'copy my-sudo to /etc/sudoers.d'
cp -v ~/github/dotfiles/files/my-sudo /etc/sudoers.d/
# Reload Bash Config
echo 'Finished'
