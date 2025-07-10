# 合成数ハンター システム設計書（持ち込みシステム対応版）

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
│  │   Setup     │  │   Timer     │  │ Achievement │     │
│  │  Provider   │  │  Provider   │  │  Provider   │     │
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
│  │   Setup     │  │   Timer     │  │  Victory    │     │
│  │  Manager    │  │  Manager    │  │ Validator   │     │
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

### 1.2 データフロー図（持ち込みシステム対応）
```
Stage Selection → Setup Screen → Battle → Restoration
      ↓              ↓            ↓           ↓
   Stage Info → Prime Selection → Combat → Full Recovery
      ↓              ↓            ↓           ↓
   Slot Limit → Battle Loadout → Timer → Original Inventory
```

## 2. 状態管理戦略（更新版）

### 2.1 Riverpod実装戦略（持ち込みシステム対応）

#### 状態管理パターン（更新版）
```dart
// 1. インベントリ状態 - StateNotifierProvider
final inventoryProvider = StateNotifierProvider<InventoryNotifier, InventoryState>(
  (ref) => InventoryNotifier(ref),
);

// 2. ステージ状態 - StateNotifierProvider  
final stageProvider = StateNotifierProvider<StageNotifier, StageState>(
  (ref) => StageNotifier(ref),
);

// 3. 持ち込みセットアップ状態 - StateNotifierProvider
final setupProvider = StateNotifierProvider<SetupNotifier, SetupState>(
  (ref) => SetupNotifier(ref),
);

// 4. 戦闘状態 - StateNotifierProvider（持ち込み素数のみ使用）
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>(
  (ref) => BattleNotifier(ref),
);

// 5. 持ち込み制限チェック - Provider (computed)
final canAddToBattleLoadoutProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  final stage = ref.watch(stageProvider);
  return setup.selectedPrimes.length < stage.currentStage.slotLimit;
});

// 6. 戦闘可能チェック - Provider (computed)
final canStartBattleProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  return setup.selectedPrimes.isNotEmpty;
});
```

#### プロバイダー階層（持ち込みシステム対応）
```
App Level Providers:
├── gameDataProvider (永続化データ)
├── settingsProvider (アプリ設定)
├── achievementProvider (実績管理)
└── globalTimerProvider (アプリ全体タイマー)

Game Flow Providers:
├── stageProvider (ステージ管理・スロット制限)
├── inventoryProvider (永続的な素数管理)
├── setupProvider (持ち込み選択管理)
└── battleProvider (戦闘状態・持ち込み素数のみ)

Battle Specific Providers:
├── timerProvider (制限時間管理)
├── victoryValidationProvider (勝利判定)
├── enemyProvider (敵生成・累乗敵含む)
└── restoreProvider (戦闘終了後復元)

UI Level Providers:
├── animationProvider (アニメーション状態)
├── penaltyDisplayProvider (ペナルティ表示)
└── uiStateProvider (UI表示状態)
```

## 3. ディレクトリ構造（更新版）

