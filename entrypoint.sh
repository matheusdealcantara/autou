#!/usr/bin/env bash
set -e

# roda migrações e coleta static antes de iniciar
python manage.py migrate --noinput
python manage.py collectstatic --noinput

# executa o comando passado (ex.: gunicorn)
exec "$@"