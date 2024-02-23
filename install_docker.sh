#!/bin/bash

# Update the package list
sudo yum update -y

# Install docker
sudo yum install -y docker

# Start and enable Docker service if not already started
if ! systemctl is-active --quiet docker; then
    echo "Starting Docker service..."
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Add the user to the docker group to run Docker without sudo
if ! groups $(whoami) | grep -q '\bdocker\b'; then
    sudo usermod -aG docker $(whoami)
fi

# Install docker-compose if not already installed
if ! command -v docker-compose &> /dev/null; then
    echo "Installing docker-compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose    
fi

# Print Docker, Docker Compose, Docker Metadata, and Docker CLI versions
docker --version
docker-compose --version

echo "Docker, Docker Compose installed successfully."
