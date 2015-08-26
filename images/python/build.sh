#!/bin/bash
source /etc/profile.d/enable-python27.sh

function is_django_installed() {
  python -c "import django" &>/dev/null
}

function should_collectstatic() {
  is_django_installed && [[ -z "$DISABLE_COLLECTSTATIC" ]]
}

set -e

if [[ -f requirements.txt ]]; then
  echo "---> Installing dependencies ..."
  pip install --user -r requirements.txt
fi

if [[ -f setup.py ]]; then
  echo "---> Installing application ..."
  python setup.py develop --user
fi

# set permissions for any installed artifacts
chmod -R og+rwx /opt/app-root

if should_collectstatic; then
  (
    echo "---> Collecting Django static files ..."

    # Find shallowest manage.py script, either ./manage.py or <project>/manage.py
    manage_file=$(find . -maxdepth 2 -type f -name 'manage.py' -printf '%d\t%P\n' | sort -nk1 | cut -f2 | head -1)

    if [[ ! -f "$manage_file" ]]; then
      echo "WARNING: seems that you're using Django, but we could not find a 'manage.py' file."
      echo "'manage.py collectstatic' ignored."
      exit
    fi

    if ! python $manage_file collectstatic --dry-run --noinput &> /dev/null; then
      echo "WARNING: could not run 'manage.py collectstatic'. To debug, run:"
      echo "    $ python $manage_file collectstatic --noinput"
      echo "Ignore this warning if you're not serving static files with Django."
      exit
    fi

    python $manage_file collectstatic --noinput
  )
fi

# remove pip temporary directory
rm -rf /tmp/pip_build_default
