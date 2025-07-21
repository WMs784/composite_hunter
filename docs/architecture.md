# 合成数ハンター システム設計書（実装版）

## 1. アプリ全体構成図

### 1.1 アーキテクチャ概要
```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │  Inventory  │  │   Stage     │     │
│  │   Screen    │  │   Screen    │  │ Selection   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Setup     │  │Stage Clear  │  │   Timer     │     │
│  │   Screen    │  │   Screen    │  │  Widget     │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                     State Management                    │
│             (Riverpod Providers & Notifiers)            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │  Inventory  │  │    Stage    │     │
│  │  Provider   │  │  Provider   │  │  Provider   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Setup     │  │   Timer     │  │BattleSession│     │
│  │  Provider   │  │  Provider   │  │ Provider    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                    Business Logic Layer                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │Enemy & Prime│  │   Stage     │     │
│  │   Engine    │  │  Entities   │  │ Entities    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │Math Utils & │  │    Logger   │  │   Timer     │     │
│  │Prime Logic  │  │   Service   │  │ Management  │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │SharedPrefs  │  │  Freezed    │  │ Generated   │     │
│  │(Inventory)  │  │  Entities   │  │ Code Files  │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

### 1.2 報酬システムデータフロー（実装版）
```
Stage Mode Battle Flow:
Stage Selection → Item Selection → Battle Session → Stage Clear
      ↓              ↓              ↓               ↓
   Stage Info → Battle Inventory → Temp Rewards → Reward Finalization
      ↓              ↓              ↓               ↓
   Slot Limit → Original Backup → Enemy Defeats → Main Inventory Update
                      ↓              ↓               ↓
                 Restoration → Reward Collection → UI Display
                 (on failure)   (during battle)   (on success)
```

## 2. 実装されている状態管理システム

### 2.1 主要プロバイダー

#### 現在実装されている StateNotifier プロバイダー
```dart
// 1. メインインベントリ管理 - List<Item>
final inventoryProvider = StateNotifierProvider<InventoryNotifier, List<Item>>(
  (ref) => InventoryNotifier(),
);

// 2. バトルセッション管理 - BattleSessionState
final battleSessionProvider = StateNotifierProvider<BattleSessionNotifier, BattleSessionState>(
  (ref) => BattleSessionNotifier(),
);

// 3. ステージ情報管理 - List<Stage>  
final stageProvider = StateNotifierProvider<StageNotifier, List<Stage>>(
  (ref) => StageNotifier(),
);

// 4. アイテム選択管理 - SetupState
final setupProvider = StateNotifierProvider<SetupNotifier, SetupState>(
  (ref) => SetupNotifier(),
);

// 5. バトル状態管理 - BattleState
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>(
  (ref) => BattleNotifier(),
);

// 6. タイマー管理 - TimerState
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>(
  (ref) => TimerNotifier(),
);
```

### 2.2 重要な実装特徴

#### インベントリシステム
- **メインインベントリ**: 永続的な所持アイテム（SharedPreferencesで保存）
- **バトルインベントリ**: ステージ用の一時的なアイテム
- **originalMainInventory**: 復元用のバックアップ（失敗時に使用）

#### 報酬システム
- **一時報酬**: バトル中に敵を倒して獲得する報酬（BattleSessionState内で管理）
- **報酬確定**: ステージクリア時にメインインベントリに追加
- **復元処理**: ステージ失敗時は元のインベントリに戻す

#### データフロー
```
1. ステージ選択 → setupProvider.setStage()
2. アイテム選択 → setupProvider.addItem() / removeItem()
3. バトル開始 → battleSessionProvider.startBattle()
4. 敵撃破 → battleSessionProvider.addTempReward()
5. ステージクリア → inventoryProvider.addPrime() (報酬確定)
6. ステージ失敗 → inventoryProvider.restoreInventory()
```

## 3. エンティティ設計（実装版）

### 3.1 主要エンティティ

#### Item/Prime エンティティ
```dart
@freezed
class Item with _$Item {
  const factory Item({
    required int value,        // 素数値
    required int count,        // 所持数
    required DateTime firstObtained, // 初回取得日時
    @Default(0) int usageCount, // 使用回数
  }) = _Item;
}

typedef Prime = Item; // 後方互換性のため
```

#### Stage エンティティ
```dart
@freezed 
class StageClearResult with _$StageClearResult {
  const factory StageClearResult({
    required int stageNumber,
    required bool isCleared,
    required int victories,
    required List<int> defeatedEnemies,
    @Default([]) List<int> rewardItems, // 獲得した報酬
  }) = _StageClearResult;
}
```

#### BattleSessionState
```dart
@freezed
class BattleSessionState with _$BattleSessionState {
  const factory BattleSessionState({
    required bool isPracticeMode,
    required List<Prime>? originalMainInventory, // 復元用バックアップ
    required List<int> usedPrimesInCurrentBattle,
    required List<int> defeatedEnemies,
  }) = _BattleSessionState;
}
```

### 3.2 実際のディレクトリ構造
```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── timer_constants.dart
│   └── utils/
│       ├── logger.dart
│       └── math_utils.dart
├── domain/
│   ├── entities/
│   │   ├── prime.dart        # Item/Prime定義
│   │   ├── stage.dart        # ステージエンティティ
│   │   ├── enemy.dart        # 敵エンティティ
│   │   └── battle_loadout.dart
│   └── services/
│       └── battle_engine.dart # 戦闘ロジック
└── presentation/
    ├── providers/
    │   ├── inventory_provider.dart      # メインインベントリ
    │   ├── battle_session_provider.dart # バトルセッション
    │   ├── battle_temp_rewards_provider.dart # 一時報酬
    │   ├── stage_provider.dart
    │   ├── setup_provider.dart
    │   ├── battle_provider.dart
    │   └── timer_provider.dart
    └── screens/
        ├── battle/
        │   └── battle_screen.dart       # 戦闘画面
        ├── inventory/
        │   └── inventory_screen.dart    # インベントリ画面
        ├── stage/
        │   ├── stage_item_selection_screen.dart
        │   └── stage_clear_screen.dart  # クリア画面
        └── ...
```
## 4. 報酬システムの実装詳細

### 4.1 報酬追加の流れ

#### ステージモード
1. **敵を倒す** → `battleTempRewardsProvider`に一時報酬として追加
2. **ステージクリア** → 一時報酬をメインインベントリに確定
3. **originalMainInventory**をクリア → 復元処理を防ぐ

#### 練習モード
1. **敵を倒す** → 直接メインインベントリに追加（アイテム消費なし）

### 4.2 主要メソッド

#### InventoryProvider
```dart
void addPrime(int value) // メインインベントリに素数を追加
void restoreInventory(List<Prime> backup) // バックアップから復元
```

#### BattleSessionProvider
```dart
void addTempReward(int value) // 一時報酬に追加
void clearOriginalInventory() // 復元用バックアップをクリア
```

### 4.3 データ永続化
- **SharedPreferences**: メインインベントリの保存
- **メモリ**: 一時報酬とセッション状態

### 4.4 ソート機能
報酬追加後、すべてのインベントリは自動的に小さい順にソートされます。

---

**このドキュメントは現在の実装を反映するように更新されました。**