#!/bin/sh
rm -fr build
mkdir -p build
cp -a ../../apps/python_api/* build
cd build
docker build -t do276/todoapi_python -f ../Dockerfile .