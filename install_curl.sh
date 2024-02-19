#!/bin/bash

# Check if Curl is already installed
if ! command -v curl &> /dev/null; then
    # Install Curl
    echo "Installing Curl..."
    sudo yum install -y curl
    # Check if installation was successful
    if command -v curl &> /dev/null; then
        echo "Curl installed successfully."
    else
        echo "Failed to install Curl."
    fi
else
    echo "Curl is already installed."
fi
