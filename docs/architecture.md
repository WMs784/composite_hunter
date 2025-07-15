# 合成数ハンター システム設計書（修正版v4）

## 1. アプリ全体構成図

### 1.1 アーキテクチャ概要
```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │  Inventory  │  │ Achievement │     │
│  │   Screen    │  │   Screen    │  │   Screen    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Stage     │  │   Setup     │  │   Timer     │     │
│  │ Selection   │  │   Screen    │  │  Widget     │     │
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
│  │   Setup     │  │   Timer     │  │ Reward      │     │
│  │  Provider   │  │  Provider   │  │ Provider    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                    Business Logic Layer                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │  Inventory  │  │   Stage     │     │
│  │   Engine    │  │  Manager    │  │  Manager    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Setup     │  │   Timer     │  │  Reward     │     │
│  │  Manager    │  │  Manager    │  │ Manager     │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │  Local DB   │  │ Preferences │  │   Models    │     │
│  │  (SQLite)   │  │(SharedPrefs)│  │   (DTOs)    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

### 1.2 データフロー図（修正版）
```
Stage Selection → Setup Screen → Battle → Stage Complete/Failure
      ↓              ↓            ↓           ↓
   Stage Info → Item Selection → Combat → Result Processing
      ↓              ↓            ↓           ↓
   Slot Limit → Battle Loadout → Item Use → Inventory Update
                                    ↓           ↓
                              Temp Rewards → Success: Add to Inventory
                                             Failure: Discard Rewards
```

## 2. 状態管理戦略（修正版）

### 2.1 Riverpod実装戦略（修正版）

#### 状態管理パターン（修正版）
```dart
// 1. インベントリ状態 - StateNotifierProvider（永続的な所持アイテム）
final inventoryProvider = StateNotifierProvider<InventoryNotifier, InventoryState>(
  (ref) => InventoryNotifier(ref),
);

// 2. ステージ状態 - StateNotifierProvider  
final stageProvider = StateNotifierProvider<StageNotifier, StageState>(
  (ref) => StageNotifier(ref),
);

// 3. アイテム選択状態 - StateNotifierProvider
final setupProvider = StateNotifierProvider<SetupNotifier, SetupState>(
  (ref) => SetupNotifier(ref),
);

// 4. 戦闘状態 - StateNotifierProvider（バトル用アイテム消費管理）
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>(
  (ref) => BattleNotifier(ref),
);

// 5. 仮報酬管理 - StateNotifierProvider（ステージクリア前の一時的な報酬）
final tempRewardProvider = StateNotifierProvider<TempRewardNotifier, TempRewardState>(
  (ref) => TempRewardNotifier(ref),
);

// 6. バトル用アイテム追加可能チェック - Provider (computed)
final canAddToBattleLoadoutProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  final stage = ref.watch(stageProvider);
  return setup.selectedItems.length < stage.currentStage.slotLimit;
});

// 7. 戦闘開始可能チェック - Provider (computed)
final canStartBattleProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  return setup.selectedItems.isNotEmpty;
});

// 8. アイテム使用可能チェック - Provider (computed)
final canUseItemProvider = Provider.family<bool, int>((ref, itemValue) {
  final battle = ref.watch(battleProvider);
  return battle.battleItems.any((item) => item.value == itemValue && item.count > 0);
});
```

#### プロバイダー階層（修正版）
```
App Level Providers:
├── gameDataProvider (永続化データ)
├── settingsProvider (アプリ設定)
├── achievementProvider (実績管理)
└── globalTimerProvider (アプリ全体タイマー)

Game Flow Providers:
├── stageProvider (ステージ管理・スロット制限)
├── inventoryProvider (永続的なアイテム管理)
├── setupProvider (アイテム選択管理)
├── battleProvider (戦闘状態・バトル用アイテム消費)
└── tempRewardProvider (仮報酬管理)

Battle Specific Providers:
├── timerProvider (制限時間管理)
├── victoryValidationProvider (勝利判定)
├── enemyProvider (敵生成・累乗敵含む)
└── primeAttackValidationProvider (素数攻撃判定)

