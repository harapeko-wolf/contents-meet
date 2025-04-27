#!/usr/bin/env bash
set -euo pipefail

echo "🟢 バックエンド＆DB を起動…"
docker compose up -d backend db

echo "🧪  .env 作成 → APP_KEY 生成 → マイグレーション…"
docker compose exec backend bash -lc "\
  cp .env.example .env && \
  php artisan key:generate && \
  php artisan migrate --force \
"

echo "🛠️  バックエンド依存をインストール…"
docker compose exec backend composer install --no-interaction --prefer-dist

echo "✅  Laravel テスト実行…"
docker compose exec backend php artisan test --no-ansi

echo "✅  フロント用一時コンテナでビルド & Lint…"
docker compose build frontend
docker compose run --rm frontend sh -lc "npm ci && npm run lint"

echo "🎉  全テスト＆Lint が成功しました！!"