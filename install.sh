#!/bin/bash

# Überprüfen, ob der Ordner bereits existiert, wenn nicht, erstellen
if [ ! -d "usr/bin/testping" ]; then
    mkdir -p usr/bin/testping
fi

# Datei wird verschoben
if [ -f "src/main.sh" ]; then
    mv src/main.sh usr/bin/testping/

    if [ -f "usr/bin/testping/main.sh" ]; then
        chmod +x usr/bin/testping/main.sh
        echo "Skript erfolgreich installiert."
    else
        echo "Skript konnte nicht installiert werden."
    fi
else
    echo "Die Datei main.sh wurde im Verzeichnis src nicht gefunden."
fi