### 3.1 全体構造（持ち込みシステム対応）
```
lib/
├── main.dart
├── app.dart
│
├── core/                     # 共通機能
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── game_constants.dart
│   │   ├── stage_constants.dart    # 新規：ステージスロット制限
│   │   ├── timer_constants.dart
│   │   └── ui_constants.dart
│   ├── exceptions/
│   │   ├── game_exception.dart
│   │   ├── setup_exception.dart    # 新規：持ち込み設定例外
│   │   ├── stage_exception.dart    # 新規：ステージ例外
│   │   ├── timer_exception.dart
│   │   ├── victory_exception.dart
│   │   └── data_exception.dart
│   ├── extensions/
│   │   ├── int_extensions.dart
│   │   ├── list_extensions.dart
│   │   ├── prime_extensions.dart   # 新規：持ち込み用拡張
│   │   └── duration_extensions.dart
│   ├── utils/
│   │   ├── math_utils.dart
│   │   ├── setup_utils.dart        # 新規：持ち込み設定ユーティリティ
│   │   ├── stage_utils.dart        # 新規：ステージユーティリティ
│   │   ├── timer_utils.dart
│   │   ├── validation_utils.dart
│   │   └── logger.dart
│   └── di/
│       └── injection.dart
│
├── data/                     # データレイヤー
│   ├── models/
│   │   ├── prime_model.dart
│   │   ├── enemy_model.dart
│   │   ├── power_enemy_model.dart
│   │   ├── stage_model.dart        # 新規：ステージ情報
│   │   ├── battle_loadout_model.dart # 新規：持ち込み構成
│   │   ├── battle_result_model.dart
│   │   ├── timer_state_model.dart
│   │   ├── penalty_record_model.dart
│   │   └── game_data_model.dart
│   ├── repositories/
│   │   ├── game_repository.dart
│   │   ├── inventory_repository.dart
│   │   ├── stage_repository.dart   # 新規：ステージデータ管理
│   │   ├── setup_repository.dart   # 新規：持ち込み設定管理
│   │   ├── battle_repository.dart
│   │   ├── timer_repository.dart
│   │   └── achievement_repository.dart
│   ├── datasources/
│   │   ├── local_database.dart
│   │   ├── shared_preferences_service.dart
│   │   └── file_storage_service.dart
│   └── mappers/
│       ├── prime_mapper.dart
│       ├── enemy_mapper.dart
│       ├── stage_mapper.dart       # 新規：ステージマッパー
│       ├── setup_mapper.dart       # 新規：持ち込み設定マッパー
│       ├── battle_mapper.dart
│       └── timer_mapper.dart
│
├── domain/                   # ビジネスロジック層
│   ├── entities/
│   │   ├── prime.dart
│   │   ├── enemy.dart
│   │   ├── power_enemy.dart
│   │   ├── stage.dart              # 新規：ステージエンティティ
│   │   ├── battle_loadout.dart     # 新規：持ち込み構成エンティティ
│   │   ├── battle_state.dart       # 更新：持ち込み素数のみ管理
│   │   ├── timer_state.dart
│   │   ├── penalty_state.dart
│   │   ├── victory_claim.dart
│   │   └── inventory.dart          # 更新：非消費型インベントリ
│   ├── usecases/
│   │   ├── battle_usecase.dart     # 更新：持ち込み素数のみ使用
│   │   ├── inventory_usecase.dart  # 更新：非消費型管理
│   │   ├── stage_usecase.dart      # 新規：ステージ管理
│   │   ├── setup_usecase.dart      # 新規：持ち込み設定管理
│   │   ├── enemy_generation_usecase.dart
│   │   ├── timer_management_usecase.dart
│   │   ├── victory_validation_usecase.dart
│   │   └── penalty_calculation_usecase.dart
│   ├── repositories/
│   │   └── game_repository_interface.dart
│   └── services/
│       ├── battle_engine.dart      # 更新：持ち込み素数制限
│       ├── setup_manager.dart      # 新規：持ち込み選択管理
│       ├── stage_manager.dart      # 新規：ステージ管理
│       ├── restore_manager.dart    # 新規：戦闘後復元管理
│       ├── prime_calculator.dart
│       ├── enemy_generator.dart
│       ├── power_enemy_detector.dart
│       ├── timer_manager.dart
│       ├── victory_validator.dart
│       └── penalty_calculator.dart
│
├── presentation/             # プレゼンテーション層
│   ├── providers/
│   │   ├── battle_provider.dart    # 更新：持ち込み素数のみ
│   │   ├── inventory_provider.dart # 更新：非消費型
│   │   ├── stage_provider.dart     # 新規：ステージ管理
│   │   ├── setup_provider.dart     # 新規：持ち込み設定
│   │   ├── enemy_provider.dart
│   │   ├── timer_provider.dart
│   │   ├── victory_provider.dart
│   │   ├── penalty_provider.dart
│   │   ├── game_provider.dart
│   │   └── ui_state_provider.dart
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── tutorial/
│   │   │   ├── tutorial_screen.dart
│   │   │   └── widgets/
│   │   │       ├── timer_tutorial_widget.dart
│   │   │       ├── setup_tutorial_widget.dart # 新規：持ち込み説明
│   │   │       └── victory_tutorial_widget.dart
│   │   ├── stage/                  # 新規：ステージ選択
│   │   │   ├── stage_selection_screen.dart
│   │   │   └── widgets/
│   │   │       ├── stage_card_widget.dart
│   │   │       └── stage_info_widget.dart
│   │   ├── setup/                  # 新規：持ち込み設定
│   │   │   ├── setup_screen.dart
│   │   │   └── widgets/
│   │   │       ├── prime_selector_widget.dart
│   │   │       ├── loadout_display_widget.dart
│   │   │       ├── slot_limit_widget.dart
│   │   │       └── start_battle_button.dart
│   │   ├── battle/
│   │   │   ├── battle_screen.dart  # 更新：持ち込み素数のみ表示
│   │   │   └── widgets/
│   │   │       ├── enemy_widget.dart
│   │   │       ├── power_enemy_widget.dart
│   │   │       ├── loadout_grid_widget.dart # 更新：持ち込み素数グリッド
│   │   │       ├── timer_widget.dart
│   │   │       ├── victory_claim_button.dart
│   │   │       ├── action_buttons_widget.dart
│   │   │       └── battle_animation_widget.dart
│   │   ├── inventory/
│   │   │   ├── inventory_screen.dart # 更新：全素数表示（非消費）
│   │   │   └── widgets/
│   │   │       ├── prime_list_widget.dart
│   │   │       └── prime_detail_widget.dart
│   │   └── achievement/
│   │       ├── achievement_screen.dart
│   │       └── widgets/
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── custom_button.dart
│   │   │   ├── timer_display.dart
│   │   │   ├── penalty_indicator.dart
│   │   │   ├── slot_indicator.dart  # 新規：スロット数表示
│   │   │   ├── loading_widget.dart
│   │   │   └── error_widget.dart
│   │   ├── animations/
│   │   │   ├── number_change_animation.dart
│   │   │   ├── attack_effect_animation.dart
│   │   │   ├── victory_animation.dart
│   │   │   ├── penalty_animation.dart
│   │   │   ├── restore_animation.dart # 新規：復元アニメーション
│   │   │   └── power_enemy_animation.dart
│   │   └── dialogs/
│   │       ├── battle_result_dialog.dart
│   │       ├── victory_validation_dialog.dart
│   │       ├── penalty_warning_dialog.dart
│   │       ├── stage_complete_dialog.dart # 新規：ステージクリア
│   │       └── confirmation_dialog.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── text_styles.dart
│   │   └── dimensions.dart
│   └── routes/
│       ├── app_router.dart         # 更新：新画面対応
│       └── route_names.dart
│
└── test/                     # テスト
    ├── unit/
    │   ├── setup_manager_test.dart # 新規：持ち込み設定テスト
    │   ├── stage_manager_test.dart # 新規：ステージ管理テスト
    │   ├── restore_manager_test.dart # 新規：復元機能テスト
    │   ├── timer_test.dart
    │   ├── victory_validator_test.dart
    │   └── power_enemy_test.dart
    ├── widget/
    └── integration/
```

