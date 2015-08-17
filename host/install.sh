#!/bin/bash

ip=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
echo "Using IP: ${ip}"

yum -y update
yum -y install vim-enhanced net-tools bind-utils git docker
yum -y groupinstall "Server with GUI"
hostnamectl set-hostname atomic.example.com
echo "${ip} atomic.example.com" >> /etc/hosts
ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys 
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H atomic.example.com >> ~/.ssh/known_hosts
chmod 0600 ~/.ssh/known_hosts
systemctl set-default graphical.target
init 5
