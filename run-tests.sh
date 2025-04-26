#!/usr/bin/env bash
set -euo pipefail

echo "🟢 バックエンド＆DB を起動…"
docker compose up -d backend db

echo "🛠️  バックエンド依存をインストール…"
docker compose exec backend composer install --no-interaction --prefer-dist

echo "🧪  Laravel テスト実行…"
docker compose exec backend php artisan test --no-ansi

echo "✅  フロント用コンテナを一時ビルド & Lint…"
docker compose build frontend
docker compose run --rm frontend sh -lc "npm ci && npm run lint"

echo "🎉  全テスト＆Lint が成功しました！"