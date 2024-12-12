FROM debian:bullseye

RUN apt-get -y update && \
	apt-get upgrade -y && \
	apt-get -y install nginx openssl && \
	mdir -p /etc/nginx/ssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Chey/OU=Unit1/CN=cschabra.42.fr/UID=cschabra" \ 
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key && \
	chmod 777 /etc/nginx/ssl/ && \
	chown -R www-data:www-data /etc/nginx/ssl/

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf
COPY ./tools/index.html /etc/nginx/tools/index.html

WORKDIR /etc/nginx/tools

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]