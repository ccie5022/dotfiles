#/bin/bash
if [[ ! $INSTALL_SCRIPT ]]; then
    echo "(!) Error: You must use the ./install.sh script."
    exit
fi

cp $PROJECT_FILE_PATH/.aliases ~
cp $PROJECT_FILE_PATH/.bash_profile ~
cp $PROJECT_FILE_PATH/.bashrc ~
cp $PROJECT_FILE_PATH/.exports ~
cp $PROJECT_FILE_PATH/.functions ~
cp $PROJECT_FILE_PATH/my-sudo /etc/sudoers.d/
cp $PROJECT_FILE_PATH/py-require.txt ~

# Reload Bash Config
source ~/.bashrc

echo "(+) Complete! Make sure to $ source ~/.bashrc"
