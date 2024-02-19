#!/bin/bash

# Check if Docker packages are already installed
if rpm -q docker-ce docker-ce-cli containerd.io &> /dev/null; then
    echo "Docker is already installed."
    exit 0
fi

# Install prerequisite packages
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/amazon/docker-ce.repo

# Install Docker packages
echo "Installing Docker..."
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl enable --now docker

echo "Docker installed successfully."