UI Level Providers:
├── animationProvider (アニメーション状態)
├── penaltyDisplayProvider (ペナルティ表示)
└── uiStateProvider (UI表示状態)
```

## 3. ディレクトリ構造（修正版）

### 3.1 全体構造（修正版）
```
lib/
├── main.dart
├── app.dart
│
├── core/                     # 共通機能
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── game_constants.dart
│   │   ├── stage_constants.dart
│   │   ├── timer_constants.dart
│   │   ├── reward_constants.dart    # 新規：報酬関連定数
│   │   └── ui_constants.dart
│   ├── exceptions/
│   │   ├── game_exception.dart
│   │   ├── setup_exception.dart
│   │   ├── stage_exception.dart
│   │   ├── timer_exception.dart
│   │   ├── victory_exception.dart
│   │   ├── item_exception.dart      # 新規：アイテム使用例外
│   │   ├── reward_exception.dart    # 新規：報酬管理例外
│   │   └── data_exception.dart
│   ├── extensions/
│   │   ├── int_extensions.dart
│   │   ├── list_extensions.dart
│   │   ├── prime_extensions.dart
│   │   ├── item_extensions.dart     # 新規：アイテム関連拡張
│   │   └── duration_extensions.dart
│   ├── utils/
│   │   ├── math_utils.dart
│   │   ├── setup_utils.dart
│   │   ├── stage_utils.dart
│   │   ├── timer_utils.dart
│   │   ├── validation_utils.dart
│   │   ├── item_consumption_utils.dart # 新規：アイテム消費ユーティリティ
│   │   ├── reward_utils.dart        # 新規：報酬管理ユーティリティ
│   │   └── logger.dart
│   └── di/
│       └── injection.dart
│
├── data/                     # データレイヤー
│   ├── models/
│   │   ├── item_model.dart          # 更新：prime_model.dartから改名
│   │   ├── enemy_model.dart
│   │   ├── power_enemy_model.dart
│   │   ├── stage_model.dart
│   │   ├── battle_loadout_model.dart
│   │   ├── battle_result_model.dart
│   │   ├── temp_reward_model.dart   # 新規：仮報酬モデル
│   │   ├── timer_state_model.dart
│   │   ├── penalty_record_model.dart
│   │   └── game_data_model.dart
│   ├── repositories/
│   │   ├── game_repository.dart
│   │   ├── inventory_repository.dart
│   │   ├── stage_repository.dart
│   │   ├── setup_repository.dart
│   │   ├── battle_repository.dart
│   │   ├── timer_repository.dart
│   │   ├── reward_repository.dart   # 新規：報酬管理リポジトリ
│   │   └── achievement_repository.dart
│   ├── datasources/
│   │   ├── local_database.dart
│   │   ├── shared_preferences_service.dart
│   │   └── file_storage_service.dart
│   └── mappers/
│       ├── item_mapper.dart         # 更新：prime_mapper.dartから改名
│       ├── enemy_mapper.dart
│       ├── stage_mapper.dart
│       ├── setup_mapper.dart
│       ├── battle_mapper.dart
│       ├── reward_mapper.dart       # 新規：報酬マッパー
│       └── timer_mapper.dart
│
├── domain/                   # ビジネスロジック層
│   ├── entities/
│   │   ├── item.dart                # 更新：prime.dartから改名
│   │   ├── enemy.dart
│   │   ├── power_enemy.dart
│   │   ├── stage.dart
│   │   ├── battle_loadout.dart      # 更新：アイテム消費管理
│   │   ├── battle_state.dart        # 更新：バトル用アイテム管理
│   │   ├── temp_reward.dart         # 新規：仮報酬エンティティ
│   │   ├── timer_state.dart
│   │   ├── penalty_state.dart
│   │   ├── victory_claim.dart
│   │   └── inventory.dart           # 更新：永続的アイテム管理
│   ├── usecases/
│   │   ├── battle_usecase.dart      # 更新：アイテム消費ロジック
│   │   ├── inventory_usecase.dart   # 更新：永続的管理
│   │   ├── stage_usecase.dart
│   │   ├── setup_usecase.dart       # 更新：アイテム選択管理
│   │   ├── enemy_generation_usecase.dart
│   │   ├── timer_management_usecase.dart
│   │   ├── victory_validation_usecase.dart
│   │   ├── item_consumption_usecase.dart # 新規：アイテム消費管理
│   │   ├── reward_management_usecase.dart # 新規：報酬管理
│   │   └── penalty_calculation_usecase.dart
│   ├── repositories/
│   │   └── game_repository_interface.dart
│   └── services/
│       ├── battle_engine.dart       # 更新：アイテム消費システム
│       ├── setup_manager.dart       # 更新：アイテム選択管理
│       ├── stage_manager.dart
│       ├── item_consumption_manager.dart # 新規：アイテム消費管理
│       ├── reward_manager.dart      # 新規：報酬管理サービス
│       ├── prime_calculator.dart
│       ├── enemy_generator.dart
│       ├── power_enemy_detector.dart
│       ├── timer_manager.dart
│       ├── victory_validator.dart
│       └── penalty_calculator.dart
│
├── presentation/             # プレゼンテーション層
│   ├── providers/
│   │   ├── battle_provider.dart     # 更新：バトル用アイテム消費管理
│   │   ├── inventory_provider.dart  # 更新：永続的管理
│   │   ├── stage_provider.dart
│   │   ├── setup_provider.dart      # 更新：アイテム選択
│   │   ├── enemy_provider.dart
│   │   ├── timer_provider.dart
│   │   ├── victory_provider.dart
│   │   ├── penalty_provider.dart
│   │   ├── temp_reward_provider.dart # 新規：仮報酬管理
│   │   ├── game_provider.dart
│   │   └── ui_state_provider.dart
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── tutorial/
│   │   │   ├── tutorial_screen.dart
│   │   │   └── widgets/
│   │   │       ├── timer_tutorial_widget.dart
│   │   │       ├── setup_tutorial_widget.dart
│   │   │       ├── consumption_tutorial_widget.dart # 新規：消費システム説明
│   │   │       └── victory_tutorial_widget.dart
│   │   ├── stage/
│   │   │   ├── stage_selection_screen.dart
│   │   │   └── widgets/
│   │   │       ├── stage_card_widget.dart
│   │   │       └── stage_info_widget.dart
│   │   ├── setup/
│   │   │   ├── setup_screen.dart
│   │   │   └── widgets/
│   │   │       ├── item_selector_widget.dart # 更新：prime_selector_widgetから改名
│   │   │       ├── loadout_display_widget.dart
│   │   │       ├── slot_limit_widget.dart
│   │   │       └── start_battle_button.dart
│   │   ├── battle/
│   │   │   ├── battle_screen.dart   # 更新：バトル用アイテム表示
│   │   │   └── widgets/
│   │   │       ├── enemy_widget.dart
│   │   │       ├── power_enemy_widget.dart
│   │   │       ├── battle_items_grid_widget.dart # 更新：消費型アイテムグリッド
│   │   │       ├── timer_widget.dart
│   │   │       ├── victory_claim_button.dart
│   │   │       ├── temp_rewards_widget.dart # 新規：仮報酬表示
│   │   │       ├── action_buttons_widget.dart
│   │   │       └── battle_animation_widget.dart
│   │   ├── inventory/
│   │   │   ├── inventory_screen.dart # 更新：全アイテム表示（永続的）
│   │   │   └── widgets/
│   │   │       ├── item_list_widget.dart # 更新：prime_list_widgetから改名
│   │   │       └── item_detail_widget.dart # 更新：prime_detail_widgetから改名
│   │   └── achievement/
│   │       ├── achievement_screen.dart
│   │       └── widgets/
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── custom_button.dart
│   │   │   ├── timer_display.dart
│   │   │   ├── penalty_indicator.dart
│   │   │   ├── slot_indicator.dart
│   │   │   ├── consumption_indicator.dart # 新規：消費状況表示
│   │   │   ├── temp_reward_indicator.dart # 新規：仮報酬表示
│   │   │   ├── loading_widget.dart
│   │   │   └── error_widget.dart
│   │   ├── animations/
│   │   │   ├── number_change_animation.dart
│   │   │   ├── attack_effect_animation.dart
│   │   │   ├── victory_animation.dart
│   │   │   ├── penalty_animation.dart
│   │   │   ├── item_consumption_animation.dart # 新規：アイテム消費アニメーション
│   │   │   ├── reward_gain_animation.dart # 新規：報酬獲得アニメーション
│   │   │   └── power_enemy_animation.dart
│   │   └── dialogs/
│   │       ├── battle_result_dialog.dart
│   │       ├── victory_validation_dialog.dart
│   │       ├── penalty_warning_dialog.dart
│   │       ├── stage_complete_dialog.dart
│   │       ├── stage_failed_dialog.dart # 新規：ステージ失敗ダイアログ
│   │       └── confirmation_dialog.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── text_styles.dart
│   │   └── dimensions.dart
│   └── routes/
│       ├── app_router.dart
│       └── route_names.dart
│
└── test/                     # テスト
    ├── unit/
    │   ├── setup_manager_test.dart
    │   ├── stage_manager_test.dart
    │   ├── item_consumption_manager_test.dart # 新規：アイテム消費テスト
    │   ├── reward_manager_test.dart # 新規：報酬管理テスト
    │   ├── timer_test.dart
    │   ├── victory_validator_test.dart
    │   └── power_enemy_test.dart
    ├── widget/
    └── integration/
