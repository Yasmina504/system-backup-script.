#!/bin/bash

# تحديد مجلد النسخ الاحتياطي
backup_dir="/var/backups/system"
mkdir -p "$backup_dir"

# اسم ملف النسخة الاحتياطية
backup_file="$backup_dir/system_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# App Password اللي عملتيه
APP_PASSWORD="mwcc tybn njah gdqb "

# تنفيذ النسخ الاحتياطي والتحقق من النجاح
if tar -czf "$backup_file" /etc; then
    echo "Backup created: $backup_file"
    # إرسال إيميل النجاح باستخدام s-nail و App Password
    echo "Backup completed successfully at $(date)" | s-nail -S smtp="smtp.gmail.com:587" \
        -S smtp-use-starttls \
        -S smtp-auth=login \
        -S smtp-auth-user="yasminaabdelkarim32@gmail.com" \
        -S smtp-auth-password="$APP_PASSWORD" \
        -S ssl-verify=ignore \
        -s "System Backup Report" yasminaabdelkarim32@gmail.com
else
    echo "Backup FAILED at $(date)"
    # إرسال إيميل الفشل
    echo "Backup FAILED at $(date)" | s-nail -S smtp="smtp.gmail.com:587" \
        -S smtp-use-starttls \
        -S smtp-auth=login \
        -S smtp-auth-user="yasminaabdelkarim32@gmail.com" \
        -S smtp-auth-password="$APP_PASSWORD" \
        -S ssl-verify=ignore \
        -s "ALERT: Backup Failed" yasminaabdelkarim32@gmail.com
fi

