#!/bin/bash

docker build -t notejam-flask .

docker run \
    -p 5007:5000 \
    --name notejam-app \
    notejam-flask \
    gunicorn notejam.wsgi:application --bind 0.0.0.0:5000