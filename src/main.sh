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
        echo /usr/share/testping/hosts >> $2
        echo $2 " hinzugefügt!"
    else
        echo "Keine IP-Adresse angegeben."
    fi
}

printhosts(){
    echo "Test"
    cat /usr/share/testping/hosts
}


case "$1" in
    "config")
        editConfig
        ;;
    "addhost")
        addhost "$@"
        ;;
    "hosts")
        printhosts
    ;;
    *)
        pinging
        ;;
esac

