#!/bin/sh
rm -fr todo
mkdir -p todo
sudo rm -fr linked/work
cp -a ../../apps/php/todo/* todo
docker build -t do276/todophp .
