#!/bin/bash
set -e

DEFAULT_CONFIG_TEMPLATE="/opt/odoo/defaults/odoo.conf"
DEFAULT_CONFIG_PATH="/opt/odoo/config/odoo.conf"

if [ ! -f "$DEFAULT_CONFIG_PATH" ]; then
    cp "$DEFAULT_CONFIG_TEMPLATE" "$DEFAULT_CONFIG_PATH"
fi

echo "Exec: $@"
exec "$@"