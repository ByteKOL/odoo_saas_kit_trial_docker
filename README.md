# Odoo SaaS Kit Trial Docker

## Note

- This setup supports only `amd64` / `x86_64` architecture.
- The minimum server spec should be: 4 CPUs, 8GB RAM, 50GB SSD.

## How to install
- Clone: `git clone https://github.com/ByteKOL/odoo_saas_kit_trial_docker.git`
- Go to `odoo_saas_kit_trial_docker/odoo_saas_kit/<odoo-version>` folder

- On Linux, run:
  - `bash run.sh`
- On Windows, run:
  - `run_windows.bat`

## Access Odoo

After containers are up, open:

- `http://<your_server_ip>:8169` or `http://127.0.0.1:8169` (if running on your local machine)

## Customization

- You can edit Odoo config at:
  - `odoo_saas_kit/<odoo-version>/container_data/config/odoo.conf`
- You can add custom modules at:
  - `odoo_saas_kit/<odoo-version>/container_data/odoo/addons/<odoo_version>`


## Uninstall
- stop docker compose.
- all data is stored in `odoo_saas_kit_trial_docker` folder, just delete that folder.

## Need help?
- contactus: https://bytekol.com/contactus