#!/bin/sh
set -eu

# Exporta la base local a un SQL semilla compatible con PostgreSQL 16 (contenedor).
# Uso:
#   LOCAL_DB=optiplant LOCAL_USER=postgres LOCAL_PASSWORD=postgres ./scripts/generate-seed-from-local.sh

LOCAL_HOST="${LOCAL_HOST:-localhost}"
LOCAL_DB="${LOCAL_DB:-optiplant}"
LOCAL_USER="${LOCAL_USER:-postgres}"
LOCAL_PASSWORD="${LOCAL_PASSWORD:-postgres}"
OUT_FILE="${OUT_FILE:-db/seed/optiplant_seed.sql}"

mkdir -p "$(dirname "$OUT_FILE")"

echo "[seed] Exportando $LOCAL_DB desde $LOCAL_HOST con usuario $LOCAL_USER..."
PGPASSWORD="$LOCAL_PASSWORD" pg_dump \
  -h "$LOCAL_HOST" \
  -U "$LOCAL_USER" \
  -d "$LOCAL_DB" \
  --no-owner \
  --no-privileges > "$OUT_FILE"

# Compatibilidad: dumps de PG18 incluyen transaction_timeout, no soportado por PG16.
TMP_FILE="${OUT_FILE}.tmp"
sed '/^SET transaction_timeout = /d' "$OUT_FILE" > "$TMP_FILE"
mv "$TMP_FILE" "$OUT_FILE"

echo "[seed] Seed generado en: $OUT_FILE"

