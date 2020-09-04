APP_NAME ?= app
DC ?= docker-compose

build: up composer-install
up:
	$(DC) up -d --build

restart:
	$(DC) restart

down:
	$(DC) down -v --rmi local --remove-orphans

composer-install:
	$(DC) run --user=`id -u` $(APP_NAME) composer install -o

cli:
	$(DC) run $(APP_NAME) sh

cc:
	php bin/console c:c
	rm -fr var/cache/*