## 4. 主要クラス設計（持ち込みシステム対応）

### 4.1 新規ドメイン層クラス

#### Stage エンティティ（新規）
```dart
class Stage {
  final int stageNumber;
  final String name;
  final String description;
  final int slotLimit;          // 持ち込み素数の上限数
  final int baseTimeSeconds;    // 基本制限時間
  final StageType type;
  final StageDifficulty difficulty;
  final List<StageReward> rewards;
  final bool isUnlocked;
  
  const Stage({
    required this.stageNumber,
    required this.name,
    required this.description,
    required this.slotLimit,
    required this.baseTimeSeconds,
    required this.type,
    required this.difficulty,
    required this.rewards,
    this.isUnlocked = false,
  });
  
  bool canChallenge(List<Prime> inventory) {
    return isUnlocked && inventory.length >= slotLimit;
  }
  
  Stage copyWith({
    int? stageNumber,
    String? name,
    String? description,
    int? slotLimit,
    int? baseTimeSeconds,
    StageType? type,
    StageDifficulty? difficulty,
    List<StageReward>? rewards,
    bool? isUnlocked,
  });
}

enum StageType { tutorial, normal, challenge, special }
enum StageDifficulty { easy, normal, hard, extreme }

class StageReward {
  final RewardType type;
  final int value;
  final int count;
  
  const StageReward({
    required this.type,
    required this.value,
    this.count = 1,
  });
}

enum RewardType { prime, achievement, unlockStage }
```

#### BattleLoadout エンティティ（新規）
```dart
class BattleLoadout {
  final List<Prime> selectedPrimes;
  final int maxSlots;
  final Stage targetStage;
  final DateTime createdAt;
  
  const BattleLoadout({
    required this.selectedPrimes,
    required this.maxSlots,
    required this.targetStage,
    required this.createdAt,
  });
  
  bool get isFull => selectedPrimes.length >= maxSlots;
  bool get isEmpty => selectedPrimes.isEmpty;
  bool get canStartBattle => selectedPrimes.isNotEmpty;
  
  int get remainingSlots => maxSlots - selectedPrimes.length;
  
  BattleLoadout addPrime(Prime prime) {
    if (isFull) {
      throw SetupException('Cannot add more primes. Loadout is full.');
    }
    
    return copyWith(
      selectedPrimes: [...selectedPrimes, prime],
    );
  }
  
  BattleLoadout removePrime(Prime prime) {
    final newPrimes = List<Prime>.from(selectedPrimes);
    newPrimes.remove(prime);
    
    return copyWith(selectedPrimes: newPrimes);
  }
  
  BattleLoadout usePrime(Prime prime) {
    final primeIndex = selectedPrimes.indexWhere((p) => p.value == prime.value);
    if (primeIndex == -1) {
      throw SetupException('Prime ${prime.value} not found in loadout');
    }
    
    final newPrimes = List<Prime>.from(selectedPrimes);
    final usedPrime = newPrimes[primeIndex];
    
    if (usedPrime.count > 1) {
      // 複数個持っている場合は1個減らす
      newPrimes[primeIndex] = usedPrime.copyWith(count: usedPrime.count - 1);
    } else {
      // 1個の場合は削除
      newPrimes.removeAt(primeIndex);
    }
    
    return copyWith(selectedPrimes: newPrimes);
  }
  
  BattleLoadout restoreAll() {
    // 戦闘終了後、全素数を元の状態に復元
    // 実際の復元処理はSetupManagerで行う
    return this;
  }
  
  BattleLoadout copyWith({
    List<Prime>? selectedPrimes,
    int? maxSlots,
    Stage? targetStage,
    DateTime? createdAt,
  });
}
```

