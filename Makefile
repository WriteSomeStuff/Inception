NAME= inception

all: re

down:
	docker-compose -f srcs/docker-compose.yml down

prune:
	docker system prune -a -f

re: prune
	docker-compose -f srcs/docker-compose.yml up

status:
	docker-compose -f srcs/docker-compose.yml ps

.PHONY: all prune stop re status