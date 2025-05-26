FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl
RUN apt-get install -y curl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=vsozonof.42.fr/UID=vsozonof"

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/wordpress && \
    chmod 755 /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]