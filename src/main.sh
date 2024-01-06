#!/bin/bash

# TODO:
# Install ✓
# Uninstall ✓
# Main Script
    # ping  2/2 ✓
    # config    3/3 ✓
    # addhost   ✓
    # delhost   ✓
    # install cron 2/2 ✓
    # uninstall cron ✓
# Man Page ✓




# Funktion für das Ausführen von Pings
pinging() {
    # Werte aus der config lesen
    anzahl_pakete=""
    timeout=""
    zeitintervall=""

    while IFS= read -r line; do
        case "$line" in
            "# Anzahl Pakete")
                read -r anzahl_pakete
                ;;
            "# Timeout in Sekunden")
                read -r timeout
                ;;
            "# Zeitintervall in Sekunden")
                read -r zeitintervall
                ;;
            *)
                continue
                ;;
        esac
    done < "/usr/share/testping/config.cfg"

    if [ $zeitintervall -eq 0 ]; then
        zeitintervall=1 # Darf nicht 0 sein sonst fehler
    fi

    echo "---------- Starte Pings ----------"

    # Schleife durch die Host-Datei und Ausführen eines Pings für jeden Host
    while IFS= read -r line || [ -n "$line" ]; do
        if [ -n "$line" ]; then
            echo "Ping wird ausgeführt für: $line"

            # Ausführen des Ping-Befehls mit Parametern aus der Konfiguration
            ping -c "$anzahl_pakete" -w "$timeout" -i "$zeitintervall" "$line"

            # Überprüfen des Ping-Status und schreiben der logs
            if [ $? -ne 0 ]; then
                echo "$line ist nicht erreichbar!"
                echo "$line" >> /usr/share/testping/log.txt
            fi

            echo "-------------------------"
        fi
    done < /usr/share/testping/hosts
}

# Funktion zum Bearbeiten der Config
editConfig() {
    nano /usr/share/testping/config.cfg
}

# Funktion zum Hinzufügen eines Hosts zur Host-Datei
addhost() {
    if [ -n "$2" ]; then
        echo "$2" >> /usr/share/testping/hosts
        echo "$2 hinzugefügt!"
    else
        echo "Keine IP-Adresse angegeben."
    fi
}

# Funktion zum Löschen eines Hosts aus der Host-Datei
delhost(){
    if [ -n "$2" ]; then
        sed -i "/$2/d" "/usr/share/testping/hosts"
        echo "$2 gelöscht!"
    else
        echo "Keine IP-Adresse angegeben."
    fi
}

# Funktion zum Anzeigen der gespeicherten Hosts
printhosts(){
    echo "Gespeicherte Hosts:"
    cat /usr/share/testping/hosts
}

# Funktion zum Installieren des Cron-Jobs
install() {
    # Vorhandenen Cron-Job entfernen (falls vorhanden)
    local crontab_content
    crontab_content=$(crontab -l 2>/dev/null || echo "")
    local job_pattern=".*testping\.sh"

    if echo "$crontab_content" | grep -qE "$job_pattern"; then
        echo "$crontab_content" | sed -E "/$job_pattern/d" | crontab -
        echo "Vorhandener Cron-Job aktualisiert"
    fi

    # Neuen Cron-Job hinzufügen
    if [ -n "$2" ]; then
        (crontab -l ; echo "*/$2 * * * * /usr/share/testping/testping.sh") | crontab -
        echo "Cron-Job alle $2 Minuten hinzugefügt"
    else
        echo "Minuten fehlen!"
    fi
}

# Funktion zum Deinstallieren des Cron-Jobs
uninstall() {
    local crontab_content
    crontab_content=$(crontab -l 2>/dev/null || echo "")
    local job_pattern=".*testping\.sh"

    if echo "$crontab_content" | grep -qE "$job_pattern"; then
        echo "$crontab_content" | sed -E "/$job_pattern/d" | crontab -
        echo "Cron-Job entfernt!"
    else
        echo "Kein Cron-Job gefunden!"
    fi
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
    "install")
        install "$@"
        ;;
    "uninstall")
        uninstall
        ;;
    "")
        pinging
        ;;
    *)
        echo "Falsche Argumente übergeben!"
        ;;
esac