```

## 4. 主要クラス設計（修正版）

### 4.1 更新されたドメイン層クラス

#### Item エンティティ（prime.dartから改名・更新）
```dart
class Item {
  final int value;
  final int count;
  final DateTime firstObtained;
  final bool isPrime;
  
  const Item({
    required this.value,
    required this.count,
    required this.firstObtained,
    this.isPrime = true, // デフォルトは素数
  });
  
  bool get isAvailable => count > 0;
  bool get isEmpty => count <= 0;
  
  // アイテム使用（消費）
  Item consume(int amount) {
    if (count < amount) {
      throw ItemException('Insufficient item count. Has: $count, Need: $amount');
    }
    
    return copyWith(count: count - amount);
  }
  
  // アイテム追加
  Item add(int amount) {
    return copyWith(count: count + amount);
  }
  
  Item copyWith({
    int? value,
    int? count,
    DateTime? firstObtained,
    bool? isPrime,
  }) => Item(
    value: value ?? this.value,
    count: count ?? this.count,
    firstObtained: firstObtained ?? this.firstObtained,
    isPrime: isPrime ?? this.isPrime,
  );
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item && runtimeType == other.runtimeType && value == other.value;
  
  @override
  int get hashCode => value.hashCode;
}
```

#### BattleLoadout エンティティ（修正版）
```dart
class BattleLoadout {
  final List<Item> battleItems;  // 戦闘で使用可能なアイテム（消費型）
  final List<Item> originalItems; // 元のアイテム構成（復元用）
  final int maxSlots;
  final Stage targetStage;
  final DateTime createdAt;
  
  const BattleLoadout({
    required this.battleItems,
    required this.originalItems,
    required this.maxSlots,
    required this.targetStage,
    required this.createdAt,
  });
  
  bool get isFull => battleItems.length >= maxSlots;
  bool get isEmpty => battleItems.isEmpty;
  bool get canContinueBattle => battleItems.any((item) => item.count > 0);
  
  int get remainingSlots => maxSlots - battleItems.length;
  int get totalItemCount => battleItems.fold(0, (sum, item) => sum + item.count);
  
  // アイテム使用（戦闘中の消費）
  BattleLoadout useItem(Item item) {
    final itemIndex = battleItems.indexWhere((i) => i.value == item.value);
    if (itemIndex == -1) {
      throw ItemException('Item ${item.value} not found in battle loadout');
    }
    
    final currentItem = battleItems[itemIndex];
    if (currentItem.count <= 0) {
      throw ItemException('Item ${item.value} is already exhausted');
    }
    
    final newBattleItems = List<Item>.from(battleItems);
    newBattleItems[itemIndex] = currentItem.consume(1);
    
    return copyWith(battleItems: newBattleItems);
  }
  
  // アイテム使用可能チェック
  bool canUseItem(Item item) {
    final battleItem = battleItems.firstWhere(
      (i) => i.value == item.value,
      orElse: () => const Item(value: 0, count: 0, firstObtained: DateTime.now()),
    );
    return battleItem.count > 0;
  }
  
  // 残りアイテム数取得
  int getRemainingCount(int itemValue) {
    final item = battleItems.firstWhere(
      (i) => i.value == itemValue,
      orElse: () => const Item(value: 0, count: 0, firstObtained: DateTime.now()),
    );
    return item.count;
  }
  
  BattleLoadout copyWith({
    List<Item>? battleItems,
    List<Item>? originalItems,
    int? maxSlots,
    Stage? targetStage,
    DateTime? createdAt,
  }) => BattleLoadout(
    battleItems: battleItems ?? this.battleItems,
    originalItems: originalItems ?? this.originalItems,
    maxSlots: maxSlots ?? this.maxSlots,
    targetStage: targetStage ?? this.targetStage,
    createdAt: createdAt ?? this.createdAt,
  );
}
```

#### TempReward エンティティ（新規）
```dart
class TempReward {
  final List<Item> tempItems;      // 仮獲得アイテム
  final DateTime battleStartTime;
  final bool isFinalized;          // 確定済みかどうか
  
  const TempReward({
    required this.tempItems,
    required this.battleStartTime,
    this.isFinalized = false,
  });
  
