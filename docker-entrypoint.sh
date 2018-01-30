#!/usr/bin/env sh

nginx 
/usr/bin/gunicorn --pythonpath=/app mambu.wsgi -b unix:///tmp/django.sock -k gevent