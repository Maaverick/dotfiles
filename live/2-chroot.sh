#!/bin/bash

set -eu

arch-chroot /mnt << EOF
ln -sf /usr/share/zoneinfo/$1/ /etc/localtime
hwclock --systohc
sed -i '/^#.*en_US.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "$2" > /etc/hostname
mkinitcpio -P
systemctl enable iwd
systemctl enable systemd-networkd
systemctl enable systemd-resolved
EOF
