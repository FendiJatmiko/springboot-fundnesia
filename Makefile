APP_NAME ?= springboot
REPO ?= fendijatmiko

.PHONY: build 
build: 
	docker build -t ${REPO}/${APP_NAME} .

build-all:
	mvn clean install 
	docker-compose build

run: 
	docker-compose up
