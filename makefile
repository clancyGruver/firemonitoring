migrate:		##Runs migrations
@php artisan migrate

up:##Runs docker
docker-compose up

php-cli:##Runs php-cli artisan migrate
	@docker exec -it app_php-cli_1

# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql
docker exec app_db_1 /usr/bin/mysqldump -u root --password=secret app > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE
cat firemonitoring.sql | docker exec -i app_db_1 /usr/bin/mysql -u root --password=secret app

# delete symlinks
sudo find -type l -delete

# git update
git pull origin master

# git upload
git push origin master

#allow permissions to log
sudo chmod 0777 ./storage -R