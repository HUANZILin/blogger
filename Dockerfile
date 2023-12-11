FROM webdevops/php-nginx-dev:8.1

WORKDIR /app

ENV WEB_DOCUMENT_ROOT=/app/public \
    PHP_MEMORY_LIMIT=512M \
    PHP_MAX_EXECUTION_TIME=30 \
    PHP_POST_MAX_SIZE=20M \
    PHP_UPLOAD_MAX_FILESIZE=20M

COPY ./app /app
COPY ./app/.env /app/.env