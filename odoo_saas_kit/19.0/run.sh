#!/bin/bash
set -e

export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

# Create directories explicitly matching docker-compose.yml
mkdir -p container_data/postgres
mkdir -p container_data/odoo
mkdir -p container_data/config

# Set ownership and permissions for postgres data
chown -R "$HOST_UID:$HOST_GID" container_data/postgres
chmod 700 container_data/postgres

# Bring up containers
docker compose down --remove-orphans
docker compose up --force-recreate
