#!/bin/bash
# Fixing Swappines - Version bump 2

sudo su
echo "Fixing Swappines"
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
