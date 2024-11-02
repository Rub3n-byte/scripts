#!/bin/bash
apt install network-manager
#Remover Inmutabilidad
#chattr -i /etc/network/interfaces
#Obtener la interfaz de la máquina
#IP=$(hostname -I)

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