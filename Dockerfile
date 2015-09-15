FROM wordpress:4.3

# PHP configuration
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > /usr/local/etc/php/conf.d/date_timezone.ini
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini
RUN echo "upload_max_filesize=32M" > /usr/local/etc/php/conf.d/upload-max-filesize.ini
RUN echo "post_max_size=64M" > /usr/local/etc/php/conf.d/post-max-size.ini

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy wp-content
COPY ./wp-content /var/www/html/wp-content

# Set correction permissions for Apache
RUN chown -R www-data:www-data /var/www/html/wp-content

