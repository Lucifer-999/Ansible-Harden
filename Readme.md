# RedCarpet Task
This repo contains the task given by RedCarpet Team for the Internship Cyber Security position.
The task consisted of the following: https://pastebin.com/nve7g3ht

This ReadMe file will guide you to complete the said task

# Table of Contents
* [Create a AWS cloud Account](#create-a-aws-cloud-account)
* [Setup an EC2 Ubuntu Instance](#setup-an-ec2-ubuntu-instance)
* [Connect to the Instance](#connect-to-the-instance)
* [Installing ANSIBLE](#installing-ansible)
* [Setting Up ANSIBLE](#setting-up-ansible)
* [Installing ANSIBLE Collections Required](#installing-ansible-collections-required)
* [Running the Playbook](#running-the-playbook)
* [Notes](#notes)


## Create a AWS cloud Account

We will be using AWS as our cloud platform. The free tier is enough to complete the given job.
So first on all, head over to https://aws.amazon.com/ and sign up for your account. You need to enter your credit card information in order to use the services.


## Setup an EC2 Ubuntu Instance

In the AWS Console, head over to EC2 and Launch a new "Ubuntu Server" Instance.
Create your private key and download it to a safe location, this will be used to access your Ubuntu Instance.


## Connect to the Instance

On the EC2 Dashboard, right click on your newly created Ubuntu Instance and click on connect, you'll see an ssh command. Run this on your system in order to test and connect to the instance.

The command would be like the following: 
> $ ssh -i "private-key.pem" ubuntu@host-name


## Installing ANSIBLE

Next up, you need to install ANSIBLE on your system. 

For Debian, 
> $ sudo apt-get install ansible 

For Arch,
> $ sudo pacman -S ansible 

Others can check their package manager for help.


## Setting Up ANSIBLE

Default ANSIBLE installation directory is /etc/ansible

Create a new hosts file there and add the following:

```
ec2-instance ansible_host=aws-instance-ip ansible_user=ubuntu ansible_ssh_private_key_file=key-file.pem
```

Note that aws-instance-hostname is the hostname or ip address of your Ubuntu Instance and key-file.pem is your private key file.

To test if your ANSIBLE is running correctly and connected to your Server, run the following command
> $ ansible ec2-instance -m ping 

It's output should be something like
``` 
ec2-instance | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```


## Installing ANSIBLE Collections Required

There are 2 ANSIBLE collections required for the playbook, devsec.hardening and community.general. To install these, run the following command:
> $ ansible-galaxy install -r requirements.yml


## Running the Playbook

The last step is to running the playbook which installs docker and kubernetes to the Ubuntu Instance and make security changes to the instance.

To do so, run the following command and wait for a while for it to complete
> $ ansible-playbook setup_harden.yml




## Notes

* Since installing complete Kubernetes will slow down the instance, I used MicroK8s for lightweight Kubernetes Installation
* As an example, ```microbot``` is installed in MicroK8s
* The playbook has 2 main functions, the first one is to install and setup Docker and MicroK8s and the second one is to harden the system security.
* ```devsec.hardening``` is used for hadening the system. You can check it out at https://github.com/dev-sec/ansible-collection-hardening.


## To Implement
Handlers for following
* Restart SSHD
* restart-auditd
* Update-initramfs