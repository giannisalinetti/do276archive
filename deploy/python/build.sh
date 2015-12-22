#!/bin/sh
rm -fr build
mkdir -p build
cp -a ../../apps/python/* build
docker build -t do276/todopython .
