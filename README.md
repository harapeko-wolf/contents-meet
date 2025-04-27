# MAツール「Contents Meet」

「Contents Meet」は、ユーザーが視聴した動画やPDFの閲覧量に応じてスコアを計算し、営業のオンライン商談予約や管理画面を提供するMA（マーケティングオートメーション）ツールです。

## 目次
1. [プロジェクト概要](#プロジェクト概要)
2. [フォルダ構成](#フォルダ構成)
3. [前提条件](#前提条件)
4. [ローカル開発環境のセットアップ](#ローカル開発環境のセットアップ)
5. [実行方法](#実行方法)
6. [テスト](#テスト)
7. [CI/CD](#cicd)
8. [開発フロー](#開発フロー)
9. [ドキュメント](#ドキュメント)
10. [ライセンス](#ライセンス)

## プロジェクト概要
- **バックエンド**: Laravel 12 + PHP 8.4
- **フロントエンド**: Next.js 15 + TypeScript
- **インフラ**: Docker Compose, AWS (Terraform + Ansible)
- **監視/運用**: Sentry

主要機能:
- コンテンツ（動画/PDF）の視聴/閲覧トラッキング
- スコアリングロジックによるスコア算出
- ユーザー向けダッシュボード（視聴画面 + スコア表示）
- 管理画面（スコア一覧、オンライン商談予約機能）
- GitHub ActionsによるCI/CDパイプライン

## フォルダ構成
```text
/
├── backend/           # Laravelアプリケーション
├── frontend/          # Next.jsアプリケーション
├── docker/            # Dockerfile, nginx, MySQL設定
├── .github/           # GitHub Actionsワークフロー
├── docs/              # ドキュメント（後続フェーズで執筆）
│   ├── architecture.md   # アーキテクチャ図（後日作成）
│   ├── api/              # OpenAPI spec（後日追加）
│   └── adr/              # 設計決定記録（後日記録）
├── run-tests.sh       # ローカル一括テスト・Lintスクリプト
└── README.md          # このファイル
```

## 前提条件
- MacOS (Docker Desktopインストール済)
- Docker / Docker Compose
- Git
- Node.js (v21 推奨) / npm
  - **Docker コンテナ実行**: `docker compose up frontend` で Next.js が動作するため、ホストに Node.js をインストールする必要はありません。
  - **ローカル開発（ホストマシン上で直接実行する場合）**: コンテナを使わずに `npm run dev` などを実行する際にのみ、ホストマシンに Node.js と npm が必要です。

# テスト
