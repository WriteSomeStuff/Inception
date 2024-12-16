NAME= inception

all: re

prep:
	echo "127.0.0.1 cschabra.42.fr" | sudo tee -a /etc/hosts > /dev/null

down:
	docker compose -f srcs/docker-compose.yml down

prune:
	docker system prune -a -f

re: prune
	docker compose -f srcs/docker-compose.yml up

status:
	docker compose -f srcs/docker-compose.yml ps

.PHONY: all prep prune stop re status