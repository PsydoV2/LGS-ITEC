#!/bin/bash

if [ -f "src/main.sh" ]; then
    # Verschieben von main.sh nach /usr/local/bin/testping
    mv src/main.sh /usr/local/bin/testping
    rm src

    # Überprüfen, ob die Datei erfolgreich verschoben wurde
    if [ -f "/usr/local/bin/testping" ]; then
        chmod +x /usr/local/bin/testping  # Setzen der Ausführungsrechte
        echo "Das Skript 'main.sh' wurde erfolgreich als 'testping' konfiguriert."
    else
        echo "Fehler beim Verschieben des Skripts nach '/usr/local/bin/testping'."
    fi
else
    echo "Die Datei main.sh wurde im Verzeichnis src nicht gefunden."
fi
