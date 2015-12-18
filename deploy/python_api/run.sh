#!/bin/bash
source /etc/profile.d/enable-python34.sh

chmod -R og+rwx /opt/rh/rh-python34
chown -R $USER:$USER /opt/rh/rh-python34

pip install mysql-connector-python --allow-external mysql-connector-python

set -e

rm -fr build
mkdir -p build
cp -a ../../python_api/* build
cd build

APP_FILE="${APP_FILE:-app.py}"
if [[ "$APP_FILE" ]]; then
  if [[ -f "$APP_FILE" ]]; then
    echo "---> Running application from Python script ($APP_FILE) ..."
    exec python "$APP_FILE"
  fi
  echo "WARNING: file '$APP_FILE' not found."
fi

>&2 echo "ERROR: don't know how to run your application."
>&2 echo "Please set either APP_MODULE or APP_FILE environment variables, or create a file 'app.py' to launch your application."
exit 1
