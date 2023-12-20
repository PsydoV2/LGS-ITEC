rm /usr/local/bin/testping

if [ ! -f "/usr/local/bin/testping" ]; then
    echo "Erfolgreich entfernt!"
else
    echo "Konnte nicht entfernt werden!"
fi 