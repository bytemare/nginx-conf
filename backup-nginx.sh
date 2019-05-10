#! /bin/bash

#
# Creates a bakup directory for nginx configuration files. Supsequent calls will add backups to directory.
# Backups are balled and compressed in tar.gz. The latest backup has conveniently alsways the same name.
#


timestamp() {
        date +"%Y-%m-%d_%H-%M-%S"
}


# Nginx dirs and files to be backed up
nginx_root="/etc/nginx"

targets="nginx.conf snippets sites-available sites-enabled"

# The name the latest backup should have
latest_backup="nginx-backup-latest.tar.gz"

# Directory for all backups
backup_destination="./nginx-backup"

# Naming convention
backup_prefix="nginx-backup-"
backup_timestamp="$(timestamp)"

# New Backup directory
new_backup_dir="$backup_prefix$backup_timestamp"

# Create higher backup directory
mkdir -p $backup_destination
cd $backup_destination

# Remove "-latest" backup tar.gz
rm $latest_backup

# Create new backup dir
mkdir -p $new_backup_dir

# Copy targets
for d in $targets; do
        cp -r $nginx_root/$d $new_backup_dir
done

#Change owner
#chown $USER:$USER -R $nginx_backup_dir

# Compress
tar -zcf $new_backup_dir.tar.gz $new_backup_dir
tar -zcf $latest_backup $new_backup_dir

# Remove directory
rm -rf ./$new_backup_dir 2> /dev/null

echo "Backup located at $backup_destination/$latest_backup"
