#!/bin/bash

# Update apt
apt update -y

# Install Nginx
apt install nginx -y

# Check Nginx status
systemctl status nginx

# Enable and start Nginx
systemctl enable nginx --now

# Install MySQL
apt install mysql-server mysql-client -y

# Configure MySQL security
mysql_secure_installation <<EOF

Y
2
Y
N
Y
Y
EOF

# Create WordPress database and user
mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
MYSQL_SCRIPT

# Install PHP and PHP-FPM
apt install php php-fpm php-mysql php-gd -y

# Download and install WordPress
wget https://wordpress.org/latest.zip
apt install unzip -y
unzip latest.zip
cd wordpress
cp -r * /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Configure Nginx server block
cd /etc/nginx/sites-enabled/
mv default wordpress

# Modify Nginx configuration with caching and gzip compression
cat > /etc/nginx/sites-enabled/wordpress <<'EOF'
server {
    listen 80;
    listen [::]:80;

    server_name www.linuxtest.hopto.org linuxtest.hopto.org;

    root /var/www/html;
    index index.php index.html index.htm index.nginx-debian.html;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }

    # Cache static files
    location ~* \.(jpg|jpeg|gif|png|css|js|ico|xml)$ {
        expires 30d;
        add_header Cache-Control "public";
    }

    # Enable gzip compression
    gzip on;
    gzip_disable "msie6";
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/javascript application/xml application/xml+rss application/x-font-ttf application/x-font-opentype application/vnd.ms-fontobject image/svg+xml image/x-icon;
}
EOF

# Check Nginx syntax and restart Nginx
nginx -t
systemctl restart nginx

# Install SSL
#install the Uncomplicated Firewall (UFW)
apt install ufw -y

#let in HTTPS traffic, allow the Nginx Full
ufw allow 'Nginx Full' -y
#Install Certbot 
apt install certbot python3-certbot-nginx -y

# install SSL/TLS certificates from Let's Encrypt
certbot --nginx -d linuxtest.hopto.org --email your_email_id@gmail.com
