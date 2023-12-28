#!/bin/bash

if [ -f "src/main.sh" ]; then
    #cp src/testping.1 /usr/local/share/man/man1/testping.1  # Man page file verschieben
    #gzip /usr/local/man/man1/testping.1                 # Man page zip
    #mandb  # man pages updaten 
    # rm -rf src

    mkdir /usr/share/testping                                       # Ordner für alle Dateien erstellen
    cp src/main.sh /usr/share/testping/testping.sh                  # Skript verschieben
    ln -s /usr/share/testping/testping.sh /usr/bin/testping         # Skript als command verfügbar machen
    
    # Assets erstellen
    touch /usr/share/testping/log.txt
    echo "Datei erfolgreich ausgegeben!" >> /usr/share/testping/log.txt

    if [ -f "/usr/local/bin/testping" ]; then
        # Verknüpfung zu Skript
        chown root:users /usr/bin/testping    # Damit man den Befehl nicht mit sudo ausführen muss
        chmod 755 /usr/bin/testping           # Ausführrechte

        # Ordner
        chmod 777 /usr/share/testping
        chown root:users /usr/share/testping

        chmod 777 /usr/share/testping/log.txt
        chown root:users /usr/share/testping/log.txt

        # Man page
        #chown root:users /usr/local/man/man1/testping.1.gz    # Damit man man testping benutzen kann

        echo "Skript unter 'testping' verfügbar."
    else
        echo "Fehler beim Installieren des Skripts."
    fi
else
    echo "Fehler beim Installieren des Skripts (Datei fehlt)."
fi
