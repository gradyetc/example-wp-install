#!/bin/bash

set -ev

echo "Importing smoke test install..."

mysql -u "$WORDPRESS_DB_USER" --password="$WORDPRESS_DB_PASS" -h "$WORDPRESS_DB_HOST" -P "$WORDPRESS_DB_PORT" "$WORDPRESS_DB_NAME" < ./test/db/wordpress.sql