#### Inventory エンティティ（更新版：非消費型）
```dart
class Inventory {
  final List<Prime> primes;
  final DateTime lastUpdated;
  
  const Inventory({
    required this.primes,
    required this.lastUpdated,
  });
  
  // 非消費型：素数は戦闘で使用されても在庫から消えない
  bool hasPrime(int value) {
    return primes.any((prime) => prime.value == value && prime.count > 0);
  }
  
  Prime? getPrime(int value) {
    try {
      return primes.firstWhere((prime) => prime.value == value);
    } catch (e) {
      return null;
    }
  }
  
  // 持ち込み可能な素数のリスト（count > 0のもの）
  List<Prime> get availablePrimes {
    return primes.where((prime) => prime.count > 0).toList();
  }
  
  // 新しい素数を追加（勝利報酬など）
  Inventory addPrime(Prime newPrime) {
    final existingIndex = primes.indexWhere(
      (prime) => prime.value == newPrime.value
    );
    
    if (existingIndex != -1) {
      final updatedPrimes = List<Prime>.from(primes);
      updatedPrimes[existingIndex] = primes[existingIndex].copyWith(
        count: primes[existingIndex].count + newPrime.count,
      );
      return copyWith(primes: updatedPrimes);
    } else {
      return copyWith(primes: [...primes, newPrime]);
    }
  }
  
  // 戦闘では使用されないメソッド（非消費型のため）
  // Inventory usePrime(Prime prime) は削除
  
  int get totalPrimes => primes.fold(0, (sum, prime) => sum + prime.count);
  int get uniquePrimes => primes.length;
  
  Inventory copyWith({
    List<Prime>? primes,
    DateTime? lastUpdated,
  });
}
```

### 4.2 更新されたBattleState エンティティ

```dart
class BattleState {
  final Enemy? currentEnemy;
  final BattleLoadout? loadout;     // 変更：持ち込み素数管理
  final List<Prime> usedPrimes;     // 戦闘中に使用した素数（復元用）
  final BattleStatus status;
  final int turnCount;
  final DateTime? battleStartTime;
  final TimerState? timerState;
  final VictoryClaim? victoryClaim;
  final List<TimePenalty> battlePenalties;
  final Stage? currentStage;        // 新規：現在のステージ
  
  const BattleState({
    this.currentEnemy,
    this.loadout,
    this.usedPrimes = const [],
    this.status = BattleStatus.waiting,
    this.turnCount = 0,
    this.battleStartTime,
    this.timerState,
    this.victoryClaim,
    this.battlePenalties = const [],
    this.currentStage,
  });
  
  // 持ち込み素数のみ使用可能
  bool canUsePrime(Prime prime) {
    if (loadout == null || timerState?.isExpired == true) return false;
    return loadout!.selectedPrimes.any((p) => p.value == prime.value && p.count > 0);
  }
  
  // 戦闘可能性チェック（持ち込み素数の有無）
  bool get canFight {
    return loadout != null && 
           loadout!.selectedPrimes.isNotEmpty && 
           timerState?.isActive == true && 
           !timerState!.isExpired;
  }
  
  bool get canClaimVictory {
    return currentEnemy != null && 
           timerState?.isActive == true && 
           !timerState!.isExpired;
  }
  
  BattleState usePrime(Prime prime) {
    if (loadout == null) return this;
    
    return copyWith(
      loadout: loadout!.usePrime(prime),
      usedPrimes: [...usedPrimes, prime],
      turnCount: turnCount + 1,
    );
  }
  
  // 戦闘終了後の復元処理
  BattleState restoreLoadout() {
    if (loadout == null) return this;
    
    // SetupManagerを通じて元の持ち込み構成に復元
    return copyWith(
      loadout: loadout!.restoreAll(),
      usedPrimes: [],
    );
  }
  
  BattleState copyWith({
    Enemy? currentEnemy,
    BattleLoadout? loadout,
    List<Prime>? usedPrimes,
    BattleStatus? status,
    int? turnCount,
    DateTime? battleStartTime,
    TimerState? timerState,
    VictoryClaim? victoryClaim,
    List<TimePenalty>? battlePenalties,
    Stage? currentStage,
  });
}
```

### 4.3 新規ビジネスロジック層クラス

