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

Servicios expuestos por defecto:
- Frontend: `http://localhost:4200`
- Backend: `http://localhost:8080`
- Swagger: `http://localhost:8080/swagger-ui/index.html`

Nota: PostgreSQL se usa de forma interna dentro de Docker Compose (no publica puerto en host).


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

