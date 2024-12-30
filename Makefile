NAME= inception

all: re

prep:
	echo "127.0.0.1 cschabra.42.fr" | sudo tee -a /etc/hosts > /dev/null
	mkdir -p ${HOME}/inception
	mkdir -p ${HOME}/inception/db
	mkdir -p ${HOME}/inception/wp

down:
	docker compose -f srcs/docker-compose.yml down

prune:
	docker builder prune -f && docker system prune -a -f
	sudo rm -rf ${HOME}/inception

re: prune
	docker compose -f srcs/docker-compose.yml up

status:
	docker compose -f srcs/docker-compose.yml ps

.PHONY: all prep down prune re status