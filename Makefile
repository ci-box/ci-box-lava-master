build:
	docker-compose build

run:
	docker-compose up

start:
	docker-compose up -d

stop:
	docker-compose stop

status:
	docker-compose ps

restart:
	docker-compose stop
	docker-compose up -d

clean:
	docker-compose down

.PHONY: run start stop status restart clean
