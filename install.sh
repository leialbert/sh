#!/bin/bash

# Update package list and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install Nginx and PHP
sudo apt install -y nginx php-fpm

# Install common PHP extensions
sudo apt install -y php-mysql php-xml php-gd php-curl php-json php-mbstring php-zip php-intl php-bcmath

# Install MariaDB
sudo apt install -y mariadb-server

# Install Snapd
sudo apt install -y snapd

# Install Certbot via Snapd
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot

# Print success message
echo "Server basic setup complete!"

#!/bin/bash

# Prompt the user to input the server name
read -p "Enter the domain you want to use: " server_name

# Download the configuration file from the specified URL
wget -O /tmp/${server_name}.conf https://raw.githubusercontent.com/leialbert/sh/main/res/your_domain.conf

# Replace the server name in the configuration file
sudo sed -i "s/server_name abc.example.com;/server_name ${server_name};/g" /tmp/${server_name}.conf

# Copy the modified configuration file to the Nginx sites-available directory
sudo cp -f /tmp/${server_name}.conf /etc/nginx/sites-available/

# Test the configuration file syntax
sudo nginx -t -c /etc/nginx/sites-available/${server_name}.conf

# If the test is successful, create a symbolic link to the sites-enabled directory
if [ $? -eq 0 ]; then
  sudo ln -s /etc/nginx/sites-available/${server_name}.conf /etc/nginx/sites-enabled/
  echo "Configuration file ${server_name}.conf successfully linked to sites-enabled directory!"
else
  echo "Configuration file ${server_name}.conf syntax is invalid. Please check the file and try again."
fi

# Restart Nginx to apply the changes
sudo systemctl restart nginx

# Print success message
echo "Server name updated to ${server_name}!"

# Configure HTTPS for the domain using Certbot
sudo certbot --nginx -d ${server_name}

# Print success message
echo "HTTPS configuration for ${server_name} complete!"

echo "Start to intsall v2ray"
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

echo "Start to intsall warp and configure ipv4 and ipv6"
bash <(curl -fsSL git.io/warp.sh) d

echo "Start to configure WARP SOCKS5 proxy"
bash <(curl -fsSL git.io/warp.sh) s5


#!/bin/bash

# Generate a new UUID
new_uuid=$(cat /proc/sys/kernel/random/uuid)

wget -O /tmp/config.json https://raw.githubusercontent.com/leialbert/sh/main/res/config.json

# Replace the old UUID in config.json with the new UUID
sed -i "s/6095a644-66fd-4e5a-b793-f1b496040ab0/$new_uuid/g" /tmp/config.json
# Replace the old host in config.json with the new host
sed -i "s/abc.example.com/$server_name/g" /tmp/config.json
# Copy it to the V2Ray configuration directory
sudo cp -f /tmp/config.json /usr/local/etc/v2ray/config.json
# Reload V2Ray to apply the changes
systemctl restart v2ray






