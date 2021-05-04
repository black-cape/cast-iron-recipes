SHELL := /bin/bash

# NOTE: Will use the previously set varialbe if it exists, else it will try to retrieve it based on whether or not the
# OS is Mac or Linux. Please note that the `ip` command needs to be available for Linux systems.
export DOCKER_GATEWAY_HOST := $(shell if [[ ! -z "${DOCKER_GATEWAY_HOST}" ]]; then echo $(DOCKER_GATEWAY_HOST); elif [ `uname` == "Darwin" ]; then echo `ipconfig getifaddr en0`; else echo `ip -4 addr show eno1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`; fi)
export COMPOSE_HTTP_TIMEOUT := 240
export MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
export CUR_DIR := $(dir $(MKFILE_PATH))
.PHONY: $(SERVICES) logs

help: ## This info
	@echo '_________________'
	@echo '| Make targets: |'
	@echo '-----------------'
	@echo
	@cat Makefile | grep -E '^[a-zA-Z\/_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

print-gateway-host:
	@echo Using $(DOCKER_GATEWAY_HOST) for the DOCKER_GATEWAY_HOST variable

setup: ## Run the create/setup scripts
	make print-gateway-host

up: ## Start all service and storage containers
	make print-gateway-host
	docker-compose -f docker-compose.yml -f cast-iron/docker-compose.yml up -d --build
	make setup

down: ## Stop all containers
	make print-gateway-host
	docker-compose -f docker-compose.yml -f cast-iron/docker-compose.yml down

remake: ## Tear down and rebuild containers
	make print-gateway-host
	docker-compose -f docker-compose.yml -f cast-iron/docker-compose.yml down -v
	docker-compose -f docker-compose.yml -f cast-iron/docker-compose.yml build --no-cache --force-rm
	docker-compose -f docker-compose.yml -f cast-iron/docker-compose.yml up -d
	make setup

restart: ## Restart all services and graph containers
	docker-compose -f docker-compose.yml -f cast-iron/docker-compose.yml restart

