#!/bin/bash

yum -y install httpd
systemctl start httpd
systemctl enable httpd

unzip -o /vagrant/grading.zip -d /
rm -rf /usr/local/bin/demo
ln -s /usr/local/bin/lab /usr/local/bin/demo
chcon -R --reference=/var/www /content

systemctl restart httpd
echo "127.0.0.1 content.example.com" >> /etc/hosts
