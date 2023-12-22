#!/bin/bash

HOSTS_FILE=~/.testping/hosts
LOG_FILE=~/.testping/log.txt
CRON_FILE=~/.testping/cronjob

# Funktion zum Hinzufügen eines Hosts
add_host() {
    if ! grep -q "^$1$" "$HOSTS_FILE"; then
        echo "$1" >> "$HOSTS_FILE"
        echo "Host $1 wurde hinzugefügt."
    else
        echo "Host $1 ist bereits vorhanden."
    fi
}

# Funktion zum Entfernen eines Hosts
del_host() {
    if grep -q "^$1$" "$HOSTS_FILE"; then
        sed -i.bak "/^$1$/d" "$HOSTS_FILE"
        echo "Host $1 wurde entfernt."
    else
        echo "Host $1 ist nicht vorhanden."
    fi
}

# Funktion zum Anzeigen der gespeicherten Hosts
show_hosts() {
    echo "Gespeicherte Hosts:"
    cat "$HOSTS_FILE"
}

# Funktion zum Pingen der Hosts und Protokollieren nicht erreichbarer Hosts
ping_hosts() {
    echo "Ping gestartet..."
    while IFS= read -r host || [ -n "$host" ]; do
        if ! ping -c 1 "$host" > /dev/null 2>&1; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Host $host ist nicht erreichbar!" | tee -a "$LOG_FILE"
        fi
    done < "$HOSTS_FILE"
    echo "Ping abgeschlossen."
}

# Hauptskript
if [ $# -eq 0 ]; then
    ping_hosts
elif [ "$1" = "addhost" ] && [ -n "$2" ]; then
    add_host "$2"
elif [ "$1" = "delhost" ] && [ -n "$2" ]; then
    del_host "$2"
elif [ "$1" = "showhosts" ]; then
    show_hosts
elif [ "$1" = "install" ] && [ -n "$2" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "*/$2 * * * * $(realpath $0) > /dev/null 2>&1" > "$CRON_FILE"
    crontab "$CRON_FILE"
    echo "Cron-Job wurde installiert, um das Skript alle $2 Minuten auszuführen."
else
    echo "Ungültige Verwendung. Verfügbare Optionen: "
    echo "   addhost IP-Adresse"
    echo "   delhost IP-Adresse"
    echo "   showhosts"
    echo "   install X"
fi