  // 仮報酬追加
  TempReward addTempItem(Item item) {
    if (isFinalized) {
      throw RewardException('Cannot add items to finalized temp rewards');
    }
    
    final existingIndex = tempItems.indexWhere((i) => i.value == item.value);
    
    if (existingIndex != -1) {
      // 既存アイテムの数量を増加
      final updatedItems = List<Item>.from(tempItems);
      updatedItems[existingIndex] = tempItems[existingIndex].add(item.count);
      return copyWith(tempItems: updatedItems);
    } else {
      // 新しいアイテムを追加
      return copyWith(tempItems: [...tempItems, item]);
    }
  }
  
  // 仮報酬を確定（インベントリに追加）
  TempReward finalize() {
    return copyWith(isFinalized: true);
  }
  
  // 仮報酬を破棄
  TempReward discard() {
    return copyWith(
      tempItems: [],
      isFinalized: true,
    );
  }
  
  int get totalTempItems => tempItems.fold(0, (sum, item) => sum + item.count);
  bool get hasTempRewards => tempItems.isNotEmpty;
  
  TempReward copyWith({
    List<Item>? tempItems,
    DateTime? battleStartTime,
    bool? isFinalized,
  }) => TempReward(
    tempItems: tempItems ?? this.tempItems,
    battleStartTime: battleStartTime ?? this.battleStartTime,
    isFinalized: isFinalized ?? this.isFinalized,
  );
}
```

#### BattleState エンティティ（修正版）
```dart
class BattleState {
  final Enemy? currentEnemy;
  final BattleLoadout? loadout;
  final TempReward tempReward;      // 新規：仮報酬管理
  final List<Item> usedItems;       // 戦闘中に使用したアイテム
  final BattleStatus status;
  final int turnCount;
  final DateTime? battleStartTime;
  final TimerState? timerState;
  final VictoryClaim? victoryClaim;
  final List<TimePenalty> battlePenalties;
  final Stage? currentStage;
  
  const BattleState({
    this.currentEnemy,
    this.loadout,
    this.tempReward = const TempReward(tempItems: [], battleStartTime: DateTime.now()),
    this.usedItems = const [],
    this.status = BattleStatus.waiting,
    this.turnCount = 0,
    this.battleStartTime,
    this.timerState,
    this.victoryClaim,
    this.battlePenalties = const [],
    this.currentStage,
  });
  
  // アイテム使用可能性チェック
  bool canUseItem(Item item) {
    if (loadout == null || timerState?.isExpired == true) return false;
    
    // 素数攻撃失敗チェック：すでに素数の敵には攻撃できない
    if (currentEnemy != null && currentEnemy!.isPrime && item.isPrime) {
      return false;
    }
    
    return loadout!.canUseItem(item);
  }
  
  // 戦闘継続可能性チェック
  bool get canFight {
    return loadout != null && 
           loadout!.canContinueBattle && 
           timerState?.isActive == true && 
           !timerState!.isExpired;
  }
  
  bool get canClaimVictory {
    return currentEnemy != null && 
           timerState?.isActive == true && 
           !timerState!.isExpired;
  }
  
  // アイテム使用（成功/失敗に関わらず消費）
  BattleState useItem(Item item) {
    if (loadout == null) return this;
    
    return copyWith(
      loadout: loadout!.useItem(item),
      usedItems: [...usedItems, item],
      turnCount: turnCount + 1,
    );
  }
  
  // 仮報酬追加
  BattleState addTempReward(Item rewardItem) {
    return copyWith(
      tempReward: tempReward.addTempItem(rewardItem),
    );
  }
  
  // ステージクリア時：仮報酬を確定
  BattleState finalizeRewards() {
    return copyWith(
      tempReward: tempReward.finalize(),
      status: BattleStatus.stageComplete,
    );
  }
  
  // ステージ失敗時：仮報酬を破棄
  BattleState discardRewards() {
    return copyWith(
      tempReward: tempReward.discard(),
      status: BattleStatus.stageFailed,
    );
  }
  
  BattleState copyWith({
    Enemy? currentEnemy,
    BattleLoadout? loadout,
    TempReward? tempReward,
    List<Item>? usedItems,
    BattleStatus? status,
    int? turnCount,
    DateTime? battleStartTime,
    TimerState? timerState,
    VictoryClaim? victoryClaim,
    List<TimePenalty>? battlePenalties,
    Stage? currentStage,
  }) => BattleState(
    currentEnemy: currentEnemy ?? this.currentEnemy,
    loadout: loadout ?? this.loadout,
    tempReward: tempReward ?? this.tempReward,
    usedItems: usedItems ?? this.usedItems,
    status: status ?? this.status,
    turnCount: turnCount ?? this.turnCount,
    battleStartTime: battleStartTime ?? this.battleStartTime,
    timerState: timerState ?? this.timerState,
    victoryClaim: victoryClaim ?? this.victoryClaim,
    battlePenalties: battlePenalties ?? this.battlePenalties,
    currentStage: currentStage ?? this.currentStage,
  );
}

enum BattleStatus { 
  waiting, 
  fighting, 
  victory, 
  escape, 
  timeOut, 
  stageComplete,  // 新規：ステージクリア
  stageFailed,    // 新規：ステージ失敗
}
```

#### Inventory エンティティ（修正版：永続的管理）
```dart
class Inventory {
  final List<Item> items;
  final DateTime lastUpdated;
  
  const Inventory({
    required this.items,
    required this.lastUpdated,
  });
  
  // アイテム存在チェック
  bool hasItem(int value) {
    return items.any((item) => item.value == value && item.count > 0);
  }
  
  Item? getItem(int value) {
    try {
      return items.firstWhere((item) => item.value == value);
    } catch (e) {
      return null;
    }
  }
  
  // 選択可能なアイテムのリスト
  List<Item> get availableItems {
    return items.where((item) => item.count > 0).toList();
  }
  
