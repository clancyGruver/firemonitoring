migrate:		##Runs migrations
@php artisan migrate

up:##Runs docker
docker-compose up

php-cli:##Runs php-cli artisan migrate
	@docker exec -it app_php-cli_1

# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE