FROM debian:bullseye

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install mariadb-server mariadb-client

COPY ./tools/script.sh /etc/mariadb/tools/script.sh
COPY ./conf/mdb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT [ "sh", "/etc/mariadb/tools/script.sh" ]