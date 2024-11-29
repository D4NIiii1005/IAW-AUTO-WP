#!/bin/bash

echo "Comenzando la instalación de LAMP"
echo "Instalando Apache"

sudo apt update && sudo apt upgrade -y

sudo apt install apache2 -y

if [ $? -eq 0 ]; then
        echo "Instalación finalizada correctamente"
else
        echo "Error en la instalación. Abortando..."
fi

sudo apt install mysql-server -y

if [ $? -eq 0 ]; then
        echo "Instalación finalizada correctamente"
else
        echo "Error en la instalación. Abortando..."
fi

sudo apt install php libapache2-mod-php -y

if [ $? -eq 0 ]; then
        echo "Instalación finalizada correctamente"
else
        echo "Error en la instalación. Abortando..."
fi

echo "Instalación de LAMP finalizada correctamente."
