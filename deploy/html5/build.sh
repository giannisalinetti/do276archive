#!/bin/bash

rm -rf src
cp -rp ../../html5/src .

docker build -t do276/todo_frontend . 

# how to point Angular to the api container?
# - sed the js file on container start?
# - have a dymanic page to return the env var?

