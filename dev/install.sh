#!/bin/bash

ip=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
echo "Using IP: ${ip}"

yum -y update
yum -y install vim-enhanced net-tools iproute git docker kubernetes etcd wget yum-plugin-remove-with-leaves yum-utils httpd
# Tools to do builds from source code
yum -y install maven java-1.8.0-openjdk-devel
# XXX Ugly hack, does anyone knows a better way?
echo 2 | alternatives --config java
echo 2 | alternatives --config javac

### Dev box changes start here

# XXX Not working on my RH CSB laptop :-(
#yum -y groupinstall "Server with GUI"

# Bare enough for ssh -X
yum -y install PackageKit-gtk3-module dbus-x11 xorg-x11-xauth gedit gnome-terminal elinks xorg-x11-font-utilsopen-sans-fonts gnu-free-* dejavu-* xorg-x11-fonts-Type1 xorg-x11-fonts-misc xorg-x11-fonts-75dpi xorg-x11-fonts-ISO8859-1-75dpi urw-fonts liberation-* bitmap-lucida-typewriter-fonts gnome-icon-theme-symbolic libcanberra-gtk3

# Minimal GUI desktop
yum -y install gedit eof gnome-calculator nautilus yelp searhorse florence evince firefox NetworkManager gnome-classic-session gnome-session gnome-settings-daemon gnome-shell gnome-shell-extension-apps-menu gnome-shell-extension-window-list gnome-themes-standard gnome-system-log gnome-screenshot gnome-tweak-tool gconf-editor control-center gdm gnome-abrt gnome-system-monitor gnome-packagekit libgnomekbd NetworkManager-glib xorg-x11-server-Xorg xorg-x11-xinit-session xorg-x11-utils xorg-x11-server-utils xorg-x11-xkb-utils xorg-x11-font-utils xorg-x11-drv-vesa xorg-x11-drv-evdev xorg-x11-drv-mouse xorg-x11-drv-modesetting xorg-x11-drv-keyboard

# No ibus packate? No immodule package?

# Because RHEL7.1 Gtk3 apps do not work over ssh -X add a Gtk2 programmer's editor (geany)
# plus a lint for JSON files
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y localinstall epel-release-latest-7.noarch.rpm
yum -y install python-demjson geany geany-themes # anjuta bluefish
# add SCL packages for runtimes
yum -y install httpd24 scl-utils mariadb55 mysql-connector-java
#yum -y install python27 python27-python-pip # move to "tools to do builds ?" replace by SCL packages?
yum -y install rh-php56 rh-php56-php rh-php56-php-mysqlnd rh-php56-php-bcmath rh-php56-php-gd rh-php56-php-intl rh-php56-php-mbstring rh-php56-php-pdo rh-php56-php-pecl-memcache rh-php56-php-process rh-php56-php-soap rh-php56-php-opcache rh-php56-php-xml rh-php56-php-pecl-xdebug 
# node.js
# ruby

systemctl set-default graphical.target
init 5

### Dev box changes end here

echo "${ip} `hostname`" >> /etc/hosts
ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys 
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H `hostname` >> ~/.ssh/known_hosts
chmod 0600 ~/.ssh/known_hosts

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
systemctl start docker
systemctl enable docker

# Setup Kubernetes for anonymous access
systemctl disable firewalld
systemctl stop firewalld
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

# Have Wildfly 9 ready for development and deployment
cd /home/vagrant
export WILDFLY_VERSION="9.0.1.Final"
export WILDFLY_SHA1=abe037d5d1cb97b4d07fbfe59b6a1345a39a9ae5
curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz
tar xzf wildfly-$WILDFLY_VERSION.tar.gz
chown -R vagrant:vagrant .

