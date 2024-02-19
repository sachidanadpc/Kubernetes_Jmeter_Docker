#!/bin/bash

# Check if Kubernetes packages are already installed
if rpm -q kubelet kubeadm kubectl &> /dev/null; then
    echo "Kubernetes is already installed."
    exit 0
fi

# Set up Kubernetes repository
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Install Kubernetes packages
echo "Installing Kubernetes..."
sudo yum install -y kubelet kubeadm kubectl

# Start kubelet service
sudo systemctl enable --now kubelet

echo "Kubernetes installed successfully."
