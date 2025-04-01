#!/bin/bash

echo "listen = 9000" >> /etc/php/7.3/fpm/pool.d/www.conf
echo "clear_env = no" >> /etc/php/7.3/fpm/pool.d/www.conf

echo "Waiting for MariaDB to be ready..."
until mysql -hmariadb -u$SQL_USER -p$SQL_PASSWORD -e "SHOW DATABASES;" > /dev/null 2>&1; do
    echo "MariaDB is not ready yet..."
    sleep 15
done
echo "MariaDB is ready!"

echo "Creating  the WP config!"
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp-cli.phar config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

echo "Creating the WP core and $WP_USER user!"
if ! wp-cli.phar core is-installed --allow-root --path='/var/www/wordpress'; then
	wp-cli.phar core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASSWORD" --admin_email="$WP_EMAIL" --path='/var/www/wordpress' --allow-root
fi

echo "Creating user with login: $WP_USER2, email: $WP_EMAIL2"
if ! wp-cli.phar user get $WP_USER2 --allow-root --path='/var/www/wordpress'; then
    wp-cli.phar user create $WP_USER2 $WP_EMAIL2 --user_pass=$WP_PASSWORD2 --role=administrator --path='/var/www/wordpress' --allow-root
fi

exec php-fpm7.3 -F
