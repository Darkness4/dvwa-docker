FROM php:7.4.27-apache

LABEL maintainer "nguyen_marc@live.fr"

ENV DEBIAN_FRONTEND=noninteractive
ENV DVWA_VERSION=2.0.1

# Open up some security holes in PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i -e's/allow_url_include[[:space:]]=[[:space:]]*off/allow_url_include = On/I' "$PHP_INI_DIR/php.ini"

RUN apt update \
    && apt install -y git zlib1g-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev \
    && rm -rf /var/www/html/{*,.*} \
    && git clone -b ${DVWA_VERSION} --depth 1 https://github.com/digininja/DVWA.git /var/www/html \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql \
    && apt install -y zlib1g libpng16-16 libfreetype6 libjpeg62-turbo libpng-tools iputils-ping \
    && apt remove -y git zlib1g-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev \
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN chmod -R 777 /var/www/html/hackable/uploads/ \
    && chown -R www-data:www-data /var/www/html/hackable/uploads/ \
    && chmod 655 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt \
    && chown www-data:www-data /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENV WAIT_VERSION 2.9.0
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

VOLUME [ "/config" ]

ENTRYPOINT [ "/tini", "--" ]
CMD [ "/entrypoint.sh" ]
