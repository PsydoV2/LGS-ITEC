#!/bin/bash

# TODO: 
# Install Done
# Uninstall Done
# Main Script
# Man Page


pinging() {
    echo "---------- Start Pinging ----------"
    ping -c 4 www.google.com
}

editConfig() {
    nano /usr/share/testping/config.cfg
}

addhost() {
    if [ -n "$2" ]; then
        echo "Die übergebene IP-Adresse ist: $2"
    else
        echo "Keine IP-Adresse angegeben."
    fi
}


case "$1" in
    "config")
        editConfig
        ;;
    "addhost")
        addhost "$@"
        ;;
    *)
        pinging
        ;;
esac

