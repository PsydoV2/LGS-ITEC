#!/bin/bash

# Install Done
# Uninstall Done
# Main Script
    # ping  1/2 done
    # config    1/3 done
    # addhost   done
    # delhost   done
    # install cron
    # uninstall cron
# Man Page Done


pinging() {
    anzahl_pakete=$(grep -Po '(?<=# Anzahl Pakete\n)[0-9]+' "/usr/share/testping/config.cfg")
    timeout=$(grep -Po '(?<=# Timeout in Sekunden\n)[0-9]+' "/usr/share/testping/config.cfg")
    zeitintervall=$(grep -Po '(?<=# Zeitintervall in Sekunden\n)[0-9]+' "/usr/share/testping/config.cfg")

    echo $anzahl_pakete "Pakete"
    echo $timeout "Timeout"
    echo $zeitintervall "Intervall"


    echo "---------- Start Pinging ----------"

    while IFS= read -r line || [ -n "$line" ]; do
        if [ -n "$line" ]; then
            echo "Ping wird ausgeführt für: $line"
            ping -c "$anzahl_pakete" -w "$timeout" -i "$intervall" "$line"
            echo "-------------------------"
        fi
    done < /usr/share/testping/hosts
}

editConfig() {
    nano /usr/share/testping/config.cfg
}

addhost() {
    if [ -n "$2" ]; then
        echo $2 >> /usr/share/testping/hosts
        echo $2 " hinzugefügt!"
    else
        echo "Keine IP-Adresse angegeben."
    fi
}

delhost(){
    if [ -n "$2" ]; then
        sed -i "/$2/d" "/usr/share/testping/hosts"
        echo $2 "gelöscht!"
    else
        echo "Keine IP-Adresse angegeben."
    fi
}

printhosts(){
    echo "Gespeicherte Hosts:"
    cat /usr/share/testping/hosts
}


case "$1" in
    "config")
        editConfig
        ;;
    "addhost")
        addhost "$@"
        ;;
    "delhost")
        delhost "$@"
        ;;
    "hosts")
        printhosts
        ;;
    "-h")
        man testping
        ;;
    *)
        pinging
        ;;
esac