#### SetupManager サービス（新規）
```dart
class SetupManager {
  late BattleLoadout _currentLoadout;
  late List<Prime> _originalSelection; // 復元用の元データ
  
  BattleLoadout createLoadout(Stage stage, List<Prime> selectedPrimes) {
    if (selectedPrimes.length > stage.slotLimit) {
      throw SetupException(
        'Too many primes selected. Limit: ${stage.slotLimit}, Selected: ${selectedPrimes.length}'
      );
    }
    
    _originalSelection = List<Prime>.from(selectedPrimes);
    _currentLoadout = BattleLoadout(
      selectedPrimes: selectedPrimes,
      maxSlots: stage.slotLimit,
      targetStage: stage,
      createdAt: DateTime.now(),
    );
    
    return _currentLoadout;
  }
  
  SetupValidationResult validateSelection(
    Stage stage, 
    List<Prime> selectedPrimes,
    List<Prime> inventory
  ) {
    // スロット制限チェック
    if (selectedPrimes.length > stage.slotLimit) {
      return SetupValidationResult.invalid(
        'スロット制限を超えています (${selectedPrimes.length}/${stage.slotLimit})'
      );
    }
    
    // 空の選択チェック
    if (selectedPrimes.isEmpty) {
      return SetupValidationResult.invalid('素数を1つ以上選択してください');
    }
    
    // インベントリ存在チェック
    for (final selectedPrime in selectedPrimes) {
      final inventoryPrime = inventory.firstWhere(
        (p) => p.value == selectedPrime.value,
        orElse: () => const Prime(value: 0, count: 0, firstObtained: DateTime.now()),
      );
      
      if (inventoryPrime.count < selectedPrime.count) {
        return SetupValidationResult.invalid(
          '素数${selectedPrime.value}の所持数が不足しています'
        );
      }
    }
    
    return SetupValidationResult.valid();
  }
  
  BattleLoadout addPrimeToLoadout(Prime prime) {
    if (_currentLoadout.isFull) {
      throw SetupException('持ち込みスロットが満杯です');
    }
    
    _currentLoadout = _currentLoadout.addPrime(prime);
    return _currentLoadout;
  }
  
  BattleLoadout removePrimeFromLoadout(Prime prime) {
    _currentLoadout = _currentLoadout.removePrime(prime);
    return _currentLoadout;
  }
  
  // 戦闘終了後の復元処理
  BattleLoadout restoreOriginalLoadout() {
    _currentLoadout = _currentLoadout.copyWith(
      selectedPrimes: List<Prime>.from(_originalSelection),
    );
    return _currentLoadout;
  }
  
  BattleLoadout get currentLoadout => _currentLoadout;
  List<Prime> get originalSelection => List<Prime>.from(_originalSelection);
}

class SetupValidationResult {
  final bool isValid;
  final String? errorMessage;
  
  const SetupValidationResult._(this.isValid, this.errorMessage);
  
  const SetupValidationResult.valid() : this._(true, null);
  const SetupValidationResult.invalid(String message) : this._(false, message);
}
```

#### StageManager サービス（新規）
```dart
class StageManager {
  static const List<Stage> _defaultStages = [
    Stage(
      stageNumber: 1,
      name: 'チュートリアル',
      description: '基本的な戦闘を学ぼう',
      slotLimit: 3,
      baseTimeSeconds: 60,
      type: StageType.tutorial,
      difficulty: StageDifficulty.easy,
      rewards: [
        StageReward(type: RewardType.prime, value: 7),
        StageReward(type: RewardType.unlockStage, value: 2),
      ],
      isUnlocked: true,
    ),
    Stage(
      stageNumber: 2,
      name: '初級バトル',
      description: '小さな合成数を倒そう',
      slotLimit: 4,
      baseTimeSeconds: 90,
      type: StageType.normal,
      difficulty: StageDifficulty.easy,
      rewards: [
        StageReward(type: RewardType.prime, value: 11),
        StageReward(type: RewardType.unlockStage, value: 3),
      ],
      isUnlocked: false,
    ),
    Stage(
      stageNumber: 3,
      name: '中級バトル',
      description: '中程度の敵に挑戦',
      slotLimit: 5,
      baseTimeSeconds: 120,
      type: StageType.normal,
      difficulty: StageDifficulty.normal,
      rewards: [
        StageReward(type: RewardType.prime, value: 13),
        StageReward(type: RewardType.prime, value: 17),
        StageReward(type: RewardType.unlockStage, value: 4),
      ],
      isUnlocked: false,
    ),
    Stage(
      stageNumber: 4,
      name: '上級バトル',
      description: '大きな合成数との戦い',
      slotLimit: 6,
      baseTimeSeconds: 150,
      type: StageType.normal,
      difficulty: StageDifficulty.hard,
      rewards: [
        StageReward(type: RewardType.prime, value: 19),
        StageReward(type: RewardType.prime, value: 23),
        StageReward(type: RewardType.unlockStage, value: 5),
      ],
      isUnlocked: false,
    ),
    Stage(
      stageNumber: 5,
      name: '累乗敵チャレンジ',
      description: '特殊な累乗敵との戦い',
      slotLimit: 7,
      baseTimeSeconds: 180,
      type: StageType.challenge,
      difficulty: StageDifficulty.extreme,
      rewards: [
        StageReward(type: RewardType.prime, value: 29, count: 2),
        StageReward(type: RewardType.prime, value: 31, count: 2),
      ],
      isUnlocked: false,
    ),
  ];
  
  List<Stage> getAllStages() => List<Stage>.from(_defaultStages);
  
  List<Stage> getUnlockedStages() {
    return _defaultStages.where((stage) => stage.isUnlocked).toList();
  }
  
  Stage? getStage(int stageNumber) {
    try {
      return _defaultStages.firstWhere((stage) => stage.stageNumber == stageNumber);
    } catch (e) {
      return null;
    }
  }
  
  bool canChallengeStage(Stage stage, List<Prime> inventory) {
    return stage.isUnlocked && 
           inventory.where((p) => p.count > 0).length >= stage.slotLimit;
  }
  
  Stage unlockStage(int stageNumber) {
    final stageIndex = _defaultStages.indexWhere(
      (stage) => stage.stageNumber == stageNumber
    );
    
    if (stageIndex == -1) {
      throw StageException('Stage $stageNumber not found');
    }
    
    return _defaultStages[stageIndex].copyWith(isUnlocked: true);
  }
  
  List<StageReward> calculateRewards(Stage stage, BattleResult result) {
    return result.when(
      victory: (_, rewardPrime) => [
        ...stage.rewards,
        StageReward(type: RewardType.prime, value: rewardPrime),
      ],
      powerVictory: (_, rewardPrime, count) => [
        ...stage.rewards,
        StageReward(type: RewardType.prime, value: rewardPrime, count: count),
      ],
      // 他のケースでは基本報酬のみ
      escape: (_) => [],
      timeOut: (_) => [],
      wrongClaim: (_, __) => [],
      continue_: (_, __) => [],
      awaitingVictoryClaim: (_, __) => [],
      error: (_) => [],
    );
  }
}
```

