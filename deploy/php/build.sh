#!/bin/sh
rm -fr todo
mkdir -p todo
cp -a ../../apps/php/todo/* todo
docker build -t do276/todophp .
