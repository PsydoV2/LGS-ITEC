rm /usr/local/bin/testping
rm /usr/local/man/man1/testping.1.gz

if [ ! -f "/usr/local/bin/testping" ]; then
    echo "Erfolgreich entfernt!"
else
    echo "Fehler beim Entfernen!"
fi 