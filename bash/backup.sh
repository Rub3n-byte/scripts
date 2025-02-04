#!/bin/bash
read -p "What you want to backup?" tipo
if tipo == "backup" do:
    cp -r --backup=CONTROL /etc /mnt/sdz1/backup/etc
if tipo == "update" do:
    cp -r --update=older /home /mnt/sdz1/backup/home