#!/bin/bash

#Instalar Network Manager
apt install network-manager

#eth0, eth1, etc.: Interfaces Ethernet cableadas.
#wlan0, wlan1, etc.: Interfaces de red inalámbrica (Wi-Fi).
#lo: La interfaz de bucle invertido, utilizada para comunicaciones internas en la máquina.
#usb0, usb1, etc.: Interfaces de red a través de dispositivos USB.
#enp0s3, enp1s0, etc.: Nombres de interfaces predictivos modernos, derivados del bus y el puerto de conexión.
#wlp3s0, wlp2s0, etc.: Nombres de interfaces predictivos para redes inalámbricas.

#Remover Inmutabilidad
#chattr -i /etc/network/interfaces
#Obtener la interfaz de la máquina
#IP=$(hostname -I)

#Pedir la interfaz de red
MIC=$(ip addr show | awk '/inet.*brd/{print $NF}')
echo $MIC
#Pedir la IP y establecerla
echo "Introduce la IP de la máquina"
read IP0base
IP0="\taddress $IP0base"
echo "Introduce la máscara de red"
read MASK0base
MASK0="\tnetmask $MASK0base"
echo "Introduce la puerta de enlace"
read GATEWAY0base
GATEWAY0="\tgateway $GATEWAY0base"
echo "Introduce el DNS primario, si no tienes, introduce "_", o la puerta de enlace para uno dinamico"
read DNS01base
DNS01="\tdns-nameservers $DNS01base"
echo "Introduce el DNS secundario, si no tienes, introduce "_", o la puerta de enlace para uno dinamico"
read DNS02base
DNS02="\tdns-nameservers $DNS02base"