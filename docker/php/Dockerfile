# slim base
FROM php:8.2.9-fpm-bookworm
ENV DOCKER_BUILDKIT=1

ARG UID
ARG GID
ARG USERNAME=www-data
ARG GROUPNAME=${USERNAME}

# RUN groupadd -g ${GID} ${GROUPNAME} && useradd -s /sbin/nologin -g ${GROUPNAME} -u ${UID} ${USERNAME}
RUN groupmod -g ${GID} ${GROUPNAME} && usermod -u ${UID} ${USERNAME}

# php-fpmのroot設定を移動する
# RUN mkdir -p /usr/local/etc/php-fpm.d/bk \
#     && mv /usr/local/etc/php-fpm.d/*.conf /usr/local/etc/php-fpm.d/bk/

RUN apt-get update -qq && \
    apt-get install -y zlib1g-dev libzip-dev && \
    docker-php-ext-install pdo_mysql opcache zip && \
    # パッケージキャッシュの削除
    apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get autoremove && \
    pecl install redis && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable redis.so

COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

# USER web
WORKDIR /var/www/html

# ENTRYPOINT ["docker-entrypoint.sh"]