#!/bin/bash

# Update the package list
sudo yum update -y

# Install dependencies
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Add Docker repository if not already added
if ! yum repolist | grep -q 'docker.*centos'; then
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
fi

# Install Docker if not already installed
if ! rpm -q docker-ce docker-ce-cli containerd.io &> /dev/null; then
    echo "Installing Docker..."
    sudo yum install -y docker-ce docker-ce-cli containerd.io
fi

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
    sudo yum install -y docker-compose
fi

# Install Docker Metadata if not already installed
if ! command -v docker-metadata &> /dev/null; then
    echo "Installing Docker Metadata..."
    sudo yum install -y docker-latest-metadata
fi

# Install Docker CLI if not already installed
if ! command -v docker-latest &> /dev/null; then
    echo "Installing Docker CLI..."
    sudo yum install -y docker-latest
fi

# Print Docker, Docker Compose, Docker Metadata, and Docker CLI versions
docker --version
docker-compose --version
docker-metadata --version
docker-latest --version

echo "Docker, Docker Compose, Docker Metadata, and Docker CLI installed successfully."
