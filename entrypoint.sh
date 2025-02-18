#!/bin/bash
# This script is used to start the FreeRADIUS service with environment variable substitution.
#
# Steps:
# 1. Substitute environment variables in the LDAP configuration file located in /etc/freeradius/3.0/mods-available/ldap.
# 2. Move the substituted configuration file to the enabled modules directory at /etc/freeradius/3.0/mods-enabled/ldap.
# 3. Start the FreeRADIUS service using the exec command to replace the current shell with the FreeRADIUS process.


# Substitui as variáveis e move para a pasta de módulos habilitados
envsubst < /etc/freeradius/3.0/mods-available/ldap > /etc/freeradius/3.0/mods-enabled/ldap

# Inicia o FreeRADIUS com debug, facilitando a visualização de logs
# Dangerous: expoe informações sensíveis
#exec freeradius -X

# Inicia o FreeRADIUS em primeiro plano, sem o modo debug
exec freeradius -f -xxx  # Mais detalhes, mas sem nível 'X' completo
