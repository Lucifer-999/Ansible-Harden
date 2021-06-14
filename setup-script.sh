#!/bin/bash

# Connecting to instance
#ssh -i "lucifer-asia.pem" ubuntu@ec2-52-66-202-231.ap-south-1.compute.amazonaws.com

# Updating the system
apt-get update
apt-get upgrade -y

# Installing Docker
apt install docker.io -y
systemctl start docker
systemctl enable docker

# Install MicroK8s
sudo snap install microk8s --classic --channel=1.18/stable

# Enable MicroK8s Services
microk8s enable dns dashboard storage

# Add MicroK8s Group
sudo usermod -a -G microk8s ubuntu

# Setup MicroK8s
microk8s kubectl get all --all-namespaces

# Deploy MicroBot
microk8s kubectl create deployment microbot --image=dontrebootme/microbot:v1
microk8s kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service

