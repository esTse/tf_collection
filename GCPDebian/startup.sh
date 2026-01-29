#!/bin/bash
# Update and install dependencies
apt-get update
apt-get install -y curl gnupg2 zip

NODE_MAJOR=22
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt-get update
apt-get install nodejs -y

# Install ncat
# ncat is often part of the nmap package in Debian
apt-get install -y ncat || apt-get install -y nmap

# Output versions to verify
node -v
ncat --version
