#!/bin/bash
#
# This will automatically install a lot of the packages for a quick start.
# You can configure them yourself according to the readme.
#
# To run:
#   $ sudo ./bulk-install.sh
#
if [[ $USER == "root" ]]; then
    "You should not run this as the root user, this configures local user files!"
fi
