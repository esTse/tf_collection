#!/bin/bash

# Update and install dependencies
apt-get update
apt-get install -y curl

# Install Docker using official script
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Create docker volume for n8n data
docker volume create n8n_data

# Create a directory for workflows
mkdir -p /opt/n8nmation/workflows
chown -R 1000:1000 /opt/n8nmation

# Run n8n
docker run -d \
  --name n8n \
  --restart always \
  -p ${n8n_port}:${n8n_port} \
  -e N8N_ENCRYPTION_KEY=${n8n_key} \
  -e N8N_SECURE_COOKIE=false \
  -v /opt/n8nmation/workflows:/home/node/workflows \
  -v n8n_data:/home/node/.n8n \
  ${n8n_docker_image}

echo "Setup complete. n8n is running."
