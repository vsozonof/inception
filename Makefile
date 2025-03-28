DOCKER_COMPOSE = docker compose
COMPOSE_FILE = docker-compose.yml

.PHONY: all build up down restart logs clean

all: up

build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

up:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

restart: down up

logs:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

clean: down
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v --remove-orphans

ps:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

exec-wp:
	docker exec -it wordpress /bin/bash

exec-nginx:
	docker exec -it nginx /bin/bash

exec-mariadb:
	docker exec -it mariadb /bin/bash
