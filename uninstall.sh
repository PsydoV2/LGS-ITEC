rm -rf /usr/share/testping
rm /usr/bin/testping
rm /usr/local/man/man1/testping.1.gz

if [ ! -d "/usr/share/testping" ]; then
    echo "Programm Ordner entfernt!"
else
    echo "Fehler beim Entfernen von Programm Ordner!"
fi 

if [ ! -f "usr/bin/testping" ]; then
    echo "Skript verknüpfung entfernt!"
else 
    echo "Fehler beim Entfernen von Programmverknüpfung!"
fi

if [ ! -d "/usr/local/man/man1/testping.1.gz" ]; then
    echo "Man Page entfernt!"
else
    echo "Fehler beim Entfernen von Man Page!"
fi