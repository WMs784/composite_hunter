# 合成数ハンター システム設計書（最新版）

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
│  │  Tutorial   │  │   Timer     │  │  Victory    │     │
│  │   Screen    │  │  Widget     │  │  Dialog     │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                     State Management                    │
│             (Riverpod Providers & Notifiers)            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │  Inventory  │  │    Game     │     │
│  │  Provider   │  │  Provider   │  │  Provider   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Timer     │  │   Enemy     │  │ Achievement │     │
│  │  Provider   │  │  Provider   │  │  Provider   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│                    Business Logic Layer                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Battle    │  │  Inventory  │  │   Enemy     │     │
│  │   Engine    │  │  Manager    │  │ Generator   │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │    Prime    │  │   Timer     │  │  Victory    │     │
│  │ Calculator  │  │  Manager    │  │ Validator   │     │
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

### 1.2 データフロー図（制限時間・勝利判定含む）
```
User Action → Widget → Provider → Business Logic → Data Layer
     ↑                     ↓                         │
     └── UI Update ← Timer/Victory State ←───────────┘
                     ↓
               Penalty/Reward
```

## 2. 状態管理戦略

### 2.1 Riverpod選択理由

#### ✅ 採用理由
1. **コンパイル時安全性**: Provider の型安全性が保証される
2. **テスト容易性**: DI が簡単で、モックの注入が容易
3. **パフォーマンス**: 必要な部分のみリビルドされる最適化
4. **将来性**: Flutter チームが推奨する現代的な状態管理
5. **複雑な状態管理**: タイマー・勝利判定・ペナルティの複合状態に最適
6. **時間系処理**: ストリーム・非同期処理との親和性が高い

#### ❌ Provider を選ばない理由
- グローバル状態での型安全性の欠如
- テスト時のプロバイダー注入の複雑さ
- タイマーなど複雑な状態管理が困難

#### ❌ Bloc を選ばない理由
- 小規模アプリには過度に複雑
- ボイラープレートコードが多い
- 1人開発には学習コストが高い

### 2.2 Riverpod実装戦略

#### 状態管理パターン
```dart
// 1. タイマー状態 - StreamProvider
final timerProvider = StreamProvider<int>((ref) {
  return TimerManager().timerStream;
});

// 2. 戦闘状態 - StateNotifierProvider
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>(
  (ref) => BattleNotifier(ref),
);

// 3. 勝利判定 - StateProvider
final victoryClaimProvider = StateProvider<bool>((ref) => false);

// 4. ペナルティ計算 - Provider (computed)
final timeReductionProvider = Provider<int>((ref) {
  final battleHistory = ref.watch(battleProvider);
  return PenaltyCalculator.calculateTimeReduction(battleHistory.penalties);
});

// 5. 累乗敵検出 - Provider (computed)
final isPowerEnemyProvider = Provider<bool>((ref) {
  final enemy = ref.watch(battleProvider).currentEnemy;
  return enemy != null && PowerEnemyDetector.isPowerEnemy(enemy.value);
});
```

#### プロバイダー階層（更新版）
```
App Level Providers:
├── gameDataProvider (永続化データ)
├── settingsProvider (アプリ設定)
├── achievementProvider (実績管理)
└── globalTimerProvider (アプリ全体タイマー)

Screen Level Providers:
├── battleProvider (戦闘状態)
├── inventoryProvider (素数管理)
├── enemyProvider (敵生成・累乗敵含む)
├── timerProvider (制限時間管理)
└── victoryValidationProvider (勝利判定)

UI Level Providers:
├── animationProvider (アニメーション状態)
├── penaltyDisplayProvider (ペナルティ表示)
└── uiStateProvider (UI表示状態)
```

## 3. ディレクトリ構造

