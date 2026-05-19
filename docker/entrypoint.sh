#!/bin/sh
set -e

cd /var/www/html

if [ ! -d vendor ]; then
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

echo "Waiting for PostgreSQL..."

until php -r "
\$host = getenv('DB_HOST') ?: 'pgsql';
\$port = getenv('DB_PORT') ?: '5432';
\$db = getenv('DB_DATABASE') ?: 'app';
\$user = getenv('DB_USERNAME') ?: 'postgres';
\$pass = getenv('DB_PASSWORD') ?: '';
try {
    new PDO(\"pgsql:host={\$host};port={\$port};dbname={\$db}\", \$user, \$pass);
    exit(0);
} catch (Throwable \$e) {
    exit(1);
}
" 2>/dev/null; do
    sleep 1
done

php artisan config:clear --ansi
php artisan migrate --force

exec php artisan serve --host=0.0.0.0 --port=8000