#### RestoreManager サービス（新規）
```dart
class RestoreManager {
  // 戦闘終了後の自動復元処理
  Future<RestoreResult> restoreAfterBattle(
    BattleState battleState,
    Inventory originalInventory,
  ) async {
    try {
      // アニメーション再生
      await _playRestoreAnimation();
      
      // 持ち込み素数を元の状態に復元
      final restoredLoadout = battleState.loadout?.restoreAll();
      
      // インベントリは変更なし（非消費型のため）
      final restoredInventory = originalInventory;
      
      // 復元完了状態を作成
      final restoredState = battleState.copyWith(
        loadout: restoredLoadout,
        usedPrimes: [],
        status: BattleStatus.waiting,
      );
      
      return RestoreResult.success(
        restoredState: restoredState,
        restoredInventory: restoredInventory,
        message: '素数が復元されました',
      );
      
    } catch (e) {
      return RestoreResult.failure('復元に失敗しました: ${e.toString()}');
    }
  }
  
  Future<void> _playRestoreAnimation() async {
    // 復元アニメーション実装
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}

@freezed
class RestoreResult with _$RestoreResult {
  const factory RestoreResult.success({
    required BattleState restoredState,
    required Inventory restoredInventory,
    required String message,
  }) = _RestoreSuccess;
  
  const factory RestoreResult.failure(String message) = _RestoreFailure;
}
```

### 4.4 更新されたプレゼンテーション層クラス

#### SetupNotifier (Riverpod)（新規）
```dart
class SetupNotifier extends StateNotifier<SetupState> {
  final SetupManager _setupManager;
  final StageManager _stageManager;
  final Ref _ref;
  
  SetupNotifier(this._setupManager, this._stageManager, this._ref) 
    : super(const SetupState());
  
  void initializeSetup(Stage stage) {
    state = state.copyWith(
      targetStage: stage,
      maxSlots: stage.slotLimit,
      selectedPrimes: [],
      isValid: false,
    );
  }
  
  void addPrimeToLoadout(Prime prime) {
    final inventory = _ref.read(inventoryProvider);
    
    // 選択可能性チェック
    if (state.selectedPrimes.length >= state.maxSlots) {
      state = state.copyWith(
        errorMessage: 'スロット上限に達しています (${state.maxSlots}個)',
      );
      return;
    }
    
    // インベントリ存在チェック
    if (!inventory.hasPrime(prime.value)) {
      state = state.copyWith(
        errorMessage: '素数${prime.value}を所持していません',
      );
      return;
    }
    
    try {
      final newSelection = [...state.selectedPrimes, prime];
      final validation = _setupManager.validateSelection(
        state.targetStage!,
        newSelection,
        inventory.primes,
      );
      
      if (validation.isValid) {
        state = state.copyWith(
          selectedPrimes: newSelection,
          isValid: newSelection.isNotEmpty,
          errorMessage: null,
        );
      } else {
        state = state.copyWith(
          errorMessage: validation.errorMessage,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }
  
  void removePrimeFromLoadout(Prime prime) {
    final newSelection = List<Prime>.from(state.selectedPrimes);
    newSelection.remove(prime);
    
    state = state.copyWith(
      selectedPrimes: newSelection,
      isValid: newSelection.isNotEmpty,
      errorMessage: null,
    );
  }
  
  BattleLoadout? createLoadout() {
    if (!state.isValid || state.targetStage == null) return null;
    
    try {
      final loadout = _setupManager.createLoadout(
        state.targetStage!,
        state.selectedPrimes,
      );
      
      state = state.copyWith(
        createdLoadout: loadout,
        setupComplete: true,
      );
      
      return loadout;
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
      return null;
    }
  }
  
  void resetSetup() {
    state = const SetupState();
  }
}

@freezed
class SetupState with _$SetupState {
  const factory SetupState({
    Stage? targetStage,
    @Default([]) List<Prime> selectedPrimes,
    @Default(0) int maxSlots,
    @Default(false) bool isValid,
    @Default(false) bool setupComplete,
    BattleLoadout? createdLoadout,
    String? errorMessage,
  }) = _SetupState;
}
```

