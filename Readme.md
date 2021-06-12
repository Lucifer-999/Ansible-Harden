# Connecting to instance
ssh -i "lucifer-asia.pem" ubuntu@<ip-addr>


# Updating the system
sudo apt-get update
sudo apt-get upgrade -y


# Installing Docker
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker


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
sudo cp ~/go/bin/kind /usr/local/bin/

# Create a Single Node Cluster
sudo kind create cluster --name redcarpet


# Installing kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


# Info Cluster
sudo kubectl cluster-info --context kind-redcarpet


# Connecting ANSIBLE
ec2-instance ansible_host=<ip-addr> ansible_user=ubuntu ansible_ssh_private_key_file=<key-file>
ansible all -m ping
