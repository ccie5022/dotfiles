#/bin/bash
# This should come first for PPA's
#if [[ ! $INSTALL_SCRIPT ]]; then
#    echo "(!) Error: You must use the ./install.sh script."
#    exit
#fi

sources=(git-core ansible)
echo "(+) Removing and Re-Adding Sources List"

for s in $sources; do
    if [ -f /etc/apt/sources.list.d/$s*ppa ]; then
        sudo rm /etc/apt/sources.list.d/$s*ppa
    fi
    sudo add-apt-repository -y ppa:$s
done
# Other PPAs
sudo add-apt-repository -y ppa:webupd8team/atom

echo "(+) Updating Sources List"
sudo apt-get update

echo "(+) Sources List Update Complete."
