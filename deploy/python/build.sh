#!/bin/sh
rm -fr build
mkdir -p build
# docker needs to read all subdirs - get rid of SQL db
sudo rm -fr linked/work
cp -a ../../apps/python/* build
docker build -t do276/todopython .
