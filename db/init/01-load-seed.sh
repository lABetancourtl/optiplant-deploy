#!/bin/sh
set -eu

SEED_FILE="/seed/optiplant_seed.sql"

if [ -f "$SEED_FILE" ]; then
  echo "[db-init] Seed encontrado en $SEED_FILE. Importando datos iniciales..."
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f "$SEED_FILE"
  echo "[db-init] Importacion finalizada."
else
  echo "[db-init] No se encontro $SEED_FILE. Se crea una base vacia."
fi

