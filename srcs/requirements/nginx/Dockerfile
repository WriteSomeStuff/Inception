FROM debian:bullseye

RUN apt-get -y update && \
	apt-get upgrade -y && \
	apt-get -y install nginx && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]