### 3.1 全体構造（更新版）
```
lib/
├── main.dart
├── app.dart
│
├── core/                     # 共通機能
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── game_constants.dart
│   │   ├── timer_constants.dart
│   │   └── ui_constants.dart
│   ├── exceptions/
│   │   ├── game_exception.dart
│   │   ├── timer_exception.dart
│   │   ├── victory_exception.dart
│   │   └── data_exception.dart
│   ├── extensions/
│   │   ├── int_extensions.dart
│   │   ├── list_extensions.dart
│   │   └── duration_extensions.dart
│   ├── utils/
│   │   ├── math_utils.dart
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
│   │   ├── battle_result_model.dart
│   │   ├── timer_state_model.dart
│   │   ├── penalty_record_model.dart
│   │   └── game_data_model.dart
│   ├── repositories/
│   │   ├── game_repository.dart
│   │   ├── inventory_repository.dart
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
│       ├── battle_mapper.dart
│       └── timer_mapper.dart
│
├── domain/                   # ビジネスロジック層
│   ├── entities/
│   │   ├── prime.dart
│   │   ├── enemy.dart
│   │   ├── power_enemy.dart
│   │   ├── battle_state.dart
│   │   ├── timer_state.dart
│   │   ├── penalty_state.dart
│   │   ├── victory_claim.dart
│   │   └── inventory.dart
│   ├── usecases/
│   │   ├── battle_usecase.dart
│   │   ├── inventory_usecase.dart
│   │   ├── enemy_generation_usecase.dart
│   │   ├── timer_management_usecase.dart
│   │   ├── victory_validation_usecase.dart
│   │   └── penalty_calculation_usecase.dart
│   ├── repositories/
│   │   └── game_repository_interface.dart
│   └── services/
│       ├── battle_engine.dart
│       ├── prime_calculator.dart
│       ├── enemy_generator.dart
│       ├── power_enemy_detector.dart
│       ├── timer_manager.dart
│       ├── victory_validator.dart
│       └── penalty_calculator.dart
│
├── presentation/             # プレゼンテーション層
│   ├── providers/
│   │   ├── battle_provider.dart
│   │   ├── inventory_provider.dart
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
│   │   │       └── victory_tutorial_widget.dart
│   │   ├── battle/
│   │   │   ├── battle_screen.dart
│   │   │   └── widgets/
│   │   │       ├── enemy_widget.dart
│   │   │       ├── power_enemy_widget.dart
│   │   │       ├── prime_grid_widget.dart
│   │   │       ├── timer_widget.dart
│   │   │       ├── victory_claim_button.dart
│   │   │       ├── action_buttons_widget.dart
│   │   │       └── battle_animation_widget.dart
│   │   ├── inventory/
│   │   │   ├── inventory_screen.dart
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
│   │   │   ├── loading_widget.dart
│   │   │   └── error_widget.dart
│   │   ├── animations/
│   │   │   ├── number_change_animation.dart
│   │   │   ├── attack_effect_animation.dart
│   │   │   ├── victory_animation.dart
│   │   │   ├── penalty_animation.dart
│   │   │   └── power_enemy_animation.dart
│   │   └── dialogs/
│   │       ├── battle_result_dialog.dart
│   │       ├── victory_validation_dialog.dart
│   │       ├── penalty_warning_dialog.dart
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
    │   ├── timer_test.dart
    │   ├── victory_validator_test.dart
    │   └── power_enemy_test.dart
    ├── widget/
    └── integration/
```

## 4. 主要クラス設計

### 4.1 ドメイン層クラス（更新版）

#### Prime エンティティ（変更なし）
```dart
class Prime {
  final int value;
  final int count;
  final DateTime firstObtained;
  final int usageCount;
  
  const Prime({
    required this.value,
    required this.count,
    required this.firstObtained,
    this.usageCount = 0,
  });
  
  bool get isPrime => PrimeCalculator.isPrime(value);
  
  Prime copyWith({
    int? value,
    int? count,
    DateTime? firstObtained,
    int? usageCount,
  });
  
  @override
  bool operator ==(Object other);
  
  @override
  int get hashCode;
}
```

