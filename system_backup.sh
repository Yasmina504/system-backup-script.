#!/bin/bash

BACKUP_DIR="$HOME/backups/system"
mkdir -p "$BACKUP_DIR"

BACKUP_FILE="$BACKUP_DIR/system_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

EMAIL="yasminaabdelkarim32@gmail.com"
APP_PASSWORD_FILE="$HOME/backup_script/backup_app_password"
APP_PASSWORD=$(cat "$APP_PASSWORD_FILE")

sudo tar -czf "$BACKUP_FILE" /etc

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
    echo -e "Subject: Backup Completed\n\nBackup completed successfully at $(date)" | msmtp --from="$EMAIL" "$EMAIL"
else
    echo "Backup FAILED at $(date)"
    echo -e "Subject: ALERT: Backup Failed\n\nBackup FAILED at $(date)" | msmtp --from="$EMAIL" "$EMAIL"
fi

