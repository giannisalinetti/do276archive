#!/bin/bash

rm -fr build
mkdir -p build
cp -ap ../../apps/ruby_api/* build
rm build/*.sh
rm build/Gemfile.lock

# base image ONBUILD does bundle install

# docker build complains if he cannot read the database folder even if not needed for building the image
sudo rm -rf {linked,kubernetes}/work

docker build -t do276/todoapi_ruby .
