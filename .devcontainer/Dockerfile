ARG VARIANT=7.4-apache-4
FROM devwithlando/php:${VARIANT}

# Set Apache to load our site
ENV APACHE_DOCUMENT_ROOT /workspace/web
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Never run out of memory...unless you use more than the container has available!
Run echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/ext-memory-limits.ini

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt install nodejs -y \
  && npm install --global gulp-cli

# Install Terminus
RUN mkdir -p /opt/terminus && cd /opt/terminus \
  && curl -L https://github.com/pantheon-systems/terminus/releases/download/3.0.6/terminus.phar --output terminus \
  && chmod +x terminus \
  && ./terminus self:update \
  && ln -s /opt/terminus/terminus /usr/local/bin/terminus

# Install Global Drush
RUN mkdir -p /opt/drush && cd /opt/drush \
  && curl -OL https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar \
  && chmod +x drush.phar \
  && ln -s /opt/drush/drush.phar /usr/local/bin/drush
