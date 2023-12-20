#!/bin/bash

if [ -f "src/main.sh" ]; then
    cp src/main.sh /usr/local/bin/testping
    cp src/testping.1 /usr/share/man/man1/
    mandb
    # rm src

    if [ -f "/usr/local/bin/testping" ]; then
        chmod +x /usr/local/bin/testping 
        echo "Skript unter 'testping' verfügbar."
    else
        echo "Fehler beim Installieren des Skripts."
    fi
else
    echo "Fehler beim Installieren des Skripts (Datei fehlt)."
fi