  // 永続的なアイテム追加（勝利報酬など）
  Inventory addItem(Item newItem) {
    final existingIndex = items.indexWhere(
      (item) => item.value == newItem.value
    );
    
    if (existingIndex != -1) {
      final updatedItems = List<Item>.from(items);
      updatedItems[existingIndex] = items[existingIndex].add(newItem.count);
      return copyWith(items: updatedItems);
    } else {
      return copyWith(items: [...items, newItem]);
    }
  }
  
  // 確定した仮報酬をインベントリに追加
  Inventory addTempRewards(TempReward tempReward) {
    if (!tempReward.isFinalized) {
      throw RewardException('Cannot add unfinalized temp rewards to inventory');
    }
    
    Inventory updatedInventory = this;
    for (final tempItem in tempReward.tempItems) {
      updatedInventory = updatedInventory.addItem(tempItem);
    }
    
    return updatedInventory.copyWith(lastUpdated: DateTime.now());
  }
  
  int get totalItems => items.fold(0, (sum, item) => sum + item.count);
  int get uniqueItems => items.length;
  
  Inventory copyWith({
    List<Item>? items,
    DateTime? lastUpdated,
  }) => Inventory(
    items: items ?? this.items,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
}
```

### 4.2 新規ビジネスロジック層クラス

#### ItemConsumptionManager サービス（新規）
```dart
class ItemConsumptionManager {
  // アイテム使用処理（成功/失敗に関わらず消費）
  BattleLoadout consumeItem(BattleLoadout loadout, Item item) {
    if (!loadout.canUseItem(item)) {
      throw ItemException('Cannot use item ${item.value}');
    }
    
    return loadout.useItem(item);
  }
  
  // 攻撃成功/失敗の判定（消費は別途実行）
  AttackResult validateAttack(Enemy enemy, Item item) {
    // 素数攻撃失敗チェック
    if (enemy.isPrime) {
      return AttackResult.failure(
        reason: 'Cannot attack prime enemy ${enemy.currentValue} with any item',
        isPrimeAttack: true,
      );
    }
    
    // 割り切れるかチェック
    if (enemy.currentValue % item.value == 0) {
      final newValue = enemy.currentValue ~/ item.value;
      return AttackResult.success(
        newEnemyValue: newValue,
        usedItem: item,
      );
    } else {
      return AttackResult.failure(
        reason: 'Item ${item.value} cannot divide ${enemy.currentValue}',
        isPrimeAttack: false,
      );
    }
  }
  
  // バトル用ロードアウト作成
  BattleLoadout createBattleLoadout(
    Stage stage, 
    List<Item> selectedItems
  ) {
    if (selectedItems.length > stage.slotLimit) {
      throw ItemException(
        'Too many items selected. Limit: ${stage.slotLimit}, Selected: ${selectedItems.length}'
      );
    }
    
    return BattleLoadout(
      battleItems: List<Item>.from(selectedItems),
      originalItems: List<Item>.from(selectedItems),
      maxSlots: stage.slotLimit,
      targetStage: stage,
      createdAt: DateTime.now(),
    );
  }
}

@freezed
class AttackResult with _$AttackResult {
  const factory AttackResult.success({
    required int newEnemyValue,
    required Item usedItem,
  }) = _AttackSuccess;
  
  const factory AttackResult.failure({
    required String reason,
    required bool isPrimeAttack,
  }) = _AttackFailure;
}
```

#### RewardManager サービス（新規）
```dart
class RewardManager {
  // 戦闘勝利時の仮報酬追加
  TempReward addBattleReward(
    TempReward currentReward, 
    Enemy defeatedEnemy
  ) {
    final rewardItem = Item(
      value: defeatedEnemy.currentValue,
      count: 1,
      firstObtained: DateTime.now(),
      isPrime: true,
    );
    
    return currentReward.addTempItem(rewardItem);
  }
  
  // 累乗敵勝利時の特別報酬
  TempReward addPowerEnemyReward(
    TempReward currentReward,
    PowerEnemy defeatedPowerEnemy
  ) {
    final rewardItem = Item(
      value: defeatedPowerEnemy.basePrime,
      count: defeatedPowerEnemy.power,
      firstObtained: DateTime.now(),
      isPrime: true,
    );
    
    return currentReward.addTempItem(rewardItem);
  }
  
  // ステージクリア時の確定処理
  Future<RewardResult> finalizeStageRewards(
    TempReward tempReward,
    Inventory currentInventory,
    Stage clearedStage
  ) async {
    try {
      // 仮報酬を確定
      final finalizedReward = tempReward.finalize();
      
      // インベントリに追加
      var updatedInventory = currentInventory.addTempRewards(finalizedReward);
      
      // ステージ基本報酬も追加
      for (final stageReward in clearedStage.rewards) {
        if (stageReward.type == RewardType.prime) {
          final rewardItem = Item(
            value: stageReward.value,
            count: stageReward.count,
            firstObtained: DateTime.now(),
            isPrime: true,
          );
          updatedInventory = updatedInventory.addItem(rewardItem);
        }
      }
      
      return RewardResult.success(
        finalizedReward: finalizedReward,
        updatedInventory: updatedInventory,
        totalRewardItems: finalizedReward.totalTempItems + clearedStage.rewards.length,
      );
      
    } catch (e) {
      return RewardResult.failure('Failed to finalize rewards: ${e.toString()}');
    }
  }
  
  // ステージ失敗時の破棄処理
  RewardResult discardStageRewards(TempReward tempReward) {
    final discardedReward = tempReward.discard();
    
    return RewardResult.discarded(
      discardedReward: discardedReward,
      discardedItemCount: tempReward.totalTempItems,
    );
  }
}

@freezed
class RewardResult with _$RewardResult {
  const factory RewardResult.success({
    required TempReward finalizedReward,
    required Inventory updatedInventory,
    required int totalRewardItems,
  }) = _RewardSuccess;
  
