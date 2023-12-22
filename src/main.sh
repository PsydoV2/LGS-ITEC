#!/bin/bash

HOSTS_FILE="/usr/local/bin/testping/hosts"
LOG_FILE="/usr/local/bin/testping/logs.txt"
CRON_FILE="/usr/local/bin/testping/cronjob"

if [ -e "$HOSTS_FILE" ]; then
    echo "Host-Datei existiert!"
else
    echo "Host-Datei existiert nicht!"
fi

if [ -e "$LOG_FILE" ]; then
    echo "Log-Datei existiert!"
else
    echo "Log-Datei existiert nicht!"
fi

if [ -e "$CRON_FILE" ]; then
    echo "Cron-Datei existiert!"
else
    echo "Cron-Datei existiert nicht!"
fi
