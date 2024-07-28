# Use Debian Buster as the base image
FROM debian:buster

# Update package list and install nginx and openssl
RUN apt-get update && apt-get install -y nginx openssl
RUN apt-get install -y curl

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=vsozonof.42.fr/UID=vsozonof"

RUN chmod 644 /etc/nginx/ssl/inception.key
RUN chmod 644 /etc/nginx/ssl/inception.crt

# Create directory for nginx runtime
RUN mkdir -p /var/run/nginx

# Copy the nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf

# Copy server conf file
COPY conf/default.conf /etc/nginx/conf.d/default.conf

COPY test.html /var/www/html

# Set permissions for the web directory
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copy the entrypoint script
# RUN chmod 777 srcs/nginx/conf/entrypoint.sh
COPY conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 777 /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]