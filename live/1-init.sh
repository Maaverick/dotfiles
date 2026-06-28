#!/bin/bash

#Install basic packages for further setup
pacstrap -K /mnt base linux linux-firmware base-devel vim iwd inetutils

#Getting fs mounted on start up by UUID
genfstab -U /mnt > /mnt/etc/fstab
