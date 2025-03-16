#!/bin/bash

#eth0, eth1, etc.: Interfaces Ethernet cableadas.
#wlan0, wlan1, etc.: Interfaces de red inalámbrica (Wi-Fi).
#lo: La interfaz de bucle invertido, utilizada para comunicaciones internas en la máquina.
#usb0, usb1, etc.: Interfaces de red a través de dispositivos USB.
#enp0s3, enp1s0, etc.: Nombres de interfaces predictivos modernos, derivados del bus y el puerto de conexión.
#wlp3s0, wlp2s0, etc.: Nombres de interfaces predictivos para redes inalámbricas.

#Remover Inmutabilidad
chattr -i /etc/network/interfaces

#Conseguir la interfaz de red
MIC=$(ip addr show | awk -F': ' '/eth|wlan|usb|enp|wlp/ && NF>1 {print $2}')
#Parametros de la interfaz
echo "Introduce la IP de la máquina"
read IP0base
IP0="\taddress $IP0base"

echo "Introduce la máscara de red"
read MASK0base
MASK0="\tnetmask $MASK0base"

echo "Introduce la puerta de enlace"
read GATEWAY0base
GATEWAY0="\tgateway $GATEWAY0base"

#DNS, y si no se tiene, se pone la puerta de enlace
echo "Introduce el DNS primario, si no tienes, introduce "_""
read DNS01base
if [ "$DNS01base" == "_" ]; then
    DNS01base=$GATEWAY0base
fi

DNS01="\tdns-nameservers $DNS01base"
echo "Introduce el DNS secundario, si no tienes, introduce "_""
read DNS02base
if [ "$DNS02base" == "_" ]; then
    DNS02base=$GATEWAY0base
fi

DNS02="\tdns-nameservers $DNS02base"
DNS="\tdns-nameservers $DNS01base\n\tdns-nameservers $DNS02base"

#Meterlo en el archivo de configuración
echo -e "auto $MIC\niface $MIC inet static\n$IP0\n$MASK0\n$GATEWAY0\n$DNS01\n$DNS02" > /etc/network/interfaces
echo -e "$DNS" > /etc/resolv.conf

#Reinicio de la ip
ip link set $MIC down
ip link set $MIC up