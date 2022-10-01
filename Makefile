.PHONY: build clean migrate redis-cli run secret shell stop up

help:
	@echo "  build      Builds the docker images for the docker-compose setup"
	@echo "  clean      Stops and removes all docker containers"
	@echo "  shell      Opens a Bash shell"
	@echo "  redis-cli  Opens a Redis CLI"
	@echo "  run        Run a airflow command"
	@echo "  stop       Stops the docker containers"
	@echo "  up         Runs the whole stack, served under http://localhost:8000/"

build:
	docker-compose build

clean:	stop
	docker-compose rm -f
	rm -rf logs/*
	if [ -f airflow-worker.pid ]; then rm airflow-worker.pid; fi

shell:
	docker-compose run web bash

redis-cli:
	docker-compose run redis redis-cli -h redis

run:
	docker-compose run -v ~/.aws/:/root/.aws web airflow $(COMMAND)

stop:
	docker-compose down
	docker-compose stop

up:
	docker-compose up