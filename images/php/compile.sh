#!/bin/bash

set -e
echo "Attempting to run compose in the following directory..."
if [ -f composer.json ]; then
  echo "Found 'composer.json', installing dependencies using composer.phar... "

  # Install Composer
  php -r "readfile('https://getcomposer.org/installer');" | php

  # Install App dependencies using Composer
  ./composer.phar install --no-interaction --no-ansi --no-scripts --optimize-autoloader

  if [ -f composer.phar ]; then
    echo -e "\nConsider adding a 'composer.lock' file into your source repository.\n"
  fi
fi
