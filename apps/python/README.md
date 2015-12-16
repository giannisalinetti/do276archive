# DO276 Python/Angular JS To Do List App
Using Python 3.4, Flask, python mysql connector, pip3

In order to run the build script, run the following commands to install python

sudo yum install rh-python34
sudo scl enable rh-python34 ./build.sh


In addition, a MySQL server with correct todo app tables must be running. Environment variables passed in for database:
MYSQL_DB_USERNAME
MYSQL_DB_PASSWORD
MYSQL_DB_HOST
MYSQL_DB_PORT
MYSQL_DB_NAME

An example run script:
MYSQL_DB_USERNAME=root MYSQL_DB_PASSWORD=test MYSQL_DB_HOST=127.0.0.1 MYSQL_DB_PORT=30080 MYSQL_DB_NAME=todo python app.py