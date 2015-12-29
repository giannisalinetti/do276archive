#!/bin/bash

rm -fr build
mkdir -p build
cp -ap ../../apps/ruby/* build
rm build/*.sh
cp run.sh build
cp -p ../../apps/ruby_api/models/init.rb build/models

# XXX base image ONBUILD does bundle install

#source /opt/rh/mysql55/enable
#source /opt/rh/rh-ruby22/enable

#cd build
#gem install bundler
#bundle install

#cd ..
sudo rm -rf {linked,kubernetes}/work
docker build -t do276/todoruby .
