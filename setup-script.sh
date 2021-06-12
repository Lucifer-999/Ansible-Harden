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

#sudo groupadd docker
#sudo usermod -aG docker $USER
#newgrp docker


# Installing GoLang
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt-get update
sudo apt-get install golang -y

# Set GoPath
mkdir -p ~/go/{bin,pkg,src}
echo 'export GOPATH="$HOME/go"' >> ~/.bashrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.bashrc
export GOPATH="$HOME/go"
export PATH="$PATH:${GOPATH//://bin:}/bin"


# Install KIND
GO111MODULE="on" go get sigs.k8s.io/kind
cp ~/go/bin/kind /usr/local/bin/

# Create a Single Node Cluster
kind create cluster --name redcarpet


# Installing kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# Info Cluster
kubectl cluster-info --context kind-redcarpet

