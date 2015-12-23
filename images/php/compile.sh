#!/bin/bash

set -e
echo "Attempting to run compose in the following directory..."
cd todo/api
echo $PWD
if [ -f composer.json ]; then
  echo "Found 'composer.json', installing dependencies using composer.phar... "
  if [ -f composer.phar ]; then
    php composer.phar install
  fi
fi
