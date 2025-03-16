#!/bin/bash
#Remover Inmutabilidad
sudo chattr -i /etc/hosts
sudo chattr -i /etc/hostname

#Cambiar el hostname
read -p "Hostname" HOSTNAME
echo HOSTNAME > /etc/hostname

#Cambiar el archivo hosts
read -p "Local IP" LOCAL_IP
read -p "Domain" DOMAIN
echo "$LOCAL_IP $DOMAIN $HOSTNAME" >> /etc/hosts

#Reiniciar el servicio systemd-resolved
sudo systemctl restart systemd-resolved