#!/bin/bash

rm -fr build
mkdir -p build
cp -ap ../../apps/ruby/* build
rm build/*.sh
cp -p ../../apps/ruby_api/models/init.rb build/models
rm build/Gemfile.lock

# base image ONBUILD does bundle install

# docker build complains if he cannot read the database folder even if not needed for building the image
sudo rm -rf {linked,kubernetes}/work

docker build -t do276/todoruby .