#### Enemy エンティティ（累乗敵対応）
```dart
class Enemy {
  final int currentValue;
  final int originalValue;
  final EnemyType type;
  final List<int> primeFactors;
  final bool isPowerEnemy; // 累乗敵フラグ
  final int? powerBase;    // 累乗の底（2^3なら2）
  final int? powerExponent; // 累乗の指数（2^3なら3）
  
  const Enemy({
    required this.currentValue,
    required this.originalValue,
    required this.type,
    required this.primeFactors,
    this.isPowerEnemy = false,
    this.powerBase,
    this.powerExponent,
  });
  
  bool canBeAttackedBy(int prime) {
    return currentValue % prime == 0;
  }
  
  Enemy attack(int prime) {
    if (!canBeAttackedBy(prime)) {
      throw InvalidAttackException('Cannot attack $currentValue with $prime');
    }
    
    return copyWith(currentValue: currentValue ~/ prime);
  }
  
  bool get isDefeated => PrimeCalculator.isPrime(currentValue);
  
  // 累乗敵の報酬計算
  int get powerRewardCount => isPowerEnemy && powerExponent != null ? powerExponent! : 1;
  int get powerRewardPrime => isPowerEnemy && powerBase != null ? powerBase! : currentValue;
  
  Enemy copyWith({
    int? currentValue,
    int? originalValue,
    EnemyType? type,
    List<int>? primeFactors,
    bool? isPowerEnemy,
    int? powerBase,
    int? powerExponent,
  });
}

enum EnemyType { small, medium, large, power, special }
```

#### TimerState エンティティ（新規）
```dart
class TimerState {
  final int remainingSeconds;
  final int originalSeconds;
  final bool isActive;
  final bool isWarning; // 残り10秒以下
  final List<TimePenalty> penalties;
  
  const TimerState({
    required this.remainingSeconds,
    required this.originalSeconds,
    this.isActive = false,
    this.isWarning = false,
    this.penalties = const [],
  });
  
  bool get isExpired => remainingSeconds <= 0;
  bool get shouldShowWarning => remainingSeconds <= 10 && isActive;
  
  int get totalPenaltySeconds {
    return penalties.fold(0, (sum, penalty) => sum + penalty.seconds);
  }
  
  TimerState applyPenalty(TimePenalty penalty) {
    return copyWith(
      remainingSeconds: math.max(0, remainingSeconds - penalty.seconds),
      penalties: [...penalties, penalty],
    );
  }
  
  TimerState tick() {
    if (!isActive || remainingSeconds <= 0) return this;
    
    return copyWith(
      remainingSeconds: remainingSeconds - 1,
      isWarning: remainingSeconds - 1 <= 10,
    );
  }
  
  TimerState copyWith({
    int? remainingSeconds,
    int? originalSeconds,
    bool? isActive,
    bool? isWarning,
    List<TimePenalty>? penalties,
  });
}

class TimePenalty {
  final int seconds;
  final PenaltyType type;
  final DateTime appliedAt;
  
  const TimePenalty({
    required this.seconds,
    required this.type,
    required this.appliedAt,
  });
}

enum PenaltyType { escape, wrongVictoryClaim, timeOut }
```

#### VictoryClaim エンティティ（新規）
```dart
class VictoryClaim {
  final int claimedValue;
  final DateTime claimedAt;
  final bool isCorrect;
  final int? rewardPrime;
  
  const VictoryClaim({
    required this.claimedValue,
    required this.claimedAt,
    required this.isCorrect,
    this.rewardPrime,
  });
  
  VictoryClaim copyWith({
    int? claimedValue,
    DateTime? claimedAt,
    bool? isCorrect,
    int? rewardPrime,
  });
}
```

