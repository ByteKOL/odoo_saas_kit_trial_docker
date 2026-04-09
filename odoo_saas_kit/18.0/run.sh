#!/bin/bash
set -e

export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

ensure_docker_installed() {
    if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        return
    fi

    echo "Docker is not installed (or docker compose plugin is missing). Installing Docker..."

    if ! command -v apt-get >/dev/null 2>&1; then
        echo "Unsupported OS/package manager for automatic Docker installation."
        echo "Please follow the official Docker docs: https://docs.docker.com/engine/install/"
        exit 1
    fi

    SUDO_CMD=""
    if [ "$(id -u)" -ne 0 ]; then
        if ! command -v sudo >/dev/null 2>&1; then
            echo "sudo is required to install Docker automatically."
            exit 1
        fi
        SUDO_CMD="sudo"
    fi

    # Official Docker installation steps for Ubuntu/Debian.
    $SUDO_CMD apt-get update
    $SUDO_CMD apt-get install -y ca-certificates curl
    $SUDO_CMD install -m 0755 -d /etc/apt/keyrings
    $SUDO_CMD curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    $SUDO_CMD chmod a+r /etc/apt/keyrings/docker.asc
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${VERSION_CODENAME}") stable" | \
        $SUDO_CMD tee /etc/apt/sources.list.d/docker.list >/dev/null
    $SUDO_CMD apt-get update
    $SUDO_CMD apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    if ! command -v docker >/dev/null 2>&1 || ! docker compose version >/dev/null 2>&1; then
        echo "Docker installation failed. Please verify manually with official docs:"
        echo "https://docs.docker.com/engine/install/ubuntu/"
        exit 1
    fi
}

ensure_docker_installed

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
