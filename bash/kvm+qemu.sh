#!/bin/bash

# What install
choices=$(dialog --title "What do you want to install?" --checklist "Select what you want to install" 0 0 0 \
QEMU "" off \
libvirtd "" off \
virtinst "" off \
bridge-utils "" off \
virt-manager "" off 3>&1 1>&2 2>&3)

#Install pachages
sudo apt update
sudo apt install -y $(cat /tmp/choices)

#Add user to libvirt and kvm groups
sudo usermod -aG libvirt, kvm $USER
#Enable and start libvirtd
sudo systemctl enable --now libvirtd

# Network
# Allow VM to access the network
sudo virsh net-start default
sudo virsh net-start default
# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Optimize GRUB for IOMMU
grep -Ei "intel" /proc/cpuinfo > /dev/null
if [ $? -eq 0 ]; then
    sudo sed -i s/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"/g /etc/default/grub
    update-grub