up:
	docker compose -f docker-compose-dev.yml --env-file ./.env.development up -d redis postgres mailhog
	yarn install-local-ssl
	yarn install --pure-lockfile
	yarn dev:watch

build:
	docker compose build --pull outline

test:
	docker compose -f docker-compose-dev.yml --env-file ./.env.development up -d redis postgres mailhog
	NODE_ENV=test yarn sequelize db:drop
	NODE_ENV=test yarn sequelize db:create
	NODE_ENV=test yarn sequelize db:migrate
	yarn test

watch:
	docker compose -f docker-compose-dev.yml up -d redis postgres mailhog
	NODE_ENV=test yarn sequelize db:drop
	NODE_ENV=test yarn sequelize db:create
	NODE_ENV=test yarn sequelize db:migrate
	yarn test:watch

destroy:
	docker compose  -f docker-compose-dev.yml stop
	docker compose rm -f docker-compose-dev.yml

.PHONY: up build destroy test watch # let's go to reserve rules names
