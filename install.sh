#!/bin/bash

# Test ob Ordner schon existiert
if [ ! -d "/bin/usr/testping/" ]; then
    mkdir -p /bin/usr/testping/
fi

# Datei wird verschoben
mv /testping/main.sh /bin/usr/testping/

# Überprüfung ob es Erfolgreich verschoben wurde
if [ -f "/bin/usr/testping/main.sh" ]; then
    chmod +x /bin/usr/testping/main.sh
    echo "Skript erfolgreich installiert."
else
    echo "Skript konnte nicht installiert werden."
fi
