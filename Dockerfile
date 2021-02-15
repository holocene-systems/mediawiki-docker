FROM mediawiki:1.35.1

RUN apt-get update; \
    apt-get install --assume-yes --no-install-recommends libpq-dev; \
    docker-php-ext-install pgsql

VOLUME /var/www/html/overlay

RUN ln -s /var/www/html/overlay/LocalSettings.php \
          /var/www/html