#### BattleState エンティティ（タイマー・勝利判定対応）
```dart
class BattleState {
  final Enemy? currentEnemy;
  final List<Prime> usedPrimes;
  final BattleStatus status;
  final int turnCount;
  final DateTime? battleStartTime;
  final TimerState? timerState;
  final VictoryClaim? victoryClaim;
  final List<TimePenalty> battlePenalties;
  
  const BattleState({
    this.currentEnemy,
    this.usedPrimes = const [],
    this.status = BattleStatus.waiting,
    this.turnCount = 0,
    this.battleStartTime,
    this.timerState,
    this.victoryClaim,
    this.battlePenalties = const [],
  });
  
  bool canFight(List<Prime> inventory) {
    if (currentEnemy == null || timerState?.isExpired == true) return false;
    return true; // 戦闘可能性判定は削除
  }
  
  bool get canClaimVictory {
    return currentEnemy != null && 
           timerState?.isActive == true && 
           !timerState!.isExpired;
  }
  
  BattleState nextTurn(Prime usedPrime) {
    return copyWith(
      usedPrimes: [...usedPrimes, usedPrime],
      turnCount: turnCount + 1,
    );
  }
  
  BattleState applyTimePenalty(TimePenalty penalty) {
    return copyWith(
      timerState: timerState?.applyPenalty(penalty),
      battlePenalties: [...battlePenalties, penalty],
    );
  }
  
  BattleState copyWith({
    Enemy? currentEnemy,
    List<Prime>? usedPrimes,
    BattleStatus? status,
    int? turnCount,
    DateTime? battleStartTime,
    TimerState? timerState,
    VictoryClaim? victoryClaim,
    List<TimePenalty>? battlePenalties,
  });
}

enum BattleStatus { waiting, fighting, victory, escape, defeat, timeOut }
```

### 4.2 ビジネスロジック層クラス（更新版）

#### PowerEnemyDetector サービス（新規）
```dart
class PowerEnemyDetector {
  static bool isPowerEnemy(int value) {
    final factors = PrimeCalculator.factorize(value);
    
    // 全ての因子が同じ素数かチェック
    if (factors.isEmpty || factors.length < 2) return false;
    
    final firstFactor = factors.first;
    return factors.every((factor) => factor == firstFactor);
  }
  
  static PowerEnemyInfo? analyzePowerEnemy(int value) {
    if (!isPowerEnemy(value)) return null;
    
    final factors = PrimeCalculator.factorize(value);
    return PowerEnemyInfo(
      base: factors.first,
      exponent: factors.length,
      value: value,
    );
  }
  
  static Enemy createPowerEnemy(int base, int exponent) {
    final value = math.pow(base, exponent).toInt();
    
    return Enemy(
      currentValue: value,
      originalValue: value,
      type: EnemyType.power,
      primeFactors: List.filled(exponent, base),
      isPowerEnemy: true,
      powerBase: base,
      powerExponent: exponent,
    );
  }
}

class PowerEnemyInfo {
  final int base;
  final int exponent;
  final int value;
  
  const PowerEnemyInfo({
    required this.base,
    required this.exponent,
    required this.value,
  });
}
```

#### TimerManager サービス（新規）
```dart
class TimerManager {
  Timer? _timer;
  final StreamController<TimerState> _timerController = StreamController<TimerState>.broadcast();
  TimerState _currentState = const TimerState(remainingSeconds: 0, originalSeconds: 0);
  
  Stream<TimerState> get timerStream => _timerController.stream;
  TimerState get currentState => _currentState;
  
  void startTimer(int seconds) {
    stopTimer();
    
    _currentState = TimerState(
      remainingSeconds: seconds,
      originalSeconds: seconds,
      isActive: true,
    );
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentState = _currentState.tick();
      _timerController.add(_currentState);
      
      if (_currentState.isExpired) {
        stopTimer();
      }
    });
    
    _timerController.add(_currentState);
  }
  
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _currentState = _currentState.copyWith(isActive: false);
    _timerController.add(_currentState);
  }
  
  void applyPenalty(TimePenalty penalty) {
    _currentState = _currentState.applyPenalty(penalty);
    _timerController.add(_currentState);
  }
  
  void dispose() {
    _timer?.cancel();
    _timerController.close();
  }
  
  // 敵タイプに応じた基本時間取得
  static int getBaseTimeForEnemy(Enemy enemy) {
    if (enemy.originalValue <= 20) return 30;
    if (enemy.originalValue <= 100) return 60;
    return 90;
  }
}
```

