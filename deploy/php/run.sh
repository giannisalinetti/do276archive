#!/bin/bash

# Default php.ini configuration values, all taken 
# from php defaults.
export ERROR_REPORTING=${ERROR_REPORTING:-E_ALL & ~E_NOTICE}
export DISPLAY_ERRORS=${DISPLAY_ERRORS:-ON}
export DISPLAY_STARTUP_ERRORS=${DISPLAY_STARTUP_ERRORS:-OFF}
export TRACK_ERRORS=${TRACK_ERRORS:-OFF}
export HTML_ERRORS=${HTML_ERRORS:-ON}
export INCLUDE_PATH=${INCLUDE_PATH:-.:/opt/app-root/src:/opt/rh/rh-php56/root/usr/share/pear}
export SESSION_PATH=${SESSION_PATH:-/tmp/sessions}
# TODO should be dynamically calculated based on container memory limit/16
export OPCACHE_MEMORY_CONSUMPTION=${OPCACHE_MEMORY_CONSUMPTION:-16M} 

export PHPRC=${PHPRC:-/etc/opt/rh/rh-php56/php.ini}
export PHP_INI_SCAN_DIR=${PHP_INI_SCAN_DIR:-/etc/opt/rh/rh-php56/php.d}

envsubst < /opt/app-root/etc/php.ini.template > $PHPRC
envsubst < /opt/app-root/etc/php.d/10-opcache.ini.template > $PHP_INI_SCAN_DIR/10-opcache.ini

echo "Current directory ${PWD}"
cd todo/api
echo "After ${PWD}"

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


exec httpd -D FOREGROUND
