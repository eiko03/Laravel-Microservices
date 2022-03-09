#!/bin/sh
mkdir api-auth-keys
openssl genrsa -out api-auth-keys/private.pem 2048
openssl rsa -in api-auth-keys/private.pem -outform PEM -pubout -out api-auth-keys/public.pem
for d in */ ; do(
    cd "$d" && composer update --no-scripts && cp .env.example .env && php artisan key:generate && php artisan migrate
)done
