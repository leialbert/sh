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
echo "Server setup complete!"