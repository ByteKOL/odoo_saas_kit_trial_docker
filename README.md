# Odoo SaaS Trial Docker

## Note

This setup supports only `amd64` / `x86_64` architecture.

## Run

- On Linux, run:
  - `./run.sh`
- On Windows, run:
  - `run_windows.bat`

## Access Odoo

After containers are up, open:

- `http://<your_server_ip>:8169`
- `http://127.0.0.1:8169` (if running on your local machine)

## Customization

- You can edit Odoo config at:
  - `container_data/config/odoo.conf`
- You can add custom modules at:
  - `container_data/odoo/addons/<odoo_version>`
