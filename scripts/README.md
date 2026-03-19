# Scripts de datos

## `generate-seed-from-local.sh`
Exporta tu PostgreSQL local a `db/seed/optiplant_seed.sql` para que Docker Compose lo cargue automaticamente en una instalacion nueva (volumen vacio).

Uso:

```bash
cd /ruta/optiplant-deploy
LOCAL_DB=optiplant LOCAL_USER=postgres LOCAL_PASSWORD=postgres ./scripts/generate-seed-from-local.sh
```

Despues de generar el seed, comparte/commitea `db/seed/optiplant_seed.sql` (si tu politica lo permite).

