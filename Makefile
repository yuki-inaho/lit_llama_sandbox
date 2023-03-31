# Makefile for building and running mmpose Docker container

DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = docker-compose.yml
CONTAINER_NAME = lit-llama-sandbox

.PHONY: build up down logs

build:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f $(CONTAINER_NAME)

run:
	xhost + local:root
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) exec $(CONTAINER_NAME) bash