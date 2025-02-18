# This Dockerfile sets up a FreeRADIUS server with LDAP support on Ubuntu 24.04.
#
# Base Image:
# - Uses the official Ubuntu 24.04 image.
#
# Environment Variables:
# - DEBIAN_FRONTEND=noninteractive: Prevents interactive prompts during package installation.
#
# Package Installation:
# - Updates the package list.
# - Installs FreeRADIUS, FreeRADIUS LDAP module, nano editor, and gettext-base.
# - Cleans up the package lists to reduce image size.
#
# Configuration Files:
# - Copies FreeRADIUS configuration files from the local directory `freeradius-config` to `/etc/freeradius/3.0/`.
#
# Entrypoint Script:
# - Copies `entrypoint.sh` to the container's root directory and makes it executable.
#
# Optional LDAP Module Activation:
# - Provides a commented-out command to create a symbolic link for the LDAP module in FreeRADIUS.
#
# Ports:
# - Exposes the default RADIUS ports (UDP 1812 and 1813).
#
# Entrypoint:
# - Sets the entrypoint to `/entrypoint.sh` to start the FreeRADIUS server.

FROM ubuntu:24.04

# Define que não haverá interação na instalação dos pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza a lista de pacotes e instala o FreeRADIUS e o módulo LDAP
RUN apt update && \
    apt install -y freeradius freeradius-ldap nano gettext-base && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY freeradius-config/ /etc/freeradius/3.0/

COPY freeradius-config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Caso não utilize o entrypoint.sh, ative o módulo LDAP criando o link simbólico
#RUN ln -s /etc/freeradius/3.0/mods-available/ldap /etc/freeradius/3.0/mods-enabled/ldap

# Expondo as portas padrão do RADIUS (UDP 1812 e 1813)
EXPOSE 1812/udp 1813/udp

# Inicia o FreeRADIUS em modo debug (para facilitar o monitoramento dos logs)
#CMD ["freeradius", "-X"]

ENTRYPOINT ["/entrypoint.sh"]
