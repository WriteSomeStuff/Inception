while ! mysql -h "mariadb" -u $DB_USER --password="$DB_PASSWORD" -D $DB_NAME; do
    echo "Waiting for MariaDB to be ready." && sleep 5
done
echo "MariaDB is ready."

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

php wp-cli.phar --info

if [ $? -eq 0 ]; then
    echo "Wp-cli installed successfully."
else
    echo "Error installing wp-cli!" >&2
    exit 1
fi

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

if [ -f ./wp-login.php ]; then
    echo "Wp already downloaded."
else
    wp core download --allow-root --locale=en_GB
fi

if [ -f ./wp-config.php ]; then
    echo "Wp config already made."
else
    wp config create --allow-root --dbhost=mariadb --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD
    if [ $? -eq 0 ]; then
        echo "Config file made successfully."
    else
        echo "Error making config file!" >&2
        exit 1
    fi

    wp core install --allow-root --skip-email --url=$DOMAIN_NAME --title=$DB_NAME --admin_user=$DB_ADMIN --admin_password=$DB_ADMIN_PASSWORD --admin_email="skipthis@test.com"
    wp user create --allow-root $DB_USER "skipthis2@test.com" --user_pass=$DB_PASSWORD
fi

sed -i "s/listen.*/listen = 9000/g" /etc/php/7.4/fpm/pool.d/www.conf

echo "Wordpress completed successfully."

exec /usr/sbin/php-fpm7.4 -F