#### VictoryValidator サービス（新規）
```dart
class VictoryValidator {
  static VictoryValidationResult validateVictoryClaim(int claimedValue) {
    final isPrime = PrimeCalculator.isPrime(claimedValue);
    
    return VictoryValidationResult(
      isValid: isPrime,
      claimedValue: claimedValue,
      rewardPrime: isPrime ? claimedValue : null,
      penalty: isPrime ? null : const TimePenalty(
        seconds: 10,
        type: PenaltyType.wrongVictoryClaim,
        appliedAt: DateTime.now(),
      ),
    );
  }
  
  static bool canClaimVictory(Enemy enemy, TimerState timerState) {
    return timerState.isActive && !timerState.isExpired;
  }
}

class VictoryValidationResult {
  final bool isValid;
  final int claimedValue;
  final int? rewardPrime;
  final TimePenalty? penalty;
  
  const VictoryValidationResult({
    required this.isValid,
    required this.claimedValue,
    this.rewardPrime,
    this.penalty,
  });
}
```

#### BattleEngine サービス（更新版）
```dart
class BattleEngine {
  static BattleResult executeAttack(Enemy enemy, Prime prime) {
    try {
      final newEnemy = enemy.attack(prime.value);
      
      if (newEnemy.isDefeated) {
        // 素数になったが、ユーザーが勝利宣言するまで待機
        return BattleResult.awaitingVictoryClaim(
          newEnemy: newEnemy,
          usedPrime: prime,
        );
      }
      
      return BattleResult.continue_(
        newEnemy: newEnemy,
        usedPrime: prime,
      );
      
    } catch (e) {
      return BattleResult.error(e.toString());
    }
  }
  
  static BattleResult processVictoryClaim(Enemy enemy, int claimedValue) {
    final validation = VictoryValidator.validateVictoryClaim(claimedValue);
    
    if (validation.isValid) {
      // 累乗敵の場合は特別報酬
      if (enemy.isPowerEnemy) {
        return BattleResult.powerVictory(
          defeatedEnemy: enemy,
          rewardPrime: enemy.powerRewardPrime,
          rewardCount: enemy.powerRewardCount,
        );
      } else {
        return BattleResult.victory(
          defeatedEnemy: enemy,
          rewardPrime: validation.rewardPrime!,
        );
      }
    } else {
      return BattleResult.wrongClaim(
        penalty: validation.penalty!,
        currentEnemy: enemy,
      );
    }
  }
  
  static BattleResult processEscape() {
    return BattleResult.escape(
      penalty: const TimePenalty(
        seconds: 10,
        type: PenaltyType.escape,
        appliedAt: DateTime.now(),
      ),
    );
  }
  
  static BattleResult processTimeOut() {
    return BattleResult.timeOut(
      penalty: const TimePenalty(
        seconds: 10,
        type: PenaltyType.timeOut,
        appliedAt: DateTime.now(),
      ),
    );
  }
}
```

