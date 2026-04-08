FROM bytekol/odoo-base:18.0

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

RUN id -u odoo >/dev/null 2>&1 || useradd -m odoo
RUN mkdir -p /opt/odoo/source_codes /opt/odoo/datadir && \
    chown -R odoo:odoo /opt/odoo
WORKDIR /opt/odoo

# build odoo source code and addons
# 2. oca web
RUN git clone https://github.com/OCA/web.git --depth 1 --branch 18.0 --single-branch /opt/odoo/source_codes/web

# 3. odoo source code
# no need to install requirement, because base image already done that.
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 18.0 --single-branch /opt/odoo/source_codes/odoo \
    && rm -rf /opt/odoo/source_codes/odoo/.git

# 1. copy saas kit binary from local
COPY --chown=odoo:odoo dkm_odoo_saas_binary /opt/odoo/source_codes/dkm_odoo_saas_binary
RUN /venv3.12/bin/python3.12 -m pip install -r /opt/odoo/source_codes/dkm_odoo_saas_binary/requirements.txt

COPY --chown=odoo:odoo odoo.conf /opt/odoo/defaults/odoo.conf
COPY --chown=odoo:odoo entrypoint.sh /opt/odoo/entrypoint.sh
RUN chmod +x /opt/odoo/entrypoint.sh

EXPOSE 8069 8072 7890
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["/venv3.12/bin/python3.12", "/opt/odoo/source_codes/odoo/odoo-bin", "-c", "/opt/odoo/config/odoo.conf"]
