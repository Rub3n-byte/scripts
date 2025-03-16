#!/bin/bash

# Check if samba is installed and install it if not
ls /bin/smb* > /dev/null 
if [[ $? -ne 0 ]]; then
    OS=$(grep "^ID=" /etc/os-release | cut -d "=" -f 2 | cut -d '"' -f 2)
    if [[ $OS == "debian" || $OS == "ubuntu" || $OS == "mint" ]]; then
        sudo apt update -y -q
        sudo apt install samba smbclient winbind libpam-winbind libnss-winbind -y -q
    elif [[ $OS == "centos" || $OS == "rhel" || $OS == "fedora" ]]; then
        sudo dnf install epel-release -y -q
        sudo dnf install samba samba-client samba-winbind samba-winbind-clients -y -q
    fi
fi

sudo systemctl start smbd nmbd winbind
sudo systemctl enable smbd nmbd winbind
sudo net ads join -U Administrator