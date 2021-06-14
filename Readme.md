# Connecting to instance
ssh -i "lucifer-asia.pem" ubuntu@<ip-addr>


# Updating the system
sudo apt-get update
sudo apt-get upgrade -y


# Installing Docker
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Installing MicroK8s
sudo snap install microk8s --classic --channel=1.18/stable

# Connecting ANSIBLE
ec2-instance ansible_host=<ip-addr> ansible_user=ubuntu ansible_ssh_private_key_file=<key-file>
ansible all -m ping
