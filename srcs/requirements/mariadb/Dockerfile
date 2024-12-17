FROM debian:bullseye

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install mariadb-server

COPY ./tools/script.sh /etc/mariadb/tools/script.sh
ENTRYPOINT [ "sh" "/etc/mariadb/tools/script.sh" ]

EXPOSE 3306

CMD [ "mysql" ]