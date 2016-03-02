#!/bin/bash

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

echo "Cleaning Apt"
sudo apt-get --purge autoremove
sudo apt-get autoclean
sudo apt-get clean
#
echo -e "Emptying the trashes..."
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e "Deleting backup  '~' files"
sudo find /. -type f -name '*~' -exec rm -f '{}' \;

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
echo -e "Removing old config files..."
sudo apt purge -y $OLDCONF

# Rotate the logs
echo "Rotating and deleting logs...."
service rsyslog stop
find /var/log -type f | while read f; do echo -ne '' > $f; done
/etc/cron.daily/logrotate
find /var/log -type f -name "*.gz" -exec rm -f {} \;
find /var/log -type f -name "*.1" -exec rm -f {} \;
find /var/log -type f -name "*.old*" -exec rm -f {} \;

echo "==> Disk usage before cleanup"
echo "${DISK_USAGE_BEFORE_CLEANUP}"

echo "==> Disk usage after cleanup"
df -h
service rsyslog start
exit