  const factory RewardResult.failure(String message) = _RewardFailure;
  
  const factory RewardResult.discarded({
    required TempReward discardedReward,
    required int discardedItemCount,
  }) = _RewardDiscarded;
}
```

#### 更新されたBattleEngine サービス（修正版）
```dart
class BattleEngine {
  final ItemConsumptionManager _itemConsumptionManager;
  final RewardManager _rewardManager;
  final VictoryValidator _victoryValidator;
  final PenaltyCalculator _penaltyCalculator;
  
  BattleEngine(
    this._itemConsumptionManager,
    this._rewardManager,
    this._victoryValidator,
    this._penaltyCalculator,
  );
  
  // 攻撃実行（アイテムは必ず消費される）
  Future<BattleResult> executeAttack(
    BattleState currentState, 
    Item selectedItem
  ) async {
    final enemy = currentState.currentEnemy;
    final loadout = currentState.loadout;
    
    if (enemy == null || loadout == null) {
      return const BattleResult.error('Invalid battle state');
    }
    
    // アイテム使用可能性チェック
    if (!currentState.canUseItem(selectedItem)) {
      return const BattleResult.error('Cannot use selected item');
    }
    
    try {
      // アイテムを消費（攻撃の成功/失敗に関わらず）
      final updatedLoadout = _itemConsumptionManager.consumeItem(loadout, selectedItem);
      
      // 攻撃結果を判定
      final attackResult = _itemConsumptionManager.validateAttack(enemy, selectedItem);
      
      return attackResult.when(
        success: (newEnemyValue, usedItem) {
          final newEnemy = enemy.copyWith(currentValue: newEnemyValue);
          
          // 素数になった場合は勝利条件待ち
          if (newEnemy.isPrime) {
            return BattleResult.awaitingVictoryClaim(newEnemy, usedItem);
          } else {
            return BattleResult.continue_(newEnemy, usedItem);
          }
        },
        failure: (reason, isPrimeAttack) {
          // 攻撃失敗でもアイテムは消費済み
          if (isPrimeAttack) {
            return BattleResult.error('素数への攻撃は無効です');
          } else {
            return BattleResult.error('攻撃が無効です: $reason');
          }
        },
      );
      
    } catch (e) {
      return BattleResult.error('Attack execution failed: ${e.toString()}');
    }
  }
  
  // 勝利宣言処理
  BattleResult processVictoryClaim(
    BattleState currentState,
    int claimedValue
  ) {
    final enemy = currentState.currentEnemy;
    if (enemy == null) {
      return const BattleResult.error('No enemy to claim victory against');
    }
    
    final validation = _victoryValidator.validateVictoryClaim(enemy, claimedValue);
    
    return validation.when(
      valid: (defeatedEnemy) {
        // 通常の勝利
        if (defeatedEnemy is! PowerEnemy) {
          return BattleResult.victory(defeatedEnemy, defeatedEnemy.currentValue);
        }
        // 累乗敵の勝利
        else {
          return BattleResult.powerVictory(
            defeatedEnemy, 
            defeatedEnemy.basePrime, 
            defeatedEnemy.power
          );
        }
      },
      invalid: (reason) {
        final penalty = _penaltyCalculator.calculateWrongClaimPenalty();
        return BattleResult.wrongClaim(penalty, enemy);
      },
    );
  }
  
  // リタイア処理
  BattleResult processRetire() {
    final penalty = _penaltyCalculator.calculateRetirePenalty();
    return BattleResult.retire(penalty);
  }
  
  // タイムアウト処理
  BattleResult processTimeOut() {
    final penalty = _penaltyCalculator.calculateTimeOutPenalty();
    return BattleResult.timeOut(penalty);
  }
}

@freezed
class BattleResult with _$BattleResult {
  const factory BattleResult.continue_(Enemy newEnemy, Item usedItem) = _Continue;
  const factory BattleResult.awaitingVictoryClaim(Enemy enemy, Item usedItem) = _AwaitingVictoryClaim;
  const factory BattleResult.victory(Enemy defeatedEnemy, int rewardPrime) = _Victory;
  const factory BattleResult.powerVictory(PowerEnemy defeatedEnemy, int rewardPrime, int rewardCount) = _PowerVictory;
  const factory BattleResult.wrongClaim(TimePenalty penalty, Enemy currentEnemy) = _WrongClaim;
  const factory BattleResult.retire(TimePenalty penalty) = _Retire;
  const factory BattleResult.timeOut(TimePenalty penalty) = _TimeOut;
  const factory BattleResult.error(String message) = _Error;
}
```

### 4.3 更新されたプレゼンテーション層クラス

#### 更新されたBattleNotifier（修正版）
```dart
class BattleNotifier extends StateNotifier<BattleState> {
  final BattleEngine _battleEngine;
  final EnemyGenerator _enemyGenerator;
  final TimerManager _timerManager;
  final RewardManager _rewardManager;
  final Ref _ref;
  
  BattleNotifier(
    this._battleEngine, 
    this._enemyGenerator, 
    this._timerManager,
    this._rewardManager,
    this._ref
  ) : super(const BattleState()) {
    _timerManager.timerStream.listen(_handleTimerUpdate);
  }
  
  void startBattleWithLoadout(BattleLoadout loadout) {
    final stage = loadout.targetStage;
    
    // 敵生成
    final enemy = _enemyGenerator.generateEnemyForStage(stage);
    
    // タイマー開始
    final penaltyReduction = state.battlePenalties
        .fold(0, (sum, penalty) => sum + penalty.seconds);
    final adjustedTime = math.max(10, stage.baseTimeSeconds - penaltyReduction);
    
    _timerManager.startTimer(adjustedTime);
    
    // 仮報酬を初期化
    final tempReward = TempReward(
      tempItems: [],
      battleStartTime: DateTime.now(),
    );
    
    state = state.copyWith(
      currentEnemy: enemy,
      loadout: loadout,
      currentStage: stage,
      tempReward: tempReward,
      status: BattleStatus.fighting,
      battleStartTime: DateTime.now(),
      turnCount: 0,
      usedItems: [],
      victoryClaim: null,
    );
  }
  
