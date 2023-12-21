rm /usr/local/bin/testping
rm /usr/local/share/man/man8/testping.1

if [ ! -f "/usr/local/bin/testping" ]; then
    echo "Erfolgreich entfernt!"
else
    echo "Fehler beim Entfernen!"
fi 