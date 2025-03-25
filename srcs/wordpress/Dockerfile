FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget php7.3 php-fpm php-mysql mariadb-client
RUN mkdir -p /run/php
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN tar -xvf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www/
RUN chown -R www-data:www-data /var/www/wordpress
RUN chmod -R 755 /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp-cli.phar
RUN chmod 777 /usr/local/bin/wp-cli.phar

COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod 644 /etc/php/7.3/fpm/pool.d/www.conf

CMD ["/usr/local/bin/auto_config.sh"]

