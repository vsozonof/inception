#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root (use sudo)." 
   exit 1
fi

read -p "⚠️  Have you set the VM network to 'Attached to Bridge'? (Y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Please set the VM network to 'Attached to Bridge' before proceeding."
    exit 1
fi

apt update && apt upgrade -y
apt install -y make zsh ufw openssh-server curl ca-certificates

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ufw allow ssh
ufw enable
systemctl enable --now ssh

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker

echo "✅ Setup complete! OpenSSH Server and Docker are installed and running."
