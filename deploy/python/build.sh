#!/bin/sh
rm -fr build
mkdir -p build
cp -a ../../apps/python_api/* build
docker build -t do276/todopython .
