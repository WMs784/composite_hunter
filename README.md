# 合成数ハンター (Composite Hunter)

素因数分解を楽しく学べる教育ゲームアプリです。

## 📱 アプリについて

「合成数ハンター」は、素数を武器として合成数の敵と戦う戦略的バトルゲームです。プレイヤーは素因数分解を駆使して敵を倒し、数学的思考力を楽しみながら身に付けることができます。

### 🎯 主な特徴

- 📚 **教育的**: 素因数分解と素数の概念を実践的に学習
- 🎮 **ゲーム性**: 戦略的バトルシステムで楽しく学習
- 📈 **段階的学習**: レベルに応じた難易度調整
- 🏆 **実績システム**: 達成感を高める各種アチーブメント
- 🌐 **多言語対応**: 日本語・英語対応

### 📋 ゲームモード

- **練習モード**: 基本的な操作と概念を学習
- **ステージモード**: 4つの難易度レベルでスキルアップ
- **アチーブメント**: 様々な達成条件で長期的なモチベーション維持

## 🛠️ 技術仕様

### 開発環境
- **フレームワーク**: Flutter 3.32.0+
- **言語**: Dart
- **状態管理**: Riverpod
- **データベース**: SQLite (sqflite)
- **ローカライゼーション**: flutter_localizations

### アーキテクチャ
- **設計パターン**: Clean Architecture
- **レイヤー構造**: Presentation / Domain / Data
- **状態管理**: StateNotifier + Riverpod
- **データ永続化**: Repository Pattern

## 🚀 セットアップ

### 前提条件
- Flutter SDK 3.32.0 以上
- Dart SDK 3.8.0 以上
- Android Studio / VS Code
- iOS: Xcode 14.0+ (iOS開発の場合)

### インストール手順

```bash
# 1. リポジトリをクローン
git clone https://github.com/WMs784/composite_hunter.git
cd composite_hunter

# 2. 依存関係をインストール
flutter pub get

# 3. コード生成
dart run build_runner build

# 4. アプリを実行
flutter run
```

### 開発用コマンド

```bash
# コード解析
flutter analyze

# コードフォーマット
flutter format .

# テスト実行
flutter test

# APKビルド
flutter build apk

# iOSビルド (macOS環境)
flutter build ios
```

## 📁 プロジェクト構造

```
lib/
├── main.dart                 # アプリエントリーポイント
├── core/                     # 共有ユーティリティ
│   ├── constants/           # 定数定義
│   ├── exceptions/          # カスタム例外
│   ├── extensions/          # Dart拡張
│   └── utils/               # ユーティリティ関数
├── data/                    # データ層
│   ├── models/             # データモデル
│   ├── repositories/       # リポジトリ実装
│   └── datasources/        # データソース
├── domain/                  # ビジネスロジック層
│   ├── entities/           # エンティティ
│   ├── usecases/           # ユースケース
│   └── services/           # ドメインサービス
└── presentation/            # プレゼンテーション層
    ├── providers/          # 状態管理
    ├── screens/            # 画面ウィジェット
    ├── widgets/            # 再利用可能ウィジェット
    └── theme/              # テーマ設定
```

## 🎮 ゲームプレイ

### 基本ルール
1. 合成数の敵が出現します
2. 素数を選択して敵を攻撃します
3. 敵の値が素数になったら「素数宣言」で勝利
4. 制限時間内にできるだけ多くの敵を倒します

### 戦略のポイント
- 効率的な素因数分解を考える
- 限られた素数を賢く使用する
- 時間配分を意識した戦略

## 🏗️ 開発

### コーディング規約
- [Flutter Style Guide](https://docs.flutter.dev/development/tools/formatting)に準拠
- [Effective Dart](https://dart.dev/guides/language/effective-dart)を遵守
- コミット前に`flutter analyze`と`flutter test`を実行

### Git Hooks
プロジェクトには自動品質チェックが設定されています：

```bash
# Git Hooksを有効化
git config core.hooksPath .githooks
```

### コントリビューション
1. Issuesで議論してください
2. フィーチャーブランチを作成してください
3. テストを追加してください
4. Pull Requestを送信してください

## 📄 ドキュメント

### 公式ドキュメント
- [プライバシーポリシー](https://wms784.github.io/composite_hunter/privacy-policy.html)
- [利用規約](https://wms784.github.io/composite_hunter/terms-of-service.html)

### 設計ドキュメント
- [要件定義書](docs/requirements.md)
- [アーキテクチャ設計](docs/architecture.md)
- [詳細設計書](docs/detailed_class_design.md)
- [データベース設計](docs/database_design.md)

## 📱 動作環境

### Android
- Android API Level 21 (Android 5.0) 以上
- RAM: 2GB以上推奨
- ストレージ: 100MB以上の空き容量

### iOS
- iOS 11.0 以上
- iPhone 6以降 / iPad (第5世代) 以降
- ストレージ: 100MB以上の空き容量

## 🧪 テスト

### テスト構成
- **Unit Tests**: ビジネスロジックのテスト
- **Widget Tests**: UIコンポーネントのテスト
- **Integration Tests**: エンドツーエンドのテスト

### テスト実行
```bash
# 全テスト実行
flutter test

# 特定のテスト実行
flutter test test/unit/math_utils_test.dart

# カバレッジ取得
flutter test --coverage
```

## 📊 パフォーマンス

### 最適化項目
- メモリ使用量の最適化
- アニメーション性能
- データベースクエリの効率化
- アプリ起動時間の短縮

## 🔧 トラブルシューティング

### よくある問題

**1. ビルドエラーが発生する**
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**2. アイコンが表示されない**
```bash
flutter pub run flutter_launcher_icons
flutter clean
flutter run
```

**3. 多言語化が反映されない**
```bash
flutter gen-l10n
flutter run
```

## 📈 ロードマップ

### 近期予定
- [ ] オンライン対戦機能
- [ ] より多くの素数パズル
- [ ] 達成度分析機能

### 将来計画
- [ ] VR/AR対応
- [ ] 他の数学分野への拡張
- [ ] 教師向け管理機能

## 📄 ライセンス

このプロジェクトは MIT License の下で公開されています。詳細は [LICENSE](LICENSE) ファイルをご覧ください。

## 👥 貢献者

### 開発チーム
- **プロジェクトリード**: WMs784
- **技術アーキテクト**: WMs784
- **UI/UXデザイナー**: WMs784

### 謝辞
このプロジェクトは以下のオープンソースプロジェクトを利用しています：
- [Flutter](https://flutter.dev/)
- [Riverpod](https://riverpod.dev/)
- [sqflite](https://pub.dev/packages/sqflite)

## 📞 お問い合わせ

- **Issues**: [GitHub Issues](https://github.com/WMs784/composite_hunter/issues)
- **Discussions**: [GitHub Discussions](https://github.com/WMs784/composite_hunter/discussions)
- **Security**: セキュリティに関する問題は [SECURITY.md](SECURITY.md) をご覧ください

---

© 2025 Composite Hunter Development Team. All rights reserved.