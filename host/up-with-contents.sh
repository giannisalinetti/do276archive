#!/bin/bash -x

#
# script to copy updated /content folder from course SVN and start the vagrant box
# logged in as the student user
# also loads images into the private registry from a local cache having saved tar.gz images
#

SVN_ARTIFACTS=/svn/training/DO276_Container_Apps/artifacts
IMAGESDIR=$HOME
# mysql and httpd are from docker.io
IMAGES="mysql httpd rhel7 openshift.mysql-55-rhel7 do276.mysql-55-rhel7"
HOSTDIR=$(pwd)

$POWEROFF=$(vagrant status | grep workstation | grep poweroff)
if [ "$POWEROFF" != "" ]; then
  echo "Needs to be run with the workstaton box off." 1>&2
  exit 1
fi

#svn update
pushd $SVN_ARTIFACTS
tar czf $HOSTDIR/contents.tar.gz content
popd

for image in $IMAGES ; do
  cp -p $IMAGESDIR/$image.tar.gz .
done

vagrant up --provider=virtualbox

vagrant ssh -- sudo tar xzf /vagrant/contents.tar.gz -C /

# Erros during those rm/rmi are expected if the box is brand new or was properly cleaned up
vagrant ssh -- "docker rm -f \$(docker ps -qa)"
vagrant ssh -- "docker rmi -f \$(docker images -q)"
vagrant ssh -- "cd /vagrant ; for i in $IMAGES ; do docker load -i \$i.tar.gz ; done"
vagrant ssh -- "for i in \$(docker images | awk '{print \$1}' | grep -v REPOSITORY | sed 's/registry.access.redhat.com\///' | sed 's/docker.io\///'); do docker push \$i; done"
vagrant ssh -- "docker rmi -f \$(docker images -q)"

vagrant ssh -- -l student

