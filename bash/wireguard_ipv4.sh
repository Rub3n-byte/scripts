#!/bin/bash

OS=$(grep "^ID=" /etc/os-release | cut -d "=" -f 2 | cut -d '"' -f 2)

if [[ $OS == "debian" || $OS == "ubuntu" || $OS == "mint" ]]; then
    sudo apt update -y -q
    sudo apt install wireguard -y -q
elif [[ $OS == "centos" || $OS == "rhel" || $OS == "fedora" ]]; then
    sudo dnf install epel-release elrepo-release -y -q
    sudo dnf install wireguard-tools -y -q
elif [[ $OS == "arch" || $OS == "manjaro" ]]; then
    sudo pacman -Ssy --noconfirm -q
    sudo pacman -S wireguard-tools -q --nocomfirm
fi

mkdir ~/.wireguard-keys
sudo wg genkey | tee ~/.wireguard-keys/privatekey | wg pubkey > ~/.wireguard-keys/publickey

PRIVATE_KEY=$(cat ~/.wireguard-keys/privatekey)
PUBLIC_KEY=$(cat ~/.wireguard-keys/publickey)
read -p "Enter the IP address for the client VPN: IP/MASK " IP_ADDRESS
read -p "Enter the port for the client VPN: " PORT
read -p "Type the allowed IPs for the client VPN: 0.0.0.0 is all " ALLOWED_IPS

echo -e "[Interface]
Address = $IP_ADDRESS
SaveConfig = true
ListenPort = $PORT
PrivateKey = $PRIVATE_KEY

[Peer]
PublicKey = $PUBLIC_KEY
AllowedIPs = $ALLOWED_IPS" > /etc/wireguard/wg0.conf

sudo sed -i -n s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g /etc/sysctl.conf
sudo sysctl -p

sudo wg-quick up wg0
sudo systemctl enable wg-quick@wg0
sudo systemctl --now start wg-quick@wg0

sudo firewall-cmd --add-port=$PORT/udp --permanent
sudo firewall-cmd --reload

read -p "Do you want to generate a config file for the client VPN? (y/n): " CONFIG_FILE_YN

if [[ $CONFIG_FILE_YN == "y" ]]; then
    read -p "CONFIG_FILE/QR_CODE " CONFIG_FILE_EXPORT
    IP_PUBLIC=$(curl -4 ifconfig.net)

    mkdir ~/.wireguard-keys/wireguard-client/
    sudo wg genkey | tee ~/.wireguard-keys/wireguard-client/privatekey | wg pubkey > ~/.wireguard-keys/wireguard-client/publickey

    PRIVATE_KEY_CLIENT=$(cat ~/.wireguard-keys/wireguard-client/privatekey)
    PUBLIC_KEY_CLIENT=$(cat ~/.wireguard-keys/wireguard-client/publickey)

    echo -e "[Interface]
    Address = $IP_ADDRESS
    SaveConfig = true
    ListenPort = $PORT
    PrivateKey = $PRIVATE_KEY_CLIENT

    [Peer]
    PublicKey = $PUBLIC_KEY_CLIENT
    AllowedIPs = $ALLOWED_IPS
    Enpoint = $IP_PUBLIC:$PORT" > ~/.wireguard-keys/wireguard-client/wg0-client.conf

    read -p "Enter the range for the client VPN EX:10.8.0.2, 10.8.0.100: " RANGE
    sudo wg set wg0 peer $PUBLIC_KEY_CLIENT allowed-ips $RANGE

    if [[ $CONFIG_FILE_EXPORT == "CONFIG_FILE" ]]; then 
        echo File created on ~/.wireguard-keys/wireguard-client/wg0-client.conf
    elif [[ $CONFIG_FILE_EXPORT == "QR_CODE" ]]; then
        sudo qrencode -t ansiutf8 < ~/.wireguard-keys/wireguard-client/wg0-client.conf
    fi
fi