#### 更新されたBattleNotifier（持ち込みシステム対応）
```dart
class BattleNotifier extends StateNotifier<BattleState> {
  final BattleEngine _battleEngine;
  final EnemyGenerator _enemyGenerator;
  final TimerManager _timerManager;
  final RestoreManager _restoreManager;
  final Ref _ref;
  
  BattleNotifier(
    this._battleEngine, 
    this._enemyGenerator, 
    this._timerManager,
    this._restoreManager,
    this._ref
  ) : super(const BattleState()) {
    _timerManager.timerStream.listen(_handleTimerUpdate);
  }
  
  void startBattleWithLoadout(BattleLoadout loadout) {
    final stage = loadout.targetStage;
    
    // 敵生成（ステージに応じた難易度）
    final enemy = _enemyGenerator.generateEnemyForStage(stage);
    
    // タイマー開始（ステージの基本時間 - 前回ペナルティ）
    final penaltyReduction = state.battlePenalties
        .fold(0, (sum, penalty) => sum + penalty.seconds);
    final adjustedTime = math.max(10, stage.baseTimeSeconds - penaltyReduction);
    
    _timerManager.startTimer(adjustedTime);
    
    state = state.copyWith(
      currentEnemy: enemy,
      loadout: loadout,
      currentStage: stage,
      status: BattleStatus.fighting,
      battleStartTime: DateTime.now(),
      turnCount: 0,
      usedPrimes: [],
      victoryClaim: null,
    );
  }
  
  Future<void> attack(Prime prime) async {
    if (state.currentEnemy == null || 
        state.timerState?.isExpired == true ||
        !state.canUsePrime(prime)) {
      return;
    }
    
    final result = _battleEngine.executeAttack(state.currentEnemy!, prime);
    
    await result.when(
      awaitingVictoryClaim: (newEnemy, usedPrime) async {
        await _playAttackAnimation(usedPrime.value);
        
        // 持ち込み素数から使用（一時的に減らす）
        state = state.copyWith(
          currentEnemy: newEnemy,
          loadout: state.loadout!.usePrime(usedPrime),
          usedPrimes: [...state.usedPrimes, usedPrime],
          turnCount: state.turnCount + 1,
          status: BattleStatus.fighting,
        );
      },
      continue_: (newEnemy, usedPrime) async {
        await _playAttackAnimation(usedPrime.value);
        
        state = state.copyWith(
          currentEnemy: newEnemy,
          loadout: state.loadout!.usePrime(usedPrime),
          usedPrimes: [...state.usedPrimes, usedPrime],
          turnCount: state.turnCount + 1,
        );
      },
      error: (message) {
        _showError(message);
      },
      // 他のケースは後続処理で使用
      victory: (_, __) => {},
      powerVictory: (_, __, ___) => {},
      wrongClaim: (_, __) => {},
      escape: (_) => {},
      timeOut: (_) => {},
    );
  }
  
  Future<void> claimVictory() async {
    if (state.currentEnemy == null || !state.canClaimVictory) return;
    
    final result = _battleEngine.processVictoryClaim(
      state.currentEnemy!, 
      state.currentEnemy!.currentValue
    );
    
    await result.when(
      victory: (defeatedEnemy, rewardPrime) async {
        await _playVictoryAnimation();
        await _completeBattle(rewardPrime, 1);
      },
      powerVictory: (defeatedEnemy, rewardPrime, rewardCount) async {
        await _playPowerVictoryAnimation();
        await _completeBattle(rewardPrime, rewardCount);
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
      awaitingVictoryClaim: (_, __) => {},
      continue_: (_, __) => {},
      error: (_) => {},
      escape: (_) => {},
      timeOut: (_) => {},
    );
  }
  
  Future<void> _completeBattle(int rewardPrime, int rewardCount) async {
    // 勝利報酬をインベントリに追加
    for (int i = 0; i < rewardCount; i++) {
      _ref.read(inventoryProvider.notifier).addPrime(Prime(
        value: rewardPrime,
        count: 1,
        firstObtained: DateTime.now(),
      ));
    }
    
    state = state.copyWith(
      status: BattleStatus.victory,
      victoryClaim: VictoryClaim(
        claimedValue: state.currentEnemy!.currentValue,
        claimedAt: DateTime.now(),
        isCorrect: true,
        rewardPrime: rewardPrime,
      ),
    );
    
    _timerManager.stopTimer();
    
    // 戦闘終了後の自動復元処理
    await _restoreBattleLoadout();
    
    _ref.read(achievementProvider.notifier).checkAchievements();
  }
  
  Future<void> _restoreBattleLoadout() async {
    final originalInventory = _ref.read(inventoryProvider);
    
    final restoreResult = await _restoreManager.restoreAfterBattle(
      state,
      originalInventory,
    );
    
    restoreResult.when(
      success: (restoredState, restoredInventory, message) {
        state = restoredState;
        _showRestoreMessage(message);
      },
      failure: (message) {
        _showError(message);
      },
    );
  }
  
  void escape() {
    final result = _battleEngine.processEscape();
    
    result.when(
      escape: (penalty) async {
        state = state.copyWith(
          status: BattleStatus.escape,
          battlePenalties: [...state.battlePenalties, penalty],
        );
        
        _timerManager.stopTimer();
        await _restoreBattleLoadout();
        
        // 新しい戦闘への遷移は画面レベルで制御
      },
      // 他のケースは使用されない
      victory: (_, __) => {},
      powerVictory: (_, __, ___) => {},
      wrongClaim: (_, __) => {},
      awaitingVictoryClaim: (_, __) => {},
      continue_: (_, __) => {},
      error: (_) => {},
      timeOut: (_) => {},
    );
  }
  
  void _handleTimerUpdate(TimerState timerState) {
    state = state.copyWith(timerState: timerState);
    
    if (timerState.isExpired && state.status == BattleStatus.fighting) {
      final result = _battleEngine.processTimeOut();
      
      result.when(
        timeOut: (penalty) async {
          state = state.copyWith(
            status: BattleStatus.timeOut,
            battlePenalties: [...state.battlePenalties, penalty],
          );
          
          await _restoreBattleLoadout();
        },
        // 他のケースは使用されない
        victory: (_, __) => {},
        powerVictory: (_, __, ___) => {},
        wrongClaim: (_, __) => {},
        awaitingVictoryClaim: (_, __) => {},
        continue_: (_, __) => {},
        error: (_) => {},
        escape: (_) => {},
      );
    }
  }
  
  // アニメーション・メッセージ関連メソッド
  Future<void> _playAttackAnimation(int primeValue) async {
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
  
  void _showRestoreMessage(String message) {
    // 復元メッセージ表示実装
  }
  
  @override
  void dispose() {
    _timerManager.dispose();
    super.dispose();
  }
}
```

