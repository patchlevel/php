ARG VERSION
FROM php:$VERSION

ARG EXTENSIONS

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    curl \
 && rm -rf /var/lib/apt/lists/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions $EXTENSIONS
