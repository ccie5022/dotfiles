#/bin/bash
if [[ ! $INSTALL_SCRIPT ]]; then
    echo "(!) Error: You must use the ./install.sh script."
    exit
fi

sudo apt-get install -y\
    python-dev\
    python-setuptools\
    python-pip\
    python-crypto

# IMPORTANT: Do NOT have a trailing \ on the LAST item!

sudo pip install -r ~/py-require.txt --upgrade

echo "(+) Complete! Run with $ python and $ pip"