#### EnemyGenerator サービス（累乗敵対応）
```dart
class EnemyGenerator {
  final Random _random = Random();
  
  Enemy generateEnemy(List<Prime> playerInventory, int playerLevel) {
    // 10%の確率で累乗敵を生成
    if (_random.nextDouble() < 0.1) {
      return _generatePowerEnemy(playerInventory, playerLevel);
    }
    
    return _generateNormalEnemy(playerInventory, playerLevel);
  }
  
  Enemy _generatePowerEnemy(List<Prime> playerInventory, int playerLevel) {
    final availablePrimes = _getAvailablePrimes(playerInventory);
    
    if (availablePrimes.isEmpty) {
      return _generateNormalEnemy(playerInventory, playerLevel); // フォールバック
    }
    
    // プレイヤーが持っている素数の中から選択
    final basePrime = availablePrimes[_random.nextInt(availablePrimes.length)];
    
    // 指数を2-4の範囲で選択（レベルに応じて調整）
    final maxExponent = math.min(4, 2 + (playerLevel ~/ 5));
    final exponent = 2 + _random.nextInt(maxExponent - 1);
    
    return PowerEnemyDetector.createPowerEnemy(basePrime, exponent);
  }
  
  Enemy _generateNormalEnemy(List<Prime> playerInventory, int playerLevel) {
    final availablePrimes = _getAvailablePrimes(playerInventory);
    final targetDifficulty = _calculateTargetDifficulty(playerLevel);
    
    int enemyValue;
    EnemyType enemyType;
    
    if (targetDifficulty < 10) {
      enemyValue = _generateSmallEnemy(availablePrimes);
      enemyType = EnemyType.small;
    } else if (targetDifficulty < 50) {
      enemyValue = _generateMediumEnemy(availablePrimes);
      enemyType = EnemyType.medium;
    } else {
      enemyValue = _generateLargeEnemy(availablePrimes);
      enemyType = EnemyType.large;
    }
    
    return Enemy(
      currentValue: enemyValue,
      originalValue: enemyValue,
      type: enemyType,
      primeFactors: PrimeCalculator.factorize(enemyValue),
      isPowerEnemy: false,
    );
  }
  
  int _generateSmallEnemy(List<int> availablePrimes) {
    // 2-3個の小さな素数の積（6-20範囲）
    if (availablePrimes.length < 2) return 6; // フォールバック
    
    final prime1 = availablePrimes[_random.nextInt(availablePrimes.length)];
    final prime2 = availablePrimes[_random.nextInt(availablePrimes.length)];
    
    final result = prime1 * prime2;
    return result <= 20 ? result : 6;
  }
  
  int _generateMediumEnemy(List<int> availablePrimes) {
    // 3-4個の素数の積（21-100範囲）
    if (availablePrimes.length < 2) return 21;
    
    int result = 1;
    final factorCount = 3 + _random.nextInt(2); // 3または4個
    
    for (int i = 0; i < factorCount; i++) {
      final prime = availablePrimes[_random.nextInt(availablePrimes.length)];
      result *= prime;
      if (result > 100) break;
    }
    
    return result.clamp(21, 100);
  }
  
  int _generateLargeEnemy(List<int> availablePrimes) {
    // 4-5個の素数の積（101-1000範囲）
    if (availablePrimes.length < 3) return 101;
    
    int result = 1;
    final factorCount = 4 + _random.nextInt(2); // 4または5個
    
    for (int i = 0; i < factorCount; i++) {
      final prime = availablePrimes[_random.nextInt(availablePrimes.length)];
      result *= prime;
      if (result > 1000) break;
    }
    
    return result.clamp(101, 1000);
  }
  
  int _calculateTargetDifficulty(int playerLevel) {
    return playerLevel * 2 + _random.nextInt(10);
  }
  
  List<int> _getAvailablePrimes(List<Prime> inventory) {
    return inventory
        .where((prime) => prime.count > 0)
        .map((prime) => prime.value)
        .toList();
  }
}
```

### 4.3 プレゼンテーション層クラス（更新版）

