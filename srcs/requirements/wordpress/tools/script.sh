while ! mysql -h "mariadb" -u $DB_USER --password="$DB_PASSWORD" -D $DB_NAME; do
    echo "Waiting for MariaDB to be ready." && sleep 5
done
echo "MariaDB is ready."

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

php wp-cli.phar --info

if [ $? -eq 0 ]; then
    echo "Wp-cli installed successfully."
else
    echo "Error installing wp-cli!" >&2
    exit 1
fi

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp --info

if [ $? -eq 0 ]; then
    echo "Wp commands working."
else
    echo "Error installing wp-cli!" >&2
    exit 1
fi

mkdir -p /run/php
chown www-data:www-data /run/php

if [ -f ./wp-config.php ]; then
    echo "Wp already downloaded."
else
    wp core download --allow-root --locale=en_GB
    wp core config --allow-root --dbhost=mariadb --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD
    wp core install --allow-root --url=$DOMAIN_NAME --title=$DB_NAME --admin_user=$DB_ADMIN --admin_password=$DB_ADMIN_PASSWORD --admin_email=$DB_ADMIN_EMAIL
    wp user create --allow-root $DB_USER $DB_USER_EMAIL --user_pass=$DB_PASSWORD

    if [ $? -eq 0 ]; then
        echo "Wordpress installed successfully."
    else
        echo "Error installing Wordpress!" >&2
        exit 1
    fi
fi

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

exec "$@"