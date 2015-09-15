#!/bin/bash

set -ev

echo "Importing smoke test install..."

echo "DB User: $WORDPRESS_DB_USER"
echo "DB Password: $WORDPRESS_DB_PASS"
echo "DB Host: $WORDPRESS_DB_HOST"
echo "DB Name: $WORDPRESS_DB_NAME"

curl -v http://localhost
curl -v http://example.com

mysql -u "$WORDPRESS_DB_USER" --password="$WORDPRESS_DB_PASS" -h "$WORDPRESS_DB_HOST" -P "$WORDPRESS_DB_PORT" "$WORDPRESS_DB_NAME" < ./test/db/wordpress.sql

