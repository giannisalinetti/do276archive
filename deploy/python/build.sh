#!/bin/sh

pip install -r requirements.txt
pip install mysql-connector-python --allow-external mysql-connector-python
python ../../python/app.py

