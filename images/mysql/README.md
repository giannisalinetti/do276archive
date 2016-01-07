# DO276 MySQL 5.5 Docker Image

This image customizes the supported Red Hat SCL MySQL image. Check its Dockerfile (Dockerfile.rhel7) and docs at:
* `https://github.com/openshift/mysql/tree/master/5.5`

The customization is mechanism that load every script file that is on the /var/lib/mysql/init folder to the database. 

To build this image, use the following command:

docker build -t do276/mysql-55-rhel7 .

