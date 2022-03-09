#!/bin/sh
echo "MySql username?"
read username
mkdir api-auth-keys
openssl genrsa -out api-auth-keys/private.pem 2048
openssl rsa -in api-auth-keys/private.pem -outform PEM -pubout -out api-auth-keys/public.pem
echo "Enter MySql password?"
read password
mysql -u $username -p -e "CREATE DATABASE sts CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE DATABASE service CHARACTER SET utf8 COLLATE utf8_general_ci;";
for d in */ ; do(
      cd "$d" && composer update --no-scripts && cp .env.example .env && sed -i 's/DB_HOST=mysql/DB_HOST=localhost/g' .env && sed -i "s/DB_USERNAME=root/DB_USERNAME=$username/g" .env && sed -i "s/DB_PASSWORD=password/DB_PASSWORD=$password/g" .env && php artisan key:generate && php artisan migrate
)done
