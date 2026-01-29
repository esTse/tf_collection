#!/bin/bash
# Update and install dependencies
apt-get update
apt-get install -y curl gnupg2

# Install Node.js (using setup script for latest LTS is common practice, but standard repo is safer for simplicity unless specified)
# Using standard repo for stability and simplicity as requested "debian vm with node"
apt-get install -y nodejs npm

# Install ncat
# ncat is often part of the nmap package in Debian
apt-get install -y ncat || apt-get install -y nmap

# Output versions to verify
node -v
ncat --version
