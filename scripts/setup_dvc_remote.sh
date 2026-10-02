#!/usr/bin/env bash
set -e

## Carga las variables del .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "No se encontró el archivo .env."
  exit 1
fi

dvc remote add -d storage "$DVC_DAGSHUB_URL" -f
dvc remote modify storage auth basic
dvc remote modify storage user "$DVC_DAGSHUB_USER"
dvc remote modify --local storage password "$DVC_DAGSHUB_TOKEN"

echo "Remote de DVC configurado correctamente."