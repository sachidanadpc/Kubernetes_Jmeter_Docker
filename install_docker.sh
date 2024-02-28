#!/bin/bash

# Update the package list
sudo apt update -y

# Install docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add the user to the docker group to run Docker without sudo
if ! groups $(whoami) | grep -q '\bdocker\b'; then
    sudo usermod -aG docker $(whoami)
fi

# Check if Docker Buildx Plugin needs to be installed
if [ ! -f ~/.docker/cli-plugins/docker-buildx ]; then
    mkdir -p ~/.docker/cli-plugins
    sudo curl -SL https://github.com/docker/buildx/releases/download/v0.7.1/buildx-v0.7.1.linux-amd64 > ~/.docker/cli-plugins/docker-buildx
    sudo chmod +x ~/.docker/cli-plugins/docker-buildx
fi

# Check if Docker Metadata needs to be installed
if [ ! -x /usr/local/bin/docker-metadata ]; then
    # Download and install Docker Metadata
    sudo curl -sSL https://github.com/docker/metadata/releases/download/v0.5.2/docker-metadata-linux-amd64 -o /usr/local/bin/docker-metadata
    sudo chmod +x /usr/local/bin/docker-metadata
fi

# Install docker-compose if not already installed
if ! command -v docker-compose &> /dev/null; then
    echo "Installing docker-compose..."
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose    
fi

# Start and enable Docker service if not already started
if ! systemctl is-active --quiet docker; then
    echo "Starting Docker service..."
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Print Docker, Docker Compose, Docker Metadata, and Docker CLI versions
docker --version
docker-compose --version

echo "Docker, Docker Compose installed successfully."