  Future<void> attack(Item item) async {
    if (state.currentEnemy == null || 
        state.timerState?.isExpired == true ||
        !state.canUseItem(item)) {
      return;
    }
    
    // アイテムを消費（成功/失敗に関わらず）
    state = state.useItem(item);
    
    final result = await _battleEngine.executeAttack(state, item);
    
    await result.when(
      continue_: (newEnemy, usedItem) async {
        await _playAttackAnimation(usedItem.value, false);
        
        state = state.copyWith(
          currentEnemy: newEnemy,
          status: BattleStatus.fighting,
        );
      },
      awaitingVictoryClaim: (newEnemy, usedItem) async {
        await _playAttackAnimation(usedItem.value, true);
        
        state = state.copyWith(
          currentEnemy: newEnemy,
          status: BattleStatus.fighting,
        );
      },
      error: (message) {
        _showError(message);
      },
      // 他のケースは後続処理で使用
      victory: (_, __) => {},
      powerVictory: (_, __, ___) => {},
      wrongClaim: (_, __) => {},
      retire: (_) => {},
      timeOut: (_) => {},
    );
  }
  
  Future<void> claimVictory() async {
    if (state.currentEnemy == null || !state.canClaimVictory) return;
    
    final result = _battleEngine.processVictoryClaim(
      state, 
      state.currentEnemy!.currentValue
    );
    
    await result.when(
      victory: (defeatedEnemy, rewardPrime) async {
        await _playVictoryAnimation();
        
        // 仮報酬に追加
        final updatedTempReward = _rewardManager.addBattleReward(
          state.tempReward, 
          defeatedEnemy
        );
        
        state = state.copyWith(
          tempReward: updatedTempReward,
          victoryClaim: VictoryClaim(
            claimedValue: defeatedEnemy.currentValue,
            claimedAt: DateTime.now(),
            isCorrect: true,
            rewardPrime: rewardPrime,
          ),
        );
        
        // 次の敵を生成するか、ステージクリア判定
        await _checkStageCompletion();
      },
      powerVictory: (defeatedPowerEnemy, rewardPrime, rewardCount) async {
        await _playPowerVictoryAnimation();
        
        // 累乗敵の特別報酬を仮報酬に追加
        final updatedTempReward = _rewardManager.addPowerEnemyReward(
          state.tempReward, 
          defeatedPowerEnemy
        );
        
        state = state.copyWith(
          tempReward: updatedTempReward,
          victoryClaim: VictoryClaim(
            claimedValue: defeatedPowerEnemy.currentValue,
            claimedAt: DateTime.now(),
            isCorrect: true,
            rewardPrime: rewardPrime,
          ),
        );
        
        await _checkStageCompletion();
      },
      wrongClaim: (penalty, currentEnemy) async {
        await _playPenaltyAnimation();
        _timerManager.applyPenalty(penalty);
        
        state = state.copyWith(
          victoryClaim: VictoryClaim(
            claimedValue: currentEnemy.currentValue,
            claimedAt: DateTime.now(),
            isCorrect: false,
          ),
          battlePenalties: [...state.battlePenalties, penalty],
        );
        
        _showPenaltyMessage("まだ合成数です。続けてください");
      },
      // 他のケースは使用されない
      continue_: (_, __) => {},
      awaitingVictoryClaim: (_, __) => {},
      error: (_) => {},
      retire: (_) => {},
      timeOut: (_) => {},
    );
  }
  
  Future<void> retire() async {
    final result = _battleEngine.processRetire();
    
    result.when(
      retire: (penalty) async {
        state = state.copyWith(
          status: BattleStatus.stageFailed,
          battlePenalties: [...state.battlePenalties, penalty],
        );
        
        _timerManager.stopTimer();
        
        // 仮報酬を破棄
        await _discardTempRewards();
      },
      // 他のケースは使用されない
      continue_: (_, __) => {},
      awaitingVictoryClaim: (_, __) => {},
      victory: (_, __) => {},
      powerVictory: (_, __, ___) => {},
      wrongClaim: (_, __) => {},
      timeOut: (_) => {},
      error: (_) => {},
    );
  }
  
  Future<void> _checkStageCompletion() async {
    // ステージの完了条件をチェック（例：敵数、特定条件など）
    // 簡単な例として、1体撃破でクリアとする
    if (state.tempReward.hasTempRewards) {
      await _completeStage();
    }
  }
  
  Future<void> _completeStage() async {
    _timerManager.stopTimer();
    
    // ステージクリア処理
    state = state.finalizeRewards();
    
    // 仮報酬をインベントリに確定
    final rewardResult = await _rewardManager.finalizeStageRewards(
      state.tempReward,
      _ref.read(inventoryProvider),
      state.currentStage!,
    );
    
    rewardResult.when(
      success: (finalizedReward, updatedInventory, totalRewardItems) {
        // インベントリを更新
        _ref.read(inventoryProvider.notifier).updateInventory(updatedInventory);
        
        _showStageCompleteMessage(totalRewardItems);
      },
      failure: (message) {
        _showError(message);
      },
      discarded: (_, __) {
        // このケースは発生しない
      },
    );
    
    _ref.read(achievementProvider.notifier).checkAchievements();
  }
  
  Future<void> _discardTempRewards() async {
    state = state.discardRewards();
    
    final rewardResult = _rewardManager.discardStageRewards(state.tempReward);
    
    rewardResult.when(
      discarded: (discardedReward, discardedItemCount) {
        _showStageFailedMessage(discardedItemCount);
      },
      success: (_, __, ___) => {},
      failure: (_) => {},
    );
  }
  
