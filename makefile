DOCKER_IMAGE_NAME = quant-stack
DOCKER_CONTAINER_NAME = quant-container
JUPYTER_PASSWORD ?= password

build:
	@echo "Building Docker image $(DOCKER_IMAGE_NAME)..."
	docker build -t $(DOCKER_IMAGE_NAME) .

run:
	@echo "Launching container $(DOCKER_CONTAINER_NAME)..."
	@HASHED_PASSWORD=$$(docker run --rm $(DOCKER_IMAGE_NAME) python -c "from jupyter_server.auth import passwd; print(passwd('$(JUPYTER_PASSWORD)'))") && \
	docker run -d --name $(DOCKER_CONTAINER_NAME) -p 8888:8888 -e JUPYTER_PASSWORD="$$HASHED_PASSWORD" $(DOCKER_IMAGE_NAME)

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