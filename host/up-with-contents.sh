#!/bin/bash -x

#
# script to copy updated /content folder from course SVN and start the vagrant box
# logged in as the student user
#

SVN_ARTIFACTS=/svn/training/DO276_Container_Apps/artifacts

pushd $SVN_ARTIFACTS
#svn update
tar czf /tmp/contents.tar.gz content
popd
cp /tmp/contents.tar.gz .
vagrant up --provider=virtualbox
vagrant ssh -- sudo tar xzf /vagrant/contents.tar.gz -C /

vagrant ssh -- -l student

