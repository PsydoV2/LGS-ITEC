#!/bin/bash

if [ -f "src/main.sh" ]; then
    cp src/main.sh /usr/local/bin/testping      # Skript verschieben um es als Command ausführen zu können

    cp src/testping.1 /usr/local/share/man/man1/testping.1  # Man page file verschieben
    gzip /usr/local/man/man1/testping.1                 # Man page zip
    mandb  # man pages updaten 
    # rm -rf src

    if [ -f "/usr/local/bin/testping" ]; then
        chown root:users /usr/local/bin/testping    # Damit man den Befehl nicht mit sudo ausführen muss
        chmod 755 /usr/local/bin/testping           # Ausführrechte
        chown root:users /usr/local/man/man1/testping.1.gz    # Damit man man testping benutzen kann

        echo "Skript unter 'testping' verfügbar."
    else
        echo "Fehler beim Installieren des Skripts."
    fi
else
    echo "Fehler beim Installieren des Skripts (Datei fehlt)."
fi
