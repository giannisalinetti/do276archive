#!/bin/bash
source /etc/profile.d/enable-python34.sh

set -e

if [[ -f requirements.txt ]]; then
  echo "---> Installing dependencies ..."
  pip install --user -r requirements.txt
fi

pip install mysql-connector-python --allow-external mysql-connector-python

# set permissions for any installed artifacts
chmod -R og+rwx /opt/app-root



# remove pip temporary directory
rm -rf /tmp/pip_build_default

APP_FILE="${APP_FILE:-app.py}"
if [[ "$APP_FILE" ]]; then
  if [[ -f "$APP_FILE" ]]; then
    echo "---> Running application from Python script ($APP_FILE) ..."
    exec python "$APP_FILE"
  fi
  echo "WARNING: file '$APP_FILE' not found."
fi

>&2 echo "ERROR: don't know how to run your application."
>&2 echo "Please set APP_FILE environment variables, or create a file 'app.py' to launch your application."
exit 1
