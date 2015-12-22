#!/bin/sh
rm -fr build
mkdir -p build
cp -a ../../apps/php/* build
docker build -t do276/todophp .
