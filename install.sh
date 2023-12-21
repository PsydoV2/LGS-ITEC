#!/bin/bash
if [ -f "src/main.sh" ]; then
    cp src/main.sh /usr/local/bin/testping
    cp src/testping.1 /usr/local/share/man/man8/testping.1
    gzip /usr/local/share/man/man8/testping.1
    # mandb
    # rm src

    if [ -f "/usr/local/bin/testping" ]; then
        chown root:users /usr/local/bin/testping  # Sonst ist root alleiniger besitzer und man muss sudo benutzen
        chmod 755 /usr/local/bin/testping # root kann lesen und ändern jeder andere nur lesen und ausführen

        echo "Skript unter 'testping' verfügbar."
    else
        echo "Fehler beim Installieren des Skripts."
    fi
else
    echo "Fehler beim Installieren des Skripts (Datei fehlt)."
fi