FROM mediawiki:1.35

RUN apt-get update; \
    apt-get install --assume-yes --no-install-recommends libpq-dev; \
    docker-php-ext-install pgsql
