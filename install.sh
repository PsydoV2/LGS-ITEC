#!/bin/bash

if [ -f "src/main.sh" ]; then

    # Überprüfen ob dos2unix installiert ist um den befehl nutzen zu können
    if ! which dos2unix >/dev/null 2>&1 ; then
        sudo apt-get install dos2unix > /dev/null
    fi

    # Skript erstellen
    mkdir /usr/share/testping                                       # Ordner für alle Dateien erstellen
    cp src/main.sh /usr/share/testping/testping.sh                  # Skript verschieben
    ln -s /usr/share/testping/testping.sh /usr/bin/testping         # Skript als command verfügbar machen
    dos2unix /usr/share/testping/testping.sh                        # Konvertieren da es an einem Windows PC geschrieben wurde und es zu fehlern der Zeilenendungen kommen kann
    
    # Assets erstellen
    touch /usr/share/testping/log.txt
    touch /usr/share/testping/hosts
    cp src/config.cfg /usr/share/testping/config.cfg
    dos2unix /usr/share/testping/config.cfg                         # Konvertieren da es an einem Windows PC geschrieben wurde und es zu fehlern der Zeilenendungen kommen kann

    if [ ! -d /usr/local/share/man/man1 ]; then
        mkdir -p /usr/local/share/man/man1
    fi

    # Man page erstellen
    cp src/testping.1 /usr/local/share/man/man1/testping.1     # Man page file verschieben
    gzip /usr/local/man/man1/testping.1                        # Man page zip
    mandb > /dev/null # man pages updaten und output "verkleinern"

    if [ -f "/usr/share/testping/testping.sh" ] && [ -f "/usr/bin/testping" ]; then # wenn verschieben und verknüpfung erstellen erfolgreich waren

        # Verknüpfung zu Skript
        chown root:users /usr/bin/testping    # sudo not required
        chmod 755 /usr/bin/testping           # Ausführrechte

        # Ordner
        chmod -R 777 /usr/share/testping

        # Man page
        chown root:users /usr/local/man/man1/testping.1.gz      # damit man die 'man' page öffnen kann

        sudo setcap cap_net_raw+ep /bin/ping                    # Manchmal hat der user keine rechte 'ping' auszuführen


        echo "Skript unter dem Befehl 'testping' verfügbar."
    else
        echo "Fehler beim Installieren des Skripts (Dateien nicht gefunden)."
    fi
else
    echo "Fehler beim Installieren des Skripts (Datei fehlt)."
fi
