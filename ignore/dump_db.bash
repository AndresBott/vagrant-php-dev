#!/usr/bin/env bash



if [ $1 = "backup" ] && [ $4 = "restore_and_backup" ]; then
    echo "mysqldump --add-drop-database -B $2 > $3$2.sqldump"
    mysqldump "--add-drop-database" -B $2  > "$3$2.sqldump"
fi

if [ $1 = "restore" ]; then
    if [ -f "$3$2.sqldump" ]; then
        echo "mysql < $3$2.sqldump"
        mysql < "$3$2.sqldump"
    else
        echo "WARN: No database to restore: $3$2.sqldump"
    fi

fi
