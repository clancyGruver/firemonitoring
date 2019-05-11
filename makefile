migrate:		##Runs migrations
@php artisan migrate

up:##Runs docker
docker-compose up

php-cli:##Runs php-cli artisan migrate
	@docker exec -it app_php-cli_1