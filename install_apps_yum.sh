#!/bin/bash

# Install Curl
echo "Installing Curl..."
sudo yum install -y curl

# Install Kubernetes
echo "Installing Kubernetes..."
# Add Kubernetes repository
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Install Kubernetes components
sudo yum install -y kubelet kubeadm kubectl

# Start and enable kubelet service
sudo systemctl enable --now kubelet

# Install Docker
echo "Installing Docker..."
# Install prerequisite packages
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# Install Docker CE
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl enable --now docker

echo "Installation completed successfully."
