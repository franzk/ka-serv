#!/bin/bash

# This script sets up a new SSH user for deployment on a VPS.

NEW_USER="deploy_ka_serv"
PROJECT_DIR="ka-serv"
KEY_NAME="id_rsa_ka_serv"

echo "👤 Creating user '$NEW_USER'..."
adduser --disabled-password --gecos "" "$NEW_USER"
usermod -aG sudo "$NEW_USER"

echo "📁 Creating project directory..."
mkdir -p "/home/$NEW_USER/$PROJECT_DIR"
chown -R "$NEW_USER:$NEW_USER" "/home/$NEW_USER/$PROJECT_DIR"

echo "🔐 Generating SSH key pair..."
sudo -u "$NEW_USER" ssh-keygen -t rsa -b 4096 -f "/home/$NEW_USER/.ssh/$KEY_NAME" -N ""

# Add public key to authorized_keys
cat "/home/$NEW_USER/.ssh/${KEY_NAME}.pub" > "/home/$NEW_USER/.ssh/authorized_keys"
chown "$NEW_USER:$NEW_USER" "/home/$NEW_USER/.ssh/authorized_keys"
chmod 600 "/home/$NEW_USER/.ssh/authorized_keys"

echo ""
echo "✅ SSH key pair generated and installed for '$NEW_USER'"
echo ""
echo "📥 Copy the **private key** below and add it to GitHub Secrets (VPS_SSH_KEY):"
echo "----------------------------------------"
cat "/home/$NEW_USER/.ssh/${KEY_NAME}"
echo "----------------------------------------"
echo ""
echo "🎯 Use the following in your GitHub Actions workflow:"
echo "  - host: <your VPS IP or domain>"
echo "  - username: $NEW_USER"
echo "  - key: (the private key above)"