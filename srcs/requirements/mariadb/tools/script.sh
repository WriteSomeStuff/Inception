#!/bin/bash

echo "Starting MariaDB..."
service mariadb start

echo "Running MariaDB commands..."
mysql -u root --password="$DB_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "MariaDB commands executed successfully."
else
    echo "Error running MariaDB commands!" >&2
    exit 1
fi

service mariadb stop

echo "MariaDB completed successfully."

exec mysqld
