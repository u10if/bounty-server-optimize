#!/bin/bash

# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Install Python3, pip, and other essential tools
sudo apt install -y python3 python3-pip python3-venv build-essential libssl-dev libffi-dev git curl nano

# Install Go (latest version)
GO_VERSION="1.21.1" # Replace with the latest Go version if necessary
wget https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
go version

# Install httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install spyhunt
git clone https://github.com/gotr00t0day/spyhunt.git
cd spyhunt
pip3 install -r requirements.txt
sudo python3 install.py
cd ..

# Configure SSH server for security optimization
echo "ClientAliveInterval 60" | sudo tee -a /etc/ssh/sshd_config
echo "ClientAliveCountMax 3" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd

# Cleanup /tmp and create a new directory
sudo rm -rf /tmp/*
sudo mkdir -p /new/tmp/dir
export TMPDIR=/new/tmp/dir

# Install nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install dirsearch
git clone https://github.com/maurosoria/dirsearch.git --depth 1

# Install other useful tools for bug bounty
sudo apt install -y jq nmap masscan tmux amass ffuf dnsutils

# Final cleanup
sudo apt autoremove -y
sudo apt clean

echo "Bug bounty server setup complete. You are ready to go!"