ARG PHP_VERSION=7.4

FROM kouinkouin/php-cli:$PHP_VERSION

RUN apt-get update \
  && apt-get install -y mariadb-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

ADD files/tools /srv/tools

RUN chmod +x /srv/tools/wp-*

