#!/bin/bash

#Remover Inmutabilidad
#chattr -i /etc/network/interfaces
#Obtener la interfaz de la máquina
#IP=$(hostname -I)

#Pedir la IP y establecerla
echo "Introduce la IP de la máquina"
read IP0
echo "Introduce la máscara de red"
read MASK0
echo "Introduce la puerta de enlace"
read GATEWAY0
echo "Introduce el DNS primario, si no tienes, introduce "_""
read DNS01
echo "Introduce el DNS secundario, si no tienes, introduce "_""
read DNS02