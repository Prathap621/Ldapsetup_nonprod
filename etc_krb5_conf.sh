#!/bin/bash

# Define the content to replace in /etc/krb5.conf
KRB5_CONF_CONTENT="[libdefaults]
    default_realm = DEV.GUPSHUP.ME

    # The following krb5.conf variables are only for MIT Kerberos.
    krb4_config = /etc/krb.conf
    krb4_realms = /etc/krb.realms
    kdc_timesync = 1
    ccache_type = 4
    forwardable = true
    proxiable = true

    # The following encryption type specification will be used by MIT Kerberos
    # if uncommented.  In general, the defaults in the MIT Kerberos code are
    # correct and overriding these specifications only serves to disable new
    # encryption types as they are added, creating interoperability problems.
    #
    # Thie only time when you might need to uncomment these lines and change
    # the enctypes is if you have local software that will break on ticket
    # caches containing ticket encryption types it doesn't know about (such as
    # old versions of Sun Java).
    #
    # default_tgs_enctypes = des3-hmac-sha1
    # default_tkt_enctypes = des3-hmac-sha1
    # permitted_enctypes = des3-hmac-sha1

    # The following libdefaults parameters are only for Heimdal Kerberos.
    v4_instance_resolve = false
    v4_name_convert = {
            host = {
                    rcmd = host
                    ftp = ftp
            }
            plain = {
                    something = something-else
            }
    }
    fcc-mit-ticketflags = true

[realms]
    DEV.GUPSHUP.ME = {
            kdc = auth01-dev.gupshup.me
            admin_server = auth01-dev.gupshup.me
    }

[domain_realm]
    .dev.gupshup.me = DEV.GUPSHUP.ME
    dev.gupshup.me = DEV.GUPSHUP.ME

[logging]
    krb4_convert = true
    krb4_get_tickets = false
    kdc = FILE:/var/log/kerberos/kdc.log
    admin_server = FILE:/var/log/kerberos/adminsrvr.log
    default = FILE:/var/log/kerberos/default.log"

# Backup existing /etc/krb5.conf if it exists
if [ -f /etc/krb5.conf ]; then
    sudo cp /etc/krb5.conf /etc/krb5.conf.bak
    echo "Backup of /etc/krb5.conf created: /etc/krb5.conf.bak"
fi

# Write the new content to /etc/krb5.conf
echo "$KRB5_CONF_CONTENT" | sudo tee /etc/krb5.conf > /dev/null

echo "Updated /etc/krb5.conf successfully."
