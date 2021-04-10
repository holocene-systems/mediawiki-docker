FROM mediawiki:1.35.2

# Set up PHP with PostgreSQL support.
RUN set -o errexit -o nounset -o xtrace; \
    apt-get update; \
    apt-get install --assume-yes --no-install-recommends libpq-dev; \
    docker-php-ext-install pgsql; \
    rm --recursive /var/lib/apt/lists

# This volume stores images that are uploaded to MediaWiki.
# https://www.mediawiki.org/wiki/Manual:$wgEnableUploads
VOLUME /var/www/html/images

# AWS Fargate doesn't support persistent file bind mounts, which is why
# here we're creating an overlay volume that can host all files that will
# be symlinked into directories with other pre-existing files.
VOLUME /var/www/html/overlay

# LocalSettings.php file is generated during the initial setup process.
# https://www.mediawiki.org/wiki/Manual:LocalSettings.php
RUN ln -s /var/www/html/overlay/LocalSettings.php /var/www/html
