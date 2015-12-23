#!/bin/sh
rm -fr build
mkdir -p build
cp -a ../../apps/php/todo/* todo
docker build -t do276/todophp .
