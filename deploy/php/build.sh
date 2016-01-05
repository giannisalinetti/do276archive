#!/bin/sh
rm -fr build
mkdir -p build
sudo rm -fr linked/work
cp -a ../../apps/php/todo build
mv build/todo/api/* build
rm build/todo/api

docker build -t do276/todophp .
