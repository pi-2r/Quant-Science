DOCKER_IMAGE_NAME = quant-stack
DOCKER_CONTAINER_NAME = quant-container
JUPYTER_PASSWORD ?= password
NOTEBOOK_DIR ?= $(PWD)/notebook
ARCH := $(shell uname -m)

# get value of GITHUB_TOKEN and PRIVATE_REPO from .env file
ifneq (,$(wildcard .env))
    include .env
    export
endif


build:
ifeq ($(ARCH),arm64)
	#Mac M2 (ARM)
	docker buildx build --platform linux/amd64 -t $(DOCKER_IMAGE_NAME) --build-arg GITHUB_TOKEN=$(GITHUB_TOKEN)  --build-arg PRIVATE_REPO=$(PRIVATE_REPO) .
else
	#Mac Intel (x86_64)
	docker build -t $(DOCKER_IMAGE_NAME) --build-arg GITHUB_TOKEN=$(GITHUB_TOKEN)  --build-arg PRIVATE_REPO=$(PRIVATE_REPO) .
endif

run:
	@echo "Launching container $(DOCKER_CONTAINER_NAME)..."
	@HASHED_PASSWORD=$$(docker run --rm $(DOCKER_IMAGE_NAME) python -c "from jupyter_server.auth import passwd; print(passwd('$(JUPYTER_PASSWORD)'))") && \
	docker run -d --name $(DOCKER_CONTAINER_NAME) -p 8889:8888 -v $(NOTEBOOK_DIR):/app/ -e JUPYTER_PASSWORD="$$HASHED_PASSWORD" $(DOCKER_IMAGE_NAME)

stop:
	@echo "Stopping and removing container $(DOCKER_CONTAINER_NAME)..."
	docker stop $(DOCKER_CONTAINER_NAME)
	docker rm $(DOCKER_CONTAINER_NAME)

clean:
	@echo "Removing image $(DOCKER_IMAGE_NAME)..."
	docker rmi $(DOCKER_IMAGE_NAME)

logs:
	@echo "Displaying logs for container $(DOCKER_CONTAINER_NAME)..."
	docker logs $(DOCKER_CONTAINER_NAME)

shell:
	@echo "Opening a shell in container $(DOCKER_CONTAINER_NAME)..."
	docker exec -it $(DOCKER_CONTAINER_NAME) /bin/bash

help:
	@echo "Available commands:"
	@echo "  make build  : Build the Docker image"
	@echo "  make run    : Launch the container"
	@echo "  make stop   : Stop and remove the container"
	@echo "  make clean  : Remove the Docker image"
	@echo "  make logs   : Display container logs"
	@echo "  make shell  : Open a shell in the container"

.PHONY: build run stop clean logs shell help
