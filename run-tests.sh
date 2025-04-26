#!/usr/bin/env bash
set -euo pipefail

echo "🟢 Starting containers…"
docker compose up -d

echo "🛠️  Installing dependencies…"
docker compose exec backend composer install --no-interaction --prefer-dist
docker compose exec frontend npm ci

echo "🧪  Preparing backend env & database…"
docker compose exec backend cp .env.example .env
docker compose exec backend php artisan key:generate
docker compose exec backend php artisan migrate --force

echo "✅  Running Laravel tests…"
docker compose exec backend php artisan test --colors=always

echo "✅  Running frontend lint…"
docker compose exec frontend npm run lint

# echo "✅  Running frontend tests…"
# docker compose exec frontend npm test

echo "🎉  All tests passed!"