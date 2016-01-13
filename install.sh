#!/bin/bash
#
# This will automatically install a lot of the packages for a quick start.
# You can configure them yourself according to the readme.
#
# To run:
#   $ sudo ./install.sh
#
if [[ $USER == "root" ]]; then
    "You should not run this as the root user, this configures local user files!"
fi
# Temporary Environment Variable.
export INSTALL_SCRIPT=true
export PROJECT_BIN_PATH= $PWD/bin    # (NO Trailing Slash!)
export PROJECT_FILE_PATH=$PWD/files  # (NO Trailing Slash!)
export PROJECT_TEMP_PATH=$PWD/tmp    # (NO Trailing Slash!)

echo "====================================================================="
echo ""
echo ""
echo " RECOMMENDED: Run 'ppa' first to prevent any problems!"
echo ""
echo " * To exit at anytime press CTRL+C"
echo " * PPA should be installed before base"
echo " * Select a Package to install (Or, Type A at anytime to install ALL)"
echo " * Installation runs after command is entered."
echo ""
echo "====================================================================="
echo ""

while true; do
cat <<- command_list
    CMD         PROCESS
    ----        --------------------------------
    A           Run All Commands
    ----        --------------------------------
    dot         Copy Dotfiles (.bashrc, .vimrc, .gitconfig, .gitignore)
    ppa         Install PPAs (nodejs, wine, git, numix icons)
    base        Install base applications with apt
    py          Install Python (python, python-dev, python-pip)
    q           Quit (or CTRL + C)
command_list

echo ""
echo "====================================================================="
echo ""

read -p "Type a Command: " cmd


    case $cmd in
        A)
            for entry in ./bin/*
            do
                bash $entry
            done
            echo ""
            echo "====================================================================="
            echo ""
            ;;
        dot)
            bash ./bin/dot.sh
            echo ""
            echo "====================================================================="
            echo ""
            ;;
        ppa)
            bash ./bin/ppa.sh
            echo ""
            echo "====================================================================="
            echo ""
            ;;
        base)
            bash ./bin/apt-install.sh
            echo ""
            echo "================Installing Base Apps================================="
            echo ""
            ;;
        py)
            bash ./bin/py.sh
            echo ""
            echo "====================================================================="
            echo ""
            ;;
        q)
            exit 1
            ;;
        *)
            echo ""
            echo "    (!) OOPS! You typed a command that's not available."
            echo ""
            echo "====================================================================="
            echo ""

    esac


done
