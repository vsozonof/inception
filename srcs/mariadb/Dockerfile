FROM debian:buster

RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# Create the directory for the Unix socket
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld


CMD ["/bin/bash", "/usr/local/bin/auto_config.sh"]