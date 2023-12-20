#!/bin/bash

# Verschiebe die Datei main.sh nach /bin/usr/command/ (falls sie dort noch nicht vorhanden ist)
mv /command/main.sh /bin/usr/command/

# Wechsel in das Verzeichnis /bin/usr/command/
cd /bin/usr/command/

# Überprüfe, ob main.sh im Ordner existiert
if [ -f "main.sh" ]; then
    chmod +x main.sh
    echo "Installiert"
else
    echo "main.sh existiert nicht im Ordner /bin/usr/command/"
fi
