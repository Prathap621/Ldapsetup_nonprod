#!/bin/bash

# Define the content to replace in /etc/ldap.conf
LDAP_CONTENT="base dc=gupshup,dc=me
uri ldap://auth01-dev.gupshup.me:389 ldap://auth02-dev.gupshup.me:389
ldap_version 3
pam_lookup_policy yes
pam_password md5
nss_initgroups_ignoreusers _apt,backup,bin,daemon,ec2-instance-connect,fwupd-refresh,games,ganglia,gnats,irc,landscape,libuuid,list,lp,lxd,mail,man,messagebus,news,openldap,pollinate,proxy,puppet,root,snmp,sshd,statd,sycoredump,sync,sys,syslog,systemd-coredump,systemd-journal-remote,systemd-network,systemd-resolve,systemd-timesync,tcpdump,tomcat,tss,usbmux,uucp,uuidd,whoopsie,www-data,zabbix"

# Backup existing /etc/ldap.conf if it exists
if [ -f /etc/ldap.conf ]; then
    sudo cp /etc/ldap.conf /etc/ldap.conf.bak
    echo "Backup of /etc/ldap.conf created: /etc/ldap.conf.bak"
fi

# Write the new content to /etc/ldap.conf
echo "$LDAP_CONTENT" | sudo tee /etc/ldap.conf > /dev/null

echo "Updated /etc/ldap.conf successfully."
