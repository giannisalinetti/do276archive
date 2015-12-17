#!/bin/bash

# First download Wildfly from wildfly.org and untar/unzip on the home folder
# Automate this step on the Vagrantfile?

source ./env.sh

# Initialize the MySQL database

sudo systemctl start mariadb55-mariadb
sudo systemctl enable mariadb55-mariadb

sudo scl enable mariadb55 -- mysql <<EOF
    create database todo;
    grant all on todo.* to todo@"127.0.0.1" identified by 'redhat';
EOF

# Create the Datasource

ln -s /usr/share/java/mysql-connector-java.jar $WILDFLY_HOME/standalone/deployments/

cd $WILDFLY_HOME/bin
# using local auth
./jboss-cli.sh --connect --controller=localhost:19990 <<EOF2
    data-source add --driver-name=mysql-connector-java.jar --name=MySQLDS --jndi-name=java:jboss/datasources/MySQLDS --user-name=todo --password=redhat --connection-url=jdbc:mysql://127.0.0.1/todo
    ./subsystem=datasources/data-source=MySQLDS:test-connection-in-pool
EOF2

