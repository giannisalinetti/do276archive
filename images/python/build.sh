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