#### BattleNotifier (Riverpod)（大幅更新）
```dart
class BattleNotifier extends StateNotifier<BattleState> {
  final BattleEngine _battleEngine;
  final EnemyGenerator _enemyGenerator;
  final TimerManager _timerManager;
  final Ref _ref;
  
  BattleNotifier(
    this._battleEngine, 
    this._enemyGenerator, 
    this._timerManager,
    this._ref
  ) : super(const BattleState()) {
    // タイマーストリームを監視
    _timerManager.timerStream.listen(_handleTimerUpdate);
  }
  
  void startBattle() {
    final inventory = _ref.read(inventoryProvider);
    final playerLevel = _ref.read(gameProvider).level;
    
    final enemy = _enemyGenerator.generateEnemy(inventory.primes, playerLevel);
    final baseTime = TimerManager.getBaseTimeForEnemy(enemy);
    
    // 前回のペナルティを適用
    final penaltyReduction = state.battlePenalties
        .fold(0, (sum, penalty) => sum + penalty.seconds);
    final adjustedTime = math.max(10, baseTime - penaltyReduction);
    
    // タイマー開始
    _timerManager.startTimer(adjustedTime);
    
    state = state.copyWith(
      currentEnemy: enemy,
      status: BattleStatus.fighting,
      battleStartTime: DateTime.now(),
      turnCount: 0,
      usedPrimes: [],
      victoryClaim: null,
    );
  }
  
  Future<void> attack(Prime prime) async {
    if (state.currentEnemy == null || state.timerState?.isExpired == true) return;
    
    final result = _battleEngine.executeAttack(state.currentEnemy!, prime);
    
    await result.when(
      awaitingVictoryClaim: (newEnemy, usedPrime) async {
        // 攻撃アニメーション
        await _playAttackAnimation(usedPrime.value);
        
        // 素数使用
        _ref.read(inventoryProvider.notifier).usePrime(usedPrime);
        
        // 勝利宣言待ち状態
        state = state.copyWith(
          currentEnemy: newEnemy,
          usedPrimes: [...state.usedPrimes, usedPrime],
          turnCount: state.turnCount + 1,
          status: BattleStatus.fighting, // まだ勝利確定ではない
        );
      },
      continue_: (newEnemy, usedPrime) async {
        // 攻撃アニメーション
        await _playAttackAnimation(usedPrime.value);
        
        // 素数使用
        _ref.read(inventoryProvider.notifier).usePrime(usedPrime);
        
        // 状態更新
        state = state.copyWith(
          currentEnemy: newEnemy,
          usedPrimes: [...state.usedPrimes, usedPrime],
          turnCount: state.turnCount + 1,
        );
      },
      error: (message) {
        _showError(message);
      },
      // 他のケースは使用されない
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
        
        // 通常報酬
        _ref.read(inventoryProvider.notifier).addPrime(Prime(
          value: rewardPrime,
          count: 1,
          firstObtained: DateTime.now(),
        ));
        
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
        _ref.read(achievementProvider.notifier).checkAchievements();
      },
      powerVictory: (defeatedEnemy, rewardPrime, rewardCount) async {
        await _playPowerVictoryAnimation();
        
        // 累乗敵特別報酬
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
        _ref.read(achievementProvider.notifier).checkAchievements();
      },
      wrongClaim: (penalty, currentEnemy) async {
        await _playPenaltyAnimation();
        
        // ペナルティ適用
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
  
  void escape() {
    final result = _battleEngine.processEscape();
    
    result.when(
      escape: (penalty) {
        // 次回戦闘用ペナルティ記録
        state = state.copyWith(
          status: BattleStatus.escape,
          battlePenalties: [...state.battlePenalties, penalty],
        );
        
        _timerManager.stopTimer();
        
        // 新しい戦闘を開始（ペナルティ付き）
        Future.delayed(const Duration(milliseconds: 500), () {
          startBattle();
        });
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
    
    // タイムアウト処理
    if (timerState.isExpired && state.status == BattleStatus.fighting) {
      final result = _battleEngine.processTimeOut();
      
      result.when(
        timeOut: (penalty) {
          state = state.copyWith(
            status: BattleStatus.timeOut,
            battlePenalties: [...state.battlePenalties, penalty],
          );
          
          // 新しい戦闘を開始（ペナルティ付き）
          Future.delayed(const Duration(milliseconds: 1000), () {
            startBattle();
          });
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
  
  // アニメーション関連メソッド
  Future<void> _playAttackAnimation(int primeValue) async {
    // 攻撃アニメーション実装
    await Future.delayed(const Duration(milliseconds: 500));
  }
  
  Future<void> _playVictoryAnimation() async {
    // 勝利アニメーション実装
    await Future.delayed(const Duration(milliseconds: 1000));
  }
  
  Future<void> _playPowerVictoryAnimation() async {
    // 累乗敵勝利アニメーション実装
    await Future.delayed(const Duration(milliseconds: 1500));
  }
  
  Future<void> _playPenaltyAnimation() async {
    // ペナルティアニメーション実装
    await Future.delayed(const Duration(milliseconds: 800));
  }
  
  void _showError(String message) {
    // エラー表示実装
  }
  
  void _showPenaltyMessage(String message) {
    // ペナルティメッセージ表示実装
  }
  
  @override
  void dispose() {
    _timerManager.dispose();
    super.dispose();
  }
}

// プロバイダー定義（更新版）
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>((ref) {
  return BattleNotifier(
    ref.read(battleEngineProvider),
    ref.read(enemyGeneratorProvider),
    ref.read(timerManagerProvider),
    ref,
  );
});

// 追加プロバイダー
final timerProvider = StreamProvider<TimerState>((ref) {
  final timerManager = ref.read(timerManagerProvider);
  return timerManager.timerStream;
});

final canClaimVictoryProvider = Provider<bool>((ref) {
  final battleState = ref.watch(battleProvider);
  return battleState.canClaimVictory;
});

final isPowerEnemyProvider = Provider<bool>((ref) {
  final enemy = ref.watch(battleProvider).currentEnemy;
  return enemy?.isPowerEnemy ?? false;
});
```

