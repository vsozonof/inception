#!/bin/bash

# Ensure the directory for the Unix socket exists
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

echo "Starting MariaDB server..."
# Start MariaDB server
mysqld_safe &

# Wait for MariaDB to start
until mysqladmin ping --silent; do
    echo 'Waiting for mysqld to be connectable...'
    sleep 2
done

echo "Environment variables are set:"
echo "SQL_DATABASE: $SQL_DATABASE"
echo "SQL_USER: $SQL_USER"
echo "SQL_PASSWORD: $SQL_PASSWORD"
echo "SQL_ROOT_PASSWORD: $SQL_ROOT_PASSWORD"

# Check if environment variables are set
if [ -z "$SQL_DATABASE" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_PASSWORD" ] || [ -z "$SQL_ROOT_PASSWORD" ]; then
  echo "One or more required environment variables are not set."
  exit 1
fi


echo "Running initial MariaDB setup..."
# Run the SQL commands with root access
mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
  CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
  CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
  GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "Pausing to ensure all operations are completed..."
sleep 5

echo "Stopping MariaDB server..."
# Shutdown MariaDB server
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

echo "Starting MariaDB server..."
# Start MariaDB server
exec mysqld_safe