FROM debian:bullseye

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install curl php php-fpm php-mysql mariadb-client

COPY ./tools/script.sh /etc/wordpress/tools/script.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT	[ "sh", "/etc/wordpress/tools/script.sh" ]