### 4.5 プロバイダー定義（完全版）

```dart
// ==================== Core Providers ====================
final setupManagerProvider = Provider<SetupManager>((ref) => SetupManager());
final stageManagerProvider = Provider<StageManager>((ref) => StageManager());
final restoreManagerProvider = Provider<RestoreManager>((ref) => RestoreManager());

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
    ref.read(restoreManagerProvider),
    ref,
  );
});

// ==================== Computed Providers ====================
final canAddToBattleLoadoutProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  return setup.selectedPrimes.length < setup.maxSlots;
});

final canStartBattleProvider = Provider<bool>((ref) {
  final setup = ref.watch(setupProvider);
  return setup.isValid && setup.selectedPrimes.isNotEmpty;
});

final availablePrimesProvider = Provider<List<Prime>>((ref) {
  final inventory = ref.watch(inventoryProvider);
  return inventory.availablePrimes;
});

final unlockedStagesProvider = Provider<List<Stage>>((ref) {
  final stageState = ref.watch(stageProvider);
  return stageState.stages.where((stage) => stage.isUnlocked).toList();
});

final currentLoadoutInfoProvider = Provider<String>((ref) {
  final setup = ref.watch(setupProvider);
  return '${setup.selectedPrimes.length}/${setup.maxSlots}';
});

// ==================== Stream Providers ====================
final timerProvider = StreamProvider<TimerState>((ref) {
  final timerManager = ref.read(timerManagerProvider);
  return timerManager.timerStream;
});
```

## 5. 重要な設計判断（持ち込みシステム対応）

### 5.1 非消費型インベントリの実装
- **永続性**: 素数は戦闘で使用されても在庫から消失しない
- **復元システム**: 戦闘終了時に持ち込み素数を自動復元
- **教育的価値**: 試行錯誤を促進し、リソース枯渇による詰みを回避

### 5.2 持ち込みシステムの設計原則
- **事前選択**: ステージ挑戦前に戦略的な素数選択
- **スロット制限**: ステージごとの持ち込み上限で難易度調整
- **視覚的フィードバック**: UI で選択状態・制限を明確に表示

### 5.3 ゲームフロー設計
```
ステージ選択 → 持ち込み設定 → 戦闘 → 自動復元 → 結果表示
     ↓           ↓         ↓       ↓         ↓
  制限確認 → 素数選択 → 制限使用 → 全復元 → 次ステージ解放
```

### 5.4 新機能の統合性
- **既存システム**: タイマー・勝利判定・累乗敵システムとの共存
- **バランス調整**: スロット制限によるゲームバランス維持
- **教育効果**: 戦略的思考と素数理解の促進

この設計により、ゲームの教育的価値を保ちながら、プレイヤーの詰み状態を回避し、より戦略的で楽しいゲーム体験を提供できます。持ち込みシステムにより、各ステージで異なる戦略を試すことができ、リプレイ価値も向上します。