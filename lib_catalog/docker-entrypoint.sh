#!/bin/sh

sleep 60
python manage.py migrate
python manage.py runserver 0.0.0.0:8000