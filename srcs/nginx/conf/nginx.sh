#!/bin/bash
echo "127.0.0.1 vsozonof.42.fr" >> /etc/hosts
exec nginx -g "daemon off;"