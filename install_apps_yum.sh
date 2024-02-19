#!/bin/bash

# Install Curl
echo "Installing Curl..."
sudo yum install -y curl

# Install Kubernetes (if not already installed)
if ! rpm -q kubelet kubeadm kubectl &> /dev/null; then
    echo "Installing Kubernetes..."
    cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
    sudo yum install -y kubelet kubeadm kubectl
    sudo systemctl enable --now kubelet
fi

# Install Docker (if not already installed)
if ! rpm -q docker-ce docker-ce-cli containerd.io &> /dev/null; then
    echo "Installing Docker..."
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
fi

# Verify Docker installation
if rpm -q docker-ce &> /dev/null; then
    sudo systemctl enable --now docker
else
    echo "Docker installation failed."
fi

echo "Installation completed successfully."
