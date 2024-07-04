#!/bin/bash

# Define the content to replace in /etc/ldap/ldap.conf
LDAP_CONF_CONTENT="URI ldap://auth01-dev.gupshup.me ldap://auth02-dev.gupshup.me
BASE dc=gupshup,dc=me
TLS_REQCERT demand
TLS_CACERT /etc/ssl/rooca.crt"

# Backup existing /etc/ldap/ldap.conf if it exists
if [ -f /etc/ldap/ldap.conf ]; then
    sudo cp /etc/ldap/ldap.conf /etc/ldap/ldap.conf.bak
    echo "Backup of /etc/ldap/ldap.conf created: /etc/ldap/ldap.conf.bak"
fi

# Write the new content to /etc/ldap/ldap.conf
echo "$LDAP_CONF_CONTENT" | sudo tee /etc/ldap/ldap.conf > /dev/null

echo "Updated /etc/ldap/ldap.conf successfully."
