#!/bin/sh

HOSTNAME=`hostname`

yum install -y docker-registry

#openssl genrsa -out /etc/pki/tls/private/self.key 1024

#openssl req -new -key /etc/pki/tls/private/self.key -x509 -days 30828 -out /etc/pki/tls/certs/self.crt -subj "/C=US/ST=NC/L=Training/O=example.com/CN=$HOSTNAME/emailAddress=root@example.com"


#cp /usr/lib/systemd/system/docker-registry.service /etc/systemd/system/
#find /etc/systemd/system/docker-registry.service -type f -exec sed -i "s/ExecStart=\/usr\/bin\/gunicorn/ExecStart=\/usr\/bin\/gunicorn --certfile \/etc\/pki\/tls\/certs\/self.crt --keyfile \/etc\/pki\/tls\/private\/self.key/g" {} +


find /etc/docker-registry.yml -type f -exec sed -i "0,/_env:SEARCH_BACKEND/ s/_env:SEARCH_BACKEND/_env:SEARCH_BACKEND:sqlalchemy/" {} +
 
systemctl enable docker-registry
systemctl start docker-registry
#systemctl daemon-reload
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-port=5000/tcp --permanent
firewall-cmd --reload

#Trusting the certificate file

#yum -y install ca-certificates
#update-ca-trust enable
#cp /etc/pki/tls/certs/self.crt /etc/pki/ca-trust/source/anchors/
#update-ca-trust extract


#To rebuild the internal registry DB

systemctl stop docker
systemctl stop docker-registry
mkdir -p /var/lib/docker-registry
rm -rf /tmp/docker-registry.db

#Configure the docker daemon to use the internal registry

echo "127.0.0.1 servera.example.com" >> /etc/hosts
sed -i "s/ADD_REGISTRY='/ADD_REGISTRY='--add-registry servera.example.com:5000 /" /etc/sysconfig/docker
sed -i "s/# INSECURE_REGISTRY='--insecure-registry/INSECURE_REGISTRY='--insecure-registry servera.example.com:5000/" /etc/sysconfig/docker

# Add steps to preload images?

systemctl start docker
systemctl start docker-registry


