#!/bin/sh
rm -fr todo
mkdir -p todo
sudo rm -fr linked/work
cp -a ../../apps/php_api/todo/* todo
docker build -t do276/todoapi_php .
