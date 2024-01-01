#!/bin/bash

# Install Done
# Uninstall Done
# Main Script
    # ping  2/2 done
    # config    3/3 done
    # addhost   done
    # delhost   done
    # install cron 1/2 done
    # uninstall cron done
# Man Page Done


pinging() {

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

    # echo "Anzahl Pakete: $anzahl_pakete"
    # echo "Timeout: $timeout"
    # echo "Zeitintervall: $zeitintervall"

    if [ $zeitintervall -eq 0 ]; then
        zeitintervall=1     # Darf nicht 0 sein sonst fehler
    fi


    echo "---------- Start Pinging ----------"

    while IFS= read -r line || [ -n "$line" ]; do
        if [ -n "$line" ]; then
            echo "Ping wird ausgeführt für: $line"

            ping -c "$anzahl_pakete" -w "$timeout" -i "$zeitintervall" "$line"

            # Rückgabewert 0 = Ping fehlgeschlagen
            if [ $? -ne 0 ]; then
                echo $line " nicht erreichbar!"
                echo $line >> /usr/share/testping/log.txt
            fi

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

install(){
    if [ -n "$2" ]; then
        (crontab -l ; echo "*/$2 * * * * /usr/share/testping/testping.sh") | crontab -
        echo "Crontab Job alle $2 Minuten hinzugefügt"
    else
    echo "Minuten fehlen."
    fi
    
}

uninstall(){

    local crontab_content=$(crontab -l 2>/dev/null || echo "")
    local job_pattern=".*testping.sh"

    if echo "$crontab_content" | grep -qE "$job_pattern"; then
        echo "$crontab_content" | sed -E "/$job_pattern/d" | crontab -
        echo "Cron-Job für testping entfernt"
    else
        echo "Kein entsprechender Cron-Job für testping gefunden"
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
    *)
        pinging
        ;;
esac

