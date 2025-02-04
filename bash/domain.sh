#!/bin/bash
#Remover Inmutabilidad
sudo chattr -i /etc/hosts
sudo chattr -i /etc/hostname
#Obtener la IP de la máquina
IP=$(hostname -I)
#Pedir el Hostname y establecerlo
OLD_HOSTNAME=$(hostname)
echo "Introduce el Hostname de la máquina"
read HOSTNAME
sudo sed -i "s/$OLD_HOSTNAME/$HOSTNAME/g" /etc/hosts
sudo hostnamectl set-hostname $HOSTNAME
#Establecer el Dominio
echo "Intoduce el dominio de la máquina"
read DOMAIN
#Obtener el FQDN
FQDN="$HOSTNAME.$DOMAIN"
#Añadir la IP, el FQDN y el Hostname al archivo /etc/hosts
OUTPUT="$IP $FQDN $HOSTNAME"
#Añadir la línea al archivo /etc/hosts
echo Se ha añadido la siguiente línea al archivo /etc/hosts
echo $OUTPUT | sudo tee -a /etc/hosts
#Restablecer Inmutabilidad
sudo chattr +i /etc/hosts
sudo chattr +i /etc/hostname
#Agregar el dominio al archivo /etc/resolv.conf
echo "Se ha añadido el dominio al archivo /etc/resolv.conf"
echo search $DOMAIN | sudo tee -a /etc/resolv.conf
echo "Se ha configurado el dominio de la máquina"

#echo $IP //Debug
#echo $HOSTNAME //Debug
#echo $DOMAIN //Debug
#echo $FQDN //Debug
#echo $OUTPUT //Debug
#cat /etc/hosts //Debug
#cat /etc/resolv.conf //Debug
#hostname //Debug