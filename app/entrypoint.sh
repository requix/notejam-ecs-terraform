#!/bin/sh

if [ "$DATABASE" = "rds" ]
then
    echo "Waiting for RDS instance..."

    while ! nc -z $RDS_HOST $RDS_PORT; do
      sleep 0.1
    done

    echo "RDS is ready"
fi

exec "$@"
