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
wget -O /tmp/x.conf https://www.leijingwei.com/x.conf

# Replace the server name in the configuration file
sudo sed -i "s/server_name abc.example.com;/server_name ${server_name};/g" /tmp/${server_name}.conf

# Copy the modified configuration file to the Nginx sites-available directory
sudo cp /tmp/x.conf /etc/nginx/sites-available/

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
