#!/bin/bash

set -eu

arch-chroot /mnt << EOF
passwd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL$/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
useradd -m -G wheel,audio,video -s /bin/bash $1
passwd $1
EOF
