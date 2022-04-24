FROM composer AS build
ENV CACHE_DRIVER=file
WORKDIR /src
COPY . .
RUN composer install
RUN php artisan key:generate

FROM php:8-alpine
ENV CACHE_DRIVER=file
USER 1000
WORKDIR /app
COPY --from=build --chown=1000:1000 /src /app
CMD [ "php", "artisan", "serve", "--host", "0.0.0.0", "--port", "80"]