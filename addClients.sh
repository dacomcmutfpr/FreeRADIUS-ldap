#!/bin/bash

CONFIG_FILE="freeradius-config/clients.conf"

# Solicita os valores ao usuário
read -p "Digite o IP do cliente: " ipaddr
read -p "Digite o segredo compartilhado: " secret
read -p "Digite o nome curto do cliente: " name

# Verifica se o arquivo existe
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Erro: O arquivo $CONFIG_FILE não existe!" >&2
    exit 1
fi

# Adiciona a configuração ao arquivo
echo "" >> "$CONFIG_FILE"
echo "client $name {" >> "$CONFIG_FILE"
echo "    ipaddr = $ipaddr" >> "$CONFIG_FILE"
echo "    secret = $secret" >> "$CONFIG_FILE"
echo "    require_message_authenticator = true" >> "$CONFIG_FILE"
echo "    shortname = \"$name\"" >> "$CONFIG_FILE"
echo "}" >> "$CONFIG_FILE"

echo "Cliente adicionado com sucesso ao $CONFIG_FILE"

# Reinicia o container do FreeRADIUS
docker restart freeradius-ldap

echo "FreeRADIUS reiniciado."