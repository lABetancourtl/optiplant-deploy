# Optiplant Deploy

Orquestacion de `frontend` + `backend` + PostgreSQL usando Docker Compose.

## Requisitos
- Docker
- Docker Compose (plugin `docker compose`)

## Estructura esperada
Los repos deben estar como carpetas hermanas:
- `../reto-optiplant-frontend`
- `../reto-optiplant-backend`
- `./optiplant-deploy`

## Ejecutar con Docker Compose

```bash
cp .env.example .env
docker compose up --build
```

## Persistencia de datos en cualquier PC

Esta configuracion usa dos mecanismos:

- Persistencia local por PC: volumen Docker `optiplant_pgdata`.
- Datos iniciales compartidos: archivo `db/seed/optiplant_seed.sql`.

Comportamiento:

- Si el volumen esta vacio (primera ejecucion), PostgreSQL corre `db/init/01-load-seed.sh` y carga `db/seed/optiplant_seed.sql`.
- Si el volumen ya existe, mantiene los datos previos y no reimporta seed.

Para preparar el seed desde tu PostgreSQL local:

```bash
cd /ruta/optiplant-deploy
LOCAL_DB=optiplant LOCAL_USER=postgres LOCAL_PASSWORD=postgres ./scripts/generate-seed-from-local.sh
```

Luego comparte ese archivo con el equipo (git o canal interno):

- `db/seed/optiplant_seed.sql`

En un PC nuevo:

```bash
cp .env.example .env
docker compose up -d --build
```

Si quieres reinicializar desde seed en un PC (borrar datos actuales del volumen):

```bash
docker compose down -v
docker compose up -d --build
```

Servicios expuestos por defecto:
- Frontend: `http://localhost:4200`
- Backend: `http://localhost:8080`
- Swagger: `http://localhost:8080/swagger-ui/index.html`

Nota: PostgreSQL se usa de forma interna dentro de Docker Compose (no publica puerto en host).

Si tienes puertos ocupados, puedes levantar con puertos alternativos:

```bash
BACKEND_PORT=8081 FRONTEND_PORT=4201 docker compose --env-file .env.example up -d --build
```

Para detener y eliminar contenedores:

```bash
docker compose down
```

Para eliminar tambien el volumen de base de datos:

```bash
docker compose down -v
```

## Ejecutar en local (sin Docker Compose)

1. Levantar PostgreSQL local en `localhost:5432` con una base `optiplant`.
2. En `reto-optiplant-backend`, ejecutar:

```bash
./gradlew bootRun
```

3. En `reto-optiplant-frontend`, ejecutar:

```bash
npm install
npm start
```

Con esto:
- Frontend en `http://localhost:4200`
- Backend en `http://localhost:8080`

