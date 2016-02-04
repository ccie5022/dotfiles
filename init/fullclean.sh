#!/bin/bash
#
#################################################
# Bill Carter                                   #
# @ccie5022                                     #
#                                               #
# Collections of "cleanups" I have found        #
#                                               #
#                                               #
#################################################

#!/bin/bash


DISK_USAGE_BEFORE_CLEANUP=$(df -h)
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

if [ $USER != root ]; then
    echo -e "Error: must be root"
    echo -e "Exiting..."
    exit 0
fi

# Disk usage before

echo -e "Cleaning apt cache..."
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo -e "Removing old config files..."
apt purge -y $OLDCONF

echo -e "Removing old kernels..."
apt purge -y $OLDKERNELS

echo -e "Updating grub..."
update-grub

echo -e "Emptying the trashes..."
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e "Deleting backup  '~' files"
find /. -type f -name '*~' -exec rm -f '{}' \;

echo -e "Apt cleanup finished!"

# Rotate the logs
echo "Rotating and deleting logs...."
find /var/log -type f | while read f; do echo -ne '' > $f; done
/etc/cron.daily/logrotate
find /var/log -type f -name "*.gz" -exec rm -f {} \;
find /var/log -type f -name "*.1" -exec rm -f {} \;
find /var/log -type f -name "*.old*" -exec rm -f {} \;


##### This section from the Packer and Vagrant cleanup.sh script #######
# zero out the disks
####################
#
# Whiteout root
echo "Zeroing out root..."
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace

# Whiteout /boot
echo "Zeroing out boot...."
count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count
rm /boot/whitespace
echo -e "Finished Zeroing out boot...\n"

echo "=====> Clear out swap and disable until reboot. Please reboot when finished <======"
set +e
swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
case "$?" in
    2|0) ;;
    *) exit 1 ;;
esac
set -e

if [ "x${swapuuid}" != "x" ]; then
    # Whiteout the swap partition to reduce box size
    # Swap is disabled till reboot
    swappart=$(readlink -f /dev/disk/by-uuid/$swapuuid)
    echo -e "Turning off swap...\n"
    /sbin/swapoff "${swappart}"
    dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
    /sbin/mkswap -U "${swapuuid}" "${swappart}"
fi

# Zero out the free space to save space in the final image
dd if=/dev/zero of=/EMPTY bs=1M  || echo "dd exit code $? is suppressed"
rm -f /EMPTY

# Make sure we wait until all the data is written to disk, otherwise
# might quite too early before the large files are deleted
#
# Script End. Give Report...
sync

cat << "EOF"
                                  __
                       _ ,___,-'",-=-.
           __,-- _ _,-'_)_  (""`'-._\ `.
        _,'  __ |,' ,-' __)  ,-     /. |
      ,'_,--'   |     -'  _)/         `\
    ,','      ,'       ,-'_,`           :
    ,'     ,-'       ,(,-(              :
         ,'       ,-' ,    _            ;
        /        ,-._/`---'            /
       /        (____)(----. )       ,'
      /         (      `.__,     /\ /,
     :           ;-.___         /__\/|
     |         ,'      `--.      -,\ |
     :        /            \    .__/
      \      (__            \    |_
       \       ,`-, *       /   _|,\
        \    ,'   `-.     ,'_,-'    \
       (_\,-'    ,'\")--,'-'       __\
        \       /  // ,'|      ,--'  `-.
         `-.    `-/ \'  |   _,'         `.
            `-._ /      `--'/             \
    -hrr-      ,'           |              \
              /             |               \
           ,-'              |               /
          /                 |             -'

Glad that is over...How did we do
EOF

echo "==> Disk usage before cleanup"
echo "${DISK_USAGE_BEFORE_CLEANUP}"

echo "==> Disk usage after cleanup"
df -h
