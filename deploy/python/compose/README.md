# Running Java EE To Do App with Docker Compose
Install Red Hat Software Collections pip
sudo yum -y install python27 python27-python-pip

Install docker compose:
sudo scl enable python27 "pip install docker-compose"

scl enable python27 "docker-compose up"

