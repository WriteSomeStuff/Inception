#!/bin/bash

echo "Starting MariaDB..."
service mariadb start

sleep 5

echo "Running MariaDB commands..."
mysql -u root <<EOF
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

echo "Stopping MariaDB..."
service mariadb stop

if [ $? -eq 0 ]; then
    echo "MariaDB stopped successfully."
else
    echo "Failed to stop MariaDB!" >&2
    exit 1
fi

echo "MariaDB completed successfully."

exec mysqld