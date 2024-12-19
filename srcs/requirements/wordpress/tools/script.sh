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

mkdir wordpress

wp core download --path=./wordpress/ --locale=en_GB

if [ $? -eq 0 ]; then
    echo "Wordpress installed successfully."
else
    echo "Error installing Wordpress!" >&2
    exit 1
fi

