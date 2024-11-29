#!/bin/bash

set -x

source /home/ubuntu/scripts/.env

#Solicitar certificado Let's Encrypt

sudo snap install core

sudo snap refresh core

sudo apt remove certbot -y

sudo snap install --classic certbot

sudo certbot --apache -m $CB_MAIL --agree-tos --no-eff-email -d $CB_DOMAIN --non-interactive 

if [ $? -eq 0 ]; then 

        echo "Certificado desplegado correctamente"
else

        echo "Error en el despliegue del certificado"
fi
