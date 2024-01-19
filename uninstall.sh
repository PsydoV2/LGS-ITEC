cp /usr/bin/testping/log.txt ./log-backup.txt
cp /usr/bin/testping/hosts ./hosts-backup.txt
cp /usr/bin/testping/config.cfg ./config-backup.cfg

rm -rf /usr/share/testping
rm /usr/bin/testping
rm /usr/local/man/man1/testping.1.gz


# Ordner

if [ ! -d "/usr/share/testping" ]; then
    echo "Programm Ordner entfernt!"
else
    echo "Fehler beim Entfernen vom Ordner!"
fi 

# Verknüpfung

if [ ! -f "usr/bin/testping" ]; then
    echo "Programmverknüpfung entfernt!"
else 
    echo "Fehler beim Entfernen von Programmverknüpfung!"
fi

# Man Page

if [ ! -d "/usr/local/man/man1/testping.1.gz" ]; then
    echo "Man Page entfernt!"
else
    echo "Fehler beim Entfernen von Man Page!"
fi

# Cron Job

crontab_content=$(crontab -l 2>/dev/null || echo "")
job_pattern=".*testping\.sh"

if echo "$crontab_content" | grep -qE "$job_pattern"; then
    echo "$crontab_content" | sed -E "/$job_pattern/d" | crontab -
    echo "Cron job entfernt!"
else
    echo "Kein Cron job gefunden!"
fi