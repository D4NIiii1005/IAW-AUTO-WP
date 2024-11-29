# IAW-AUTO-WP

Guía para la instalación automatizada de Wordpress.

# Guía para la instalación de WordPress 

---
## Paso 1: Actualizar el sistema e instalar dependencias

```bash
sudo apt update && sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql wget tar
```

---

## Paso 2: Descargar e instalar WordPress

```bash
wget https://wordpress.org/latest.tar.gz -P /tmp
tar -xvzf /tmp/latest.tar.gz -C /tmp
```

---

## Paso 3: Mover WordPress al directorio web

```bash
sudo mv -f /tmp/wordpress /var/www/html
```
## Paso 4: Dar permisos a Apache

```bash
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
```

---

## Paso 4: Configurar la base de datos

```bash
mysql -u root -p <<EOF
DROP DATABASE IF EXISTS wordpress_db_name;
CREATE DATABASE wordpress_db_name;
CREATE USER 'wordpress_db_user'@'ip_cliente_mysql' IDENTIFIED BY 'wordpress_db_password';
GRANT ALL PRIVILEGES ON wordpress_db_name.* TO 'wordpress_db_user'@'ip_cliente_mysql';
FLUSH PRIVILEGES;
EOF
```

Reemplaza **`wordpress_db_name`, `wordpress_db_user`, `ip_cliente_mysql`** y **`wordpress_db_password`** con tus datos reales.

---

## Paso 5: Configurar WordPress


```bash
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i "s/database_name_here/wordpress_db_name/" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/wordpress_db_user/" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/wordpress_db_password/" /var/www/html/wordpress/wp-config.php
sed -i "s/localhost/ip_cliente_mysql/" /var/www/html/wordpress/wp-config.php
```

---

## Paso 6: Ajustar el archivo `index.php`

```bash
sed -i "s#wp-blog-header.php#wordpress/wp-blog-header.php#" /var/www/html/index.php
```

---

## Paso 7: Configurar el archivo `.htaccess`

```bash
cat <<EOF | sudo tee /var/www/html/.htaccess
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
EOF
```

---

## Paso 8: Habilitar mod_rewrite y reiniciar Apache

```bash
sudo a2enmod rewrite
sudo systemctl restart apache2
```

---

## Paso 9: Configurar las security keys de WordPress

```bash
SECURITY_KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
sed -i "/#@-/a $SECURITY_KEYS" /var/www/html/wordpress/wp-config.php
```

---

## Paso 10: Finalizar la Instalación

Accede a la instalación de WordPress desde un navegador web utilizando el dominio configurado o la dirección IP pública. Completa los pasos del asistente de configuración.

---

Has conseguido instalar WordPress!