  void _handleTimerUpdate(TimerState timerState) {
    state = state.copyWith(timerState: timerState);
    
    if (timerState.isExpired && state.status == BattleStatus.fighting) {
      final result = _battleEngine.processTimeOut();
      
      result.when(
        timeOut: (penalty) async {
          state = state.copyWith(
            status: BattleStatus.stageFailed,
            battlePenalties: [...state.battlePenalties, penalty],
          );
          
          await _discardTempRewards();
        },
        // 他のケースは使用されない
        continue_: (_, __) => {},
        awaitingVictoryClaim: (_, __) => {},
        victory: (_, __) => {},
        powerVictory: (_, __, ___) => {},
        wrongClaim: (_, __) => {},
        retire: (_) => {},
        error: (_) => {},
      );
    }
  }
  
  // アニメーション・メッセージ関連メソッド
  Future<void> _playAttackAnimation(int itemValue, bool isPrimeReached) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
  
  Future<void> _playVictoryAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
  
  Future<void> _playPowerVictoryAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
  }
  
  Future<void> _playPenaltyAnimation() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }
  
  void _showError(String message) {
    // エラー表示実装
  }
  
  void _showPenaltyMessage(String message) {
    // ペナルティメッセージ表示実装
  }
  
  void _showStageCompleteMessage(int rewardCount) {
    // ステージクリアメッセージ表示実装
  }
  
  void _showStageFailedMessage(int lostRewardCount) {
    // ステージ失敗メッセージ表示実装
  }
  
  @override
  void dispose() {
    _timerManager.dispose();
    super.dispose();
  }
}
```

#### TempRewardNotifier（新規）
```dart
class TempRewardNotifier extends StateNotifier<TempRewardState> {
  final RewardManager _rewardManager;
  
  TempRewardNotifier(this._rewardManager) : super(const TempRewardState());
  
  void initializeTempReward() {
    state = state.copyWith(
      tempReward: TempReward(
        tempItems: [],
        battleStartTime: DateTime.now(),
      ),
    );
  }
  
  void addTempItem(Item item) {
    if (state.tempReward != null) {
      final updatedReward = state.tempReward!.addTempItem(item);
      state = state.copyWith(tempReward: updatedReward);
    }
  }
  
  void clearTempRewards() {
    state = state.copyWith(tempReward: null);
  }
}

@freezed
class TempRewardState with _$TempRewardState {
  const factory TempRewardState({
    TempReward? tempReward,
  }) = _TempRewardState;
}
```

### 4.4 更新されたプロバイダー定義（完全版）

```dart
// ==================== Core Providers ====================
final itemConsumptionManagerProvider = Provider<ItemConsumptionManager>(
  (ref) => ItemConsumptionManager()
);

final rewardManagerProvider = Provider<RewardManager>(
  (ref) => RewardManager()
);

final setupManagerProvider = Provider<SetupManager>((ref) => SetupManager());
final stageManagerProvider = Provider<StageManager>((ref) => StageManager());

// ==================== State Providers ====================
final inventoryProvider = StateNotifierProvider<InventoryNotifier, Inventory>((ref) {
  return InventoryNotifier(ref);
});

final stageProvider = StateNotifierProvider<StageNotifier, StageState>((ref) {
  return StageNotifier(ref.read(stageManagerProvider));
});

final setupProvider = StateNotifierProvider<SetupNotifier, SetupState>((ref) {
  return SetupNotifier(
    ref.read(setupManagerProvider),
    ref.read(stageManagerProvider),
    ref,
  );
});

final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>((ref) {
  return BattleNotifier(
    ref.read(battleEngineProvider),
    ref.read(enemyGeneratorProvider),
    ref.read(timerManagerProvider),
    ref.read(rewardManagerProvider),
    ref,
  );
});

final tempRewardProvider = StateNotifierProvider<TempRewardNotifier, TempRewardState>((ref) {
  return TempRewardNotifier(ref.read(rewardManagerProvider));
});

// ==================== Computed Providers ====================
final canAddToBattleLoadoutProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  return setup.selectedItems.length < setup.maxSlots;
});

final canStartBattleProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  return setup.isValid && setup.selectedItems.isNotEmpty;
});

final canUseItemProvider = Provider.family<bool, int>((ref, itemValue) {
  final battle = ref.watch(battleProvider);
  return battle.loadout?.getRemainingCount(itemValue) ?? 0 > 0;
});

final availableItemsProvider = Provider<List<Item>>((ref) {
  final inventory = ref.watch(inventoryProvider);
  return inventory.availableItems;
});

final unlockedStagesProvider = Provider<List<Stage>>((ref) {
  final stageState = ref.watch(stageProvider);
  return stageState.stages.where((stage) => stage.isUnlocked).toList();
});

final currentLoadoutInfoProvider = Provider<String>((ref) {
  final setup = ref.watch(setupProvider);
  return '${setup.selectedItems.length}/${setup.maxSlots}';
});

final tempRewardCountProvider = Provider<int>((ref) {
  final tempReward = ref.watch(tempRewardProvider);
  return tempReward.tempReward?.totalTempItems ?? 0;
});

final battleItemsRemainingProvider = Provider<Map<int, int>>((ref) {
  final battle = ref.watch(battleProvider);
  final loadout = battle.loadout;
  
  if (loadout == null) return {};
  
  return Map.fromEntries(
    loadout.battleItems.map((item) => MapEntry(item.value, item.count))
  );
});

// ==================== Stream Providers ====================
final timerProvider = StreamProvider<TimerState>((ref) {
  final timerManager = ref.read(timerManagerProvider);
  return timerManager.timerStream;
});

// ==================== Family Providers ====================
final stageInfoProvider = Provider.family<Stage?, int>((ref, stageNumber) {
  final stageManager = ref.read(stageManagerProvider);
  return stageManager.getStage(stageNumber);
});

final itemRemainingCountProvider = Provider.family<int, int>((ref, itemValue) {
  final battle = ref.watch(battleProvider);
  return battle.loadout?.getRemainingCount(itemValue) ?? 0;
});
      