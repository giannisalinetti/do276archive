#!/bin/bash

ip=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
echo "Using IP: ${ip}"

yum -y update
yum -y install vim-enhanced net-tools iproute git docker kubernetes etcd wget httpd iptables-services iptables-utils 

# XXX need to find correct config to run with iptables service on
systemctl disable firewalld
systemctl stop firewalld
#cp /vagrant/iptables /etc/sysconfig/iptables
#systemctl start iptables
#systemctl enable iptables
systemctl stop iptables
systemctl disable iptables

# Tools to do JEE builds from source code
yum -y install maven java-1.8.0-openjdk-devel mysql-connector-java
# XXX Ugly hack, does anyone knows a better way?
echo 2 | alternatives --config java
echo 2 | alternatives --config javac

# Have Wildfly 9 ready for development and deployment and listening in 30080
cd /home/student
export WILDFLY_VERSION="9.0.1.Final"
echo "Downloading Wildfly $WILDFLY_VERSION"
wget -q https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz
tar xzf wildfly-$WILDFLY_VERSION.tar.gz  
sed -i 's/port-offset:0/port-offset:22000/' ./wildfly-$WILDFLY_VERSION/standalone/configuration/standalone.xml
sed -i 's/jboss.bind.address:127.0.0.1/jboss.bind.address:0.0.0.0/' ./wildfly-$WILDFLY_VERSION/standalone/configuration/standalone.xml
./wildfly-$WILDFLY_VERSION/bin/add-user.sh admin jboss#1! --silent
chown -R student:student ./wildfly-$WILDFLY_VERSION

# SCL packages for database and other runtimes
# MySQL 5.5 from SCL does not includes mysqlclient lib
yum -y install httpd24 mysql55 mysql55-scldevel mysql55-devel mariadb-libs mariadb-devel

sed -i 's/Listen 80/Listen 30000/' /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf
semanage port -a -t http_port_t -p tcp 30000

yum -y install rh-ruby22 rh-ruby22-rubygem-json rh-ruby22-ruby-devel rh-ruby22-rubygem-bundler

yum -y install nodejs010-nodejs nodejs010-npm 

yum -y install rh-python34 rh-python34-python-devel rh-python34-python-setuptools rh-python34-python-pip 

yum -y install rh-php56 rh-php56-php-pear rh-php56-php-pecl-jsonc rh-php56-php-mysqlnd rh-php56-php rh-php56-php-pdo
setsebool httpd_can_network_connect_db on
sed -i 's/AllowOverride None/AllowOverride All/' /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf 
sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/' /etc/opt/rh/rh-php56/php.ini
echo 'HTTPD24_HTTPD_SCLS_ENABLED="httpd24 rh-php56"' > /opt/rh/httpd24/service-environment
semanage port -a -t http_port_t -p tcp 30080

# Shouldn't Vagrant do this by itself?
echo "${ip} `hostname`" >> /etc/hosts
ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys 
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H `hostname` >> ~/.ssh/known_hosts
chmod 0600 ~/.ssh/known_hosts

# students need sudo for grading scripts infrastructure
useradd -G docker,wheel student
echo 'student' | passwd student --stdin

echo 'redhat' | passwd root --stdin

# Setup Docker image storage (re-do)
rm -f /etc/sysconfig/docker-storage-setup
echo "DOCKER_STORAGE_OPTIONS=" > /etc/sysconfig/docker-storage
lvremove -f VolGroup00/docker-pool
fdisk /dev/sdb <<EOF  || true
n
p



t
8e
w
EOF
partprobe
pvcreate /dev/sdb1
vgcreate docker-vg /dev/sdb1
cat <<'EOF' > /etc/sysconfig/docker-storage-setup
VG=docker-vg
SETUP_LVM_THIN_POOL=yes
EOF
docker-storage-setup
lvextend docker-vg/docker-pool /dev/sdb1
systemctl stop docker
rm -fr /var/lib/docker/*
systemctl start docker
systemctl enable docker

# Setup Kubernetes for anonymous access
sed -i 's/,SecurityContextDeny,ServiceAccount,ResourceQuota"/,SecurityContextDeny,ResourceQuota"/' /etc/kubernetes/apiserver
SERVICES="etcd kube-apiserver kube-controller-manager kube-scheduler"
# Start Kubernetes master
systemctl restart $SERVICES
systemctl enable $SERVICES
# Start Kubernetes minion
SERVICES="kube-proxy kubelet"
systemctl restart $SERVICES
systemctl enable $SERVICES
# No need for flannel because we are using a single host

# Well-known FQDN for the To Do List application back end
echo '127.0.0.1 api.lab.example.com' >> /etc/hosts

# Setup grading script infrastructure
bash /vagrant/grading.sh

# Setup private registry for custom images
bash /vagrant/privatereg.sh

