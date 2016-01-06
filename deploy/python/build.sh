#!/bin/sh

# docker needs to read all subdirs - get rid of SQL db
sudo rm -fr linked/work

rm -fr build
mkdir -p build
cp -a ../../apps/python/* build
#chmod -R a+rwX build

docker build -t do276/todopython .
