#!/bin/sh

# Execute backup script
sh /opt/scripts/backup.job.sh ${@}

# Synchronize backups
echo -n " Synchronizing backups ... "
rsync -auz /opt/backups/ /opt/backups-dist
echo "Done"
echo

exit 0