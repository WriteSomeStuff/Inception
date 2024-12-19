FROM debian:bullseye

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install php php-mysql

COPY ./tools/script.sh /etc/wordpress/tools/script.sh

EXPOSE 9000

ENTRYPOINT	[ "sh", "/etc/wordpress/tools/script.sh" ]