FROM kouinkouin/php-cli:7.2

RUN apt-get update \
  && apt-get install -y mysql-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

