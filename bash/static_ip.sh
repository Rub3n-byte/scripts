#!/bin/bash

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
echo "Introduce la puerta de enlace"
read GATEWAY0base
echo "Introduce el DNS primario, si no tienes, introduce "_", o la puerta de enlace para uno dinamico"
read DNS01base
echo "Introduce el DNS secundario, si no tienes, introduce "_", o la puerta de enlace para uno dinamico"
read DNS02base
IPstatic=IP0+MASK0+GATEWAY0