### 4.4 拡張されたBattleResult（union type）

```dart
@freezed
class BattleResult with _$BattleResult {
  const factory BattleResult.victory({
    required Enemy defeatedEnemy,
    required int rewardPrime,
  }) = _Victory;
  
  const factory BattleResult.powerVictory({
    required Enemy defeatedEnemy,
    required int rewardPrime,
    required int rewardCount,
  }) = _PowerVictory;
  
  const factory BattleResult.continue_({
    required Enemy newEnemy,
    required Prime usedPrime,
  }) = _Continue;
  
  const factory BattleResult.awaitingVictoryClaim({
    required Enemy newEnemy,
    required Prime usedPrime,
  }) = _AwaitingVictoryClaim;
  
  const factory BattleResult.wrongClaim({
    required TimePenalty penalty,
    required Enemy currentEnemy,
  }) = _WrongClaim;
  
  const factory BattleResult.escape({
    required TimePenalty penalty,
  }) = _Escape;
  
  const factory BattleResult.timeOut({
    required TimePenalty penalty,
  }) = _TimeOut;
  
  const factory BattleResult.error(String message) = _Error;
}
```

## 5. 重要な設計判断

### 5.1 制限時間システムの実装戦略
- **StreamProvider**: リアルタイムタイマー更新
- **ペナルティ累積**: 逃走・誤判定でのペナルティ管理
- **状態同期**: タイマーと戦闘状態の密結合

### 5.2 勝利判定システムの設計
- **ユーザー主導**: システム自動判定を排除
- **教育重視**: 間違いから学ぶ仕組み
- **即座フィードバック**: ペナルティの視覚的表現

### 5.3 累乗敵システムの統合
- **検出アルゴリズム**: 効率的な累乗判定
- **報酬システム**: バランス調整された特別報酬
- **視覚的区別**: UI/UXでの明確な差別化

この設計により、要件定義書で定義された全ての新機能（制限時間、勝利判定、累乗敵、ペナルティシステム）を効率的に実装でき、高い保守性とテスト容易性を維持できます。