FROM debian:buster

# Install necessary packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget php7.3 php-fpm php-mysql mariadb-client

# Create necessary directories
RUN mkdir -p /run/php

# Download and extract WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN tar -xvf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www/
RUN chown -R www-data:www-data /var/www/wordpress
RUN chmod -R 755 /var/www/wordpress

# Download and set up WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp-cli.phar
RUN chmod 777 /usr/local/bin/wp-cli.phar

# Copy the auto_config.sh script
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod 644 /etc/php/7.3/fpm/pool.d/www.conf

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

# Default command
CMD ["php-fpm7.3", "-F"]

