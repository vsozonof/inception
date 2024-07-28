# Variables
DOCKER_COMPOSE = docker compose
COMPOSE_FILE = docker-compose.yml

# Targets

.PHONY: all build up down restart logs clean

# Default target
all: up

# Build the containers
build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

# Start the containers in detached mode
up:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

# Stop the containers
down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

# Restart the containers
restart: down up

# View logs from containers
logs:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

# Clean up containers, networks, and volumes
clean: down
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v --remove-orphans

# View container status
ps:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

# Execute a command in a running container (example: shell into a container)
exec:
	docker exec -it wordpress-container /bin/bash
