#!/bin/bash

# Install Curl
echo "Installing Curl..."
sudo apt-get update && sudo apt-get install -y curl

# Install Kubernetes
echo "Installing Kubernetes..."
# Add Kubernetes repository and key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# Install Kubernetes components
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# Install Docker
echo "Installing Docker..."
# Install prerequisite packages
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add Docker repository for Ubuntu 20.04 (replace 'focal' with your Ubuntu version if different)
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# Update package index again after adding Docker repository
sudo apt-get update
# Install Docker CE
sudo apt-get install -y docker-ce

echo "Installation completed successfully."