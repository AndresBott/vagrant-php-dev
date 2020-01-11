#!/usr/bin/env bash

if [ $1 = "backup" ]; then
    echo "mysqldump --add-drop-database -B $2 > $3/$2.sqldump"
    mysqldump "--add-drop-database" -B $2  > "$3/$2.sqldump"
fi

if [ $1 = "restore" ]; then
    if [ -f "$3/$2.sqldump" ]; then
        echo "mysql < $3/$2.sqldump"
        mysql < "$3/$2.sqldump"
    else
        echo "WARN: No database to restore: $3/$2.sqldump"
    fi
fi

if [ $1 = "enable-cron-backup" ]; then
  CRON_FILE="/tmp/crontab"
  crontab -l > $CRON_FILE


  if grep -Fq "$2.sqldump" $CRON_FILE
  then
      echo "skiping cron entry: $2"
  else
      echo "adding cron entry for: $2"
      echo "*/10 * * * * mysqldump "--add-drop-database" -B $2  > "$3/$2.sqldump"" >> /tmp/crontab
  fi

  #install new cron file
  crontab /tmp/crontab
  rm /tmp/crontab
fi
