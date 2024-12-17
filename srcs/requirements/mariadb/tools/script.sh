#!/bin/bash

echo "Starting MariaDB service..."
systemctl mariadb start

sleep 3

echo "Running MariaDB commands..."
mysql -u "$DB_USER" <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "MariaDB commands executed successfully."
else
    echo "Error executing MariaDB commands!" >&2
    exit 1
fi

echo "Stopping MariaDB service..."
systemctl mariadb stop

if [ $? -eq 0 ]; then
    echo "MariaDB service stopped successfully."
else
    echo "Failed to stop MariaDB service!" >&2
    exit 1
fi

echo "MariaDB" completed successfully."

exec "$@"