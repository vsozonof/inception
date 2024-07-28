#!/bin/bash


# Modify /etc/hosts
echo "127.0.0.1 vsozonof.42.fr" >> /etc/hosts

# Start Nginx
exec nginx -g "daemon off;"