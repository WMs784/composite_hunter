# 合成数ハンター 詳細クラス設計書

## 1. クラス図

### 1.1 ドメイン層クラス図

```mermaid
classDiagram
    class Prime {
        +int value
        +int count
        +DateTime firstObtained
        +int usageCount
        +bool isPrime
        +Prime copyWith()
        +bool operator==()
        +int hashCode
    }

    class Enemy {
        +int currentValue
        +int originalValue
        +EnemyType type
        +List~int~ primeFactors
        +bool isPowerEnemy
        +int? powerBase
        +int? powerExponent
        +int powerRewardCount
        +int powerRewardPrime
        +bool isDefeated
        +bool canBeAttackedBy(int prime)
        +Enemy attack(int prime)
        +Enemy copyWith()
    }

    class TimerState {
        +int remainingSeconds
        +int originalSeconds
        +bool isActive
        +bool isWarning
        +List~TimePenalty~ penalties
        +bool isExpired
        +bool shouldShowWarning
        +int totalPenaltySeconds
        +TimerState applyPenalty(TimePenalty penalty)
        +TimerState tick()
        +TimerState copyWith()
    }

    class TimePenalty {
        +int seconds
        +PenaltyType type
        +DateTime appliedAt
    }

    class VictoryClaim {
        +int claimedValue
        +DateTime claimedAt
        +bool isCorrect
        +int? rewardPrime
        +VictoryClaim copyWith()
    }

    class BattleState {
        +Enemy? currentEnemy
        +List~Prime~ usedPrimes
        +BattleStatus status
        +int turnCount
        +DateTime? battleStartTime
        +TimerState? timerState
        +VictoryClaim? victoryClaim
        +List~TimePenalty~ battlePenalties
        +bool canFight(List~Prime~ inventory)
        +bool canClaimVictory
        +BattleState nextTurn(Prime usedPrime)
        +BattleState applyTimePenalty(TimePenalty penalty)
        +BattleState copyWith()
    }

    class Inventory {
        +List~Prime~ primes
        +int totalCount
        +int uniqueCount
        +List~Prime~ availablePrimes
        +Prime? getPrime(int value)
        +bool hasPrime(int value)
        +Inventory addPrime(Prime prime)
        +Inventory usePrime(Prime prime)
        +Inventory copyWith()
    }

    BattleState --> Enemy : contains
    BattleState --> Prime : uses
    BattleState --> TimerState : has
    BattleState --> VictoryClaim : has
    BattleState --> TimePenalty : tracks
    TimerState --> TimePenalty : applies
    Inventory --> Prime : manages

    <<enumeration>> EnemyType
    EnemyType : SMALL
    EnemyType : MEDIUM
    EnemyType : LARGE
    EnemyType : POWER
    EnemyType : SPECIAL

    <<enumeration>> BattleStatus
    BattleStatus : WAITING
    BattleStatus : FIGHTING
    BattleStatus : VICTORY
    BattleStatus : ESCAPE
    BattleStatus : DEFEAT
    BattleStatus : TIMEOUT

    <<enumeration>> PenaltyType
    PenaltyType : ESCAPE
    PenaltyType : WRONG_VICTORY_CLAIM
    PenaltyType : TIME_OUT
```

### 1.2 ビジネスロジック層クラス図

```mermaid
classDiagram
    class BattleEngine {
        +static BattleResult executeAttack(Enemy enemy, Prime prime)
        +static BattleResult processVictoryClaim(Enemy enemy, int claimedValue)
        +static BattleResult processEscape()
        +static BattleResult processTimeOut()
    }

    class EnemyGenerator {
        -Random _random
        +Enemy generateEnemy(List~Prime~ playerInventory, int playerLevel)
        -Enemy _generatePowerEnemy(List~Prime~ playerInventory, int playerLevel)
        -Enemy _generateNormalEnemy(List~Prime~ playerInventory, int playerLevel)
        -int _generateSmallEnemy(List~int~ availablePrimes)
        -int _generateMediumEnemy(List~int~ availablePrimes)
        -int _generateLargeEnemy(List~int~ availablePrimes)
        -int _calculateTargetDifficulty(int playerLevel)
        -List~int~ _getAvailablePrimes(List~Prime~ inventory)
    }

    class PowerEnemyDetector {
        +static bool isPowerEnemy(int value)
        +static PowerEnemyInfo? analyzePowerEnemy(int value)
        +static Enemy createPowerEnemy(int base, int exponent)
    }

    class PowerEnemyInfo {
        +int base
        +int exponent
        +int value
    }

    class TimerManager {
        -Timer? _timer
        -StreamController~TimerState~ _timerController
        -TimerState _currentState
        +Stream~TimerState~ timerStream
        +TimerState currentState
        +void startTimer(int seconds)
        +void stopTimer()
        +void applyPenalty(TimePenalty penalty)
        +void dispose()
        +static int getBaseTimeForEnemy(Enemy enemy)
    }

    class VictoryValidator {
        +static VictoryValidationResult validateVictoryClaim(int claimedValue)
        +static bool canClaimVictory(Enemy enemy, TimerState timerState)
    }

    class VictoryValidationResult {
        +bool isValid
        +int claimedValue
        +int? rewardPrime
        +TimePenalty? penalty
    }

    class PrimeCalculator {
        +static bool isPrime(int number)
        +static List~int~ factorize(int number)
        +static List~int~ sieveOfEratosthenes(int limit)
        +static bool isPowerOfPrime(int number)
    }

    BattleEngine --> VictoryValidator : uses
    EnemyGenerator --> PowerEnemyDetector : uses
    EnemyGenerator --> PrimeCalculator : uses
    PowerEnemyDetector --> PowerEnemyInfo : creates
    PowerEnemyDetector --> PrimeCalculator : uses
    VictoryValidator --> VictoryValidationResult : returns
    VictoryValidator --> PrimeCalculator : uses
    TimerManager --> TimerState : manages
```

### 1.3 プレゼンテーション層クラス図

```mermaid
classDiagram
    class BattleNotifier {
        -BattleEngine _battleEngine
        -EnemyGenerator _enemyGenerator
        -TimerManager _timerManager
        -Ref _ref
        +void startBattle()
        +Future~void~ attack(Prime prime)
        +Future~void~ claimVictory()
        +void escape()
        -void _handleTimerUpdate(TimerState timerState)
        -Future~void~ _playAttackAnimation(int primeValue)
        -Future~void~ _playVictoryAnimation()
        -Future~void~ _playPowerVictoryAnimation()
        -Future~void~ _playPenaltyAnimation()
        -void _showError(String message)
        -void _showPenaltyMessage(String message)
    }

    class InventoryNotifier {
        -InventoryRepository _repository
        +void addPrime(Prime prime)
        +void usePrime(Prime prime)
        +void removePrime(int value)
        +Future~void~ loadInventory()
        +Future~void~ saveInventory()
    }

    class GameNotifier {
        -GameRepository _repository
        +void levelUp()
        +void addExperience(int exp)
        +void updateStatistics(BattleResult result)
        +Future~void~ loadGameData()
        +Future~void~ saveGameData()
    }

    class TimerNotifier {
        -TimerManager _timerManager
        +void startTimer(int seconds)
        +void stopTimer()
        +void pauseTimer()
        +void resumeTimer()
        +Stream~TimerState~ get timerStream
    }

    class BattleScreen {
        +Widget build(BuildContext context)
        -Widget _buildEnemyDisplay()
        -Widget _buildPrimeGrid()
        -Widget _buildActionButtons()
        -Widget _buildTimerDisplay()
        -Widget _buildVictoryClaimButton()
    }

    class EnemyWidget {
        +Enemy enemy
        +Widget build(BuildContext context)
        -Widget _buildNormalEnemy()
        -Widget _buildPowerEnemy()
        -Widget _buildEnemyValue()
        -Widget _buildEnemyType()
    }

    class TimerWidget {
        +TimerState timerState
        +Widget build(BuildContext context)
        -Widget _buildTimeDisplay()
        -Widget _buildWarningIndicator()
        -Widget _buildProgressBar()
    }

    class VictoryClaimButton {
        +bool canClaim
        +VoidCallback onPressed
        +Widget build(BuildContext context)
    }

    BattleNotifier --> StateNotifier : extends
    InventoryNotifier --> StateNotifier : extends
    GameNotifier --> StateNotifier : extends
    TimerNotifier --> StateNotifier : extends
    
    BattleScreen --> BattleNotifier : watches
    BattleScreen --> EnemyWidget : contains
    BattleScreen --> TimerWidget : contains
    BattleScreen --> VictoryClaimButton : contains
    
    EnemyWidget --> Enemy : displays
    TimerWidget --> TimerState : displays
```

## 2. メソッド仕様

### 2.1 Enemy クラス

#### attack(int prime) → Enemy
```dart
/// 敵に素数で攻撃を行う
/// 
/// Parameters:
///   - prime: 攻撃に使用する素数
/// 
/// Returns:
///   - 攻撃後の敵の状態
/// 
/// Throws:
///   - InvalidAttackException: 攻撃できない素数の場合
/// 
/// Preconditions:
///   - prime > 0
///   - currentValue % prime == 0
/// 
/// Postconditions:
///   - 戻り値のcurrentValue == 元のcurrentValue / prime
///   - originalValueは変更されない
```

#### canBeAttackedBy(int prime) → bool
```dart
/// 指定された素数で攻撃可能かを判定
/// 
/// Parameters:
///   - prime: 判定対象の素数
/// 
/// Returns:
///   - true: 攻撃可能, false: 攻撃不可能
/// 
/// Complexity: O(1)
```

### 2.2 TimerManager クラス

#### startTimer(int seconds) → void
```dart
/// タイマーを開始する
/// 
/// Parameters:
///   - seconds: タイマーの初期秒数
/// 
/// Side Effects:
///   - 既存のタイマーが停止される
///   - 新しいタイマーストリームが開始される
///   - 毎秒timerStreamに更新が送信される
/// 
/// Preconditions:
///   - seconds > 0
```

#### applyPenalty(TimePenalty penalty) → void
```dart
/// ペナルティを適用してタイマーを減少させる
/// 
/// Parameters:
///   - penalty: 適用するペナルティ情報
/// 
/// Side Effects:
///   - remainingSecondsが減少される
///   - penaltiesリストに追加される
///   - timerStreamに更新が送信される
/// 
/// Postconditions:
///   - remainingSeconds >= 0 (負数にはならない)
```

### 2.3 BattleEngine クラス

#### executeAttack(Enemy enemy, Prime prime) → BattleResult
```dart
/// 戦闘での攻撃を実行する
/// 
/// Parameters:
///   - enemy: 攻撃対象の敵
///   - prime: 使用する素数
/// 
/// Returns:
///   - BattleResult: 攻撃結果のUnion Type
/// 
/// Business Rules:
///   - 攻撃後に敵が素数になった場合は勝利宣言待ち状態
///   - 攻撃後も合成数の場合は戦闘継続
///   - 攻撃不可能な素数の場合はエラー
```

#### processVictoryClaim(Enemy enemy, int claimedValue) → BattleResult
```dart
/// 勝利宣言を処理する
/// 
/// Parameters:
///   - enemy: 現在の敵
///   - claimedValue: プレイヤーが宣言した値
/// 
/// Returns:
///   - BattleResult: 勝利判定結果
/// 
/// Business Rules:
///   - claimedValueが素数の場合: 勝利
///   - 累乗敵の場合: 特別報酬付き勝利
///   - claimedValueが合成数の場合: ペナルティ
```

### 2.4 BattleNotifier クラス

#### attack(Prime prime) → Future<void>
```dart
/// 戦闘画面での攻撃アクションを処理
/// 
/// Parameters:
///   - prime: 使用する素数
/// 
/// Side Effects:
///   - 攻撃アニメーションを再生
///   - インベントリから素数を消費
///   - 戦闘状態を更新
///   - UI状態を更新
/// 
/// Async Operations:
///   - アニメーション再生 (500ms)
///   - 状態の永続化
```

#### claimVictory() → Future<void>
```dart
/// 勝利宣言を処理
/// 
/// Side Effects:
///   - 勝利判定を実行
///   - 正解の場合: 勝利アニメーション + 報酬付与
///   - 不正解の場合: ペナルティアニメーション + タイム減少
///   - タイマー停止
///   - 実績チェック
/// 
/// Preconditions:
///   - canClaimVictory == true
```

## 3. データフロー図

### 3.1 戦闘フロー

```mermaid
flowchart TD
    A[ユーザーが攻撃ボタン押下] --> B[BattleScreen]
    B --> C[BattleNotifier.attack]
    C --> D[BattleEngine.executeAttack]
    D --> E{攻撃結果判定}
    
    E -->|素数に到達| F[awaitingVictoryClaim]
    E -->|まだ合成数| G[continue]
    E -->|攻撃不可| H[error]
    
    F --> I[勝利宣言ボタン表示]
    G --> J[戦闘継続]
    H --> K[エラー表示]
    
    I --> L[ユーザーが勝利宣言]
    L --> M[BattleNotifier.claimVictory]
    M --> N[VictoryValidator.validateVictoryClaim]
    N --> O{勝利判定}
    
    O -->|正解| P[報酬付与]
    O -->|不正解| Q[ペナルティ適用]
    
    P --> R[勝利アニメーション]
    Q --> S[ペナルティアニメーション]
    
    R --> T[次の戦闘準備]
    S --> J
    
    J --> U[EnemyGenerator.generateEnemy]
    U --> V[新しい敵表示]
    V --> W[タイマー開始]
```

### 3.2 タイマーフロー

```mermaid
flowchart TD
    A[戦闘開始] --> B[TimerManager.startTimer]
    B --> C[Stream<TimerState>開始]
    C --> D[毎秒tick()]
    
    D --> E{残り時間チェック}
    E -->|時間あり| F[UI更新]
    E -->|10秒以下| G[警告表示]
    E -->|0秒| H[タイムアウト処理]
    
    F --> I[BattleNotifier状態更新]
    G --> I
    H --> J[BattleEngine.processTimeOut]
    
    J --> K[ペナルティ記録]
    K --> L[新戦闘開始]
    
    M[ペナルティ発生] --> N[TimerManager.applyPenalty]
    N --> O[remainingSeconds減少]
    O --> P[Stream更新]
    P --> I
```

### 3.3 累乗敵検出フロー

```mermaid
flowchart TD
    A[EnemyGenerator.generateEnemy] --> B{10%の確率}
    B -->|Yes| C[_generatePowerEnemy]
    B -->|No| D[_generateNormalEnemy]
    
    C --> E[プレイヤー所持素数確認]
    E --> F[PowerEnemyDetector.createPowerEnemy]
    F --> G[base^exponent計算]
    G --> H[Enemy作成]
    H --> I[isPowerEnemy = true]
    
    D --> J[通常の合成数生成]
    J --> K[Enemy作成]
    K --> L[isPowerEnemy = false]
    
    I --> M[累乗敵UI表示]
    L --> N[通常敵UI表示]
    
    M --> O[特別勝利処理]
    N --> P[通常勝利処理]
    
    O --> Q[base素数 × exponent個報酬]
    P --> R[currentValue素数 × 1個報酬]
```

## 4. UI画面遷移図（現在の実装ベース）

### 4.1 全体画面遷移

```mermaid
stateDiagram-v2
    [*] --> SplashScreen : アプリ起動
    
    SplashScreen --> TutorialScreen : 初回起動
    SplashScreen --> StageSelectScreen : 通常起動
    
    TutorialScreen --> StageSelectScreen : チュートリアル完了
    
    StageSelectScreen --> BattleScreen : ステージ選択
    StageSelectScreen --> BattleScreen : 練習モード選択
    StageSelectScreen --> InventoryScreen : インベントリタップ
    StageSelectScreen --> AchievementScreen : 実績タップ
    
    BattleScreen --> StageSelectScreen : 戻るボタン
    BattleScreen --> InventoryScreen : インベントリタップ
    BattleScreen --> AchievementScreen : 実績タップ
    BattleScreen --> StageClearScreen : ステージクリア
    BattleScreen --> GameOverScreen : ゲームオーバー
    
    StageClearScreen --> StageSelectScreen : 戻る
    GameOverScreen --> StageSelectScreen : 戻る
    
    InventoryScreen --> StageSelectScreen : 戻るボタン
    AchievementScreen --> StageSelectScreen : 戻るボタン
    
    state BattleScreen {
        [*] --> InitializingState
        InitializingState --> FightingState : 戦闘開始
        FightingState --> FightingState : 攻撃継続
        FightingState --> VictoryState : 勝利宣言成功
        FightingState --> EscapeState : 逃走選択
        FightingState --> TimeOutState : 時間切れ
        FightingState --> GameOverState : アイテム不足
        VictoryState --> InitializingState : 次の敵（継続）
        VictoryState --> ClearedState : ステージクリア
        EscapeState --> InitializingState : 次の敵（ペナルティ）
        TimeOutState --> InitializingState : 次の敵（ペナルティ）
        GameOverState --> [*] : ゲームオーバー画面
        ClearedState --> [*] : ステージクリア画面
    }
```

### 4.2 戦闘画面状態遷移詳細

```mermaid
stateDiagram-v2
    [*] --> Waiting : 初期状態
    
    Waiting --> Fighting : startBattle()
    note right of Fighting : タイマー開始\n敵表示\n素数グリッド表示
    
    Fighting --> Fighting : attack() - 継続
    note left of Fighting : 攻撃アニメーション\n敵の値更新\n素数消費
    
    Fighting --> AwaitingClaim : attack() - 素数到達
    note right of AwaitingClaim : 勝利宣言ボタン表示\nタイマー継続
    
    AwaitingClaim --> Victory : claimVictory() - 正解
    note right of Victory : 勝利アニメーション\n報酬付与\nタイマー停止
    
    AwaitingClaim --> Fighting : claimVictory() - 不正解
    note left of AwaitingClaim : ペナルティアニメーション\nタイマー減少
    
    Fighting --> Escape : escape()
    note left of Escape : ペナルティ記録\n次回時間短縮
    
    Fighting --> TimeOut : タイマー満了
    AwaitingClaim --> TimeOut : タイマー満了
    note right of TimeOut : ペナルティ記録\n次回時間短縮
    
    Victory --> Waiting : 次の戦闘準備
    Escape --> Waiting : 次の戦闘準備
    TimeOut --> Waiting : 次の戦闘準備
    
    state Victory {
        [*] --> NormalVictory
        [*] --> PowerVictory
        
        NormalVictory : 通常報酬\n素数 × 1個
        PowerVictory : 特別報酬\nbase素数 × exponent個
    }
```

### 4.3 累乗敵UI状態

```mermaid
stateDiagram-v2
    [*] --> EnemyGeneration : 敵生成開始
    
    EnemyGeneration --> NormalEnemy : 90%確率
    EnemyGeneration --> PowerEnemy : 10%確率
    
    state NormalEnemy {
        [*] --> DisplayNormal
        DisplayNormal : 通常の敵表示\n- 単色背景\n- 標準アイコン\n- 基本アニメーション
    }
    
    state PowerEnemy {
        [*] --> DisplayPower
        DisplayPower : 累乗敵表示\n- 虹色背景\n- 特別アイコン\n- 強化アニメーション\n- base^exponent表記
        
        DisplayPower --> PowerVictoryAnimation : 勝利時
        PowerVictoryAnimation : 特別勝利演出\n- 拡張アニメーション\n- 複数報酬表示\n- 特別効果音
    }
    
    NormalEnemy --> [*] : 戦闘終了
    PowerEnemy --> [*] : 戦闘終了
```

### 4.4 タイマーUI状態

```mermaid
stateDiagram-v2
    [*] --> Inactive : タイマー停止中
    
    Inactive --> Active : startTimer()
    note right of Active : 緑色表示\n通常カウントダウン
    
    Active --> Warning : 残り10秒
    note right of Warning : 橙色表示\n点滅アニメーション\n警告音
    
    Warning --> Critical : 残り5秒
    note right of Critical : 赤色表示\n激しい点滅\n緊急音
    
    Critical --> Expired : 残り0秒
    note right of Expired : グレーアウト\nタイムアウト表示
    
    Active --> PenaltyApplied : ペナルティ発生
    Warning --> PenaltyApplied : ペナルティ発生
    Critical --> PenaltyApplied : ペナルティ発生
    
    PenaltyApplied --> Active : 時間残存
    PenaltyApplied --> Warning : 警告範囲
    PenaltyApplied --> Critical : 危険範囲
    PenaltyApplied --> Expired : 時間切れ
    
    note left of PenaltyApplied : ペナルティアニメーション\n- 数値減少演出\n- 色変化\n- 振動効果
    
    Expired --> Inactive : stopTimer()
    Active --> Inactive : stopTimer()
    Warning --> Inactive : stopTimer()
    Critical --> Inactive : stopTimer()
```

## 5. 状態管理フロー

### 5.1 Riverpod プロバイダー依存関係

```mermaid
graph TD
    A[gameDataProvider] --> B[battleProvider]
    A --> C[inventoryProvider]
    A --> D[achievementProvider]
    
    E[timerManagerProvider] --> F[timerProvider]
    F --> B
    
    G[battleEngineProvider] --> B
    H[enemyGeneratorProvider] --> B
    I[victoryValidatorProvider] --> B
    
    B --> J[canClaimVictoryProvider]
    B --> K[isPowerEnemyProvider]
    B --> L[currentEnemyProvider]
    
    C --> M[availablePrimesProvider]
    C --> N[primeCountProvider]
    
    B --> O[battleStatusProvider]
    O --> P[uiStateProvider]
    
    F --> Q[timeWarningProvider]
    Q --> P
```

### 5.2 状態更新シーケンス

```mermaid
sequenceDiagram
    participant User
    participant UI
    participant BattleNotifier
    participant BattleEngine
    participant TimerManager
    participant InventoryNotifier
    
    User->>UI: 攻撃ボタン押下
    UI->>BattleNotifier: attack(prime)
    BattleNotifier->>BattleEngine: executeAttack(enemy, prime)
    BattleEngine-->>BattleNotifier: BattleResult
    
    alt 継続の場合
        BattleNotifier->>InventoryNotifier: usePrime(prime)
        BattleNotifier->>UI: 状態更新
        UI->>User: 攻撃アニメーション表示
    end
    
    alt 勝利宣言待ちの場合
        BattleNotifier->>UI: 勝利ボタン表示
        User->>UI: 勝利宣言ボタン押下
        UI->>BattleNotifier: claimVictory()
        BattleNotifier->>BattleEngine: processVictoryClaim(enemy, value)
        BattleEngine-->>BattleNotifier: BattleResult
        
        alt 正解の場合
            BattleNotifier->>TimerManager: stopTimer()
            BattleNotifier->>InventoryNotifier: addPrime(reward)
            BattleNotifier->>UI: 勝利アニメーション
        else 不正解の場合
            BattleNotifier->>TimerManager: applyPenalty(penalty)
            BattleNotifier->>UI: ペナルティアニメーション
        end
    end
```

## 6. ステージ挑戦前画面の設計（現在の実装ベース）

### 6.1 StageSelectScreen クラス

```dart
class StageSelectScreen extends ConsumerStatefulWidget {
  // ステージ選択画面の実装
  
  /// ステージ情報の表示
  Widget _buildStageCard(StageInfo stage) {
    return Card(
      child: InkWell(
        onTap: stage.isUnlocked ? () => _goToItemSelection(stage) : null,
        child: StageCardContent(stage: stage),
      ),
    );
  }
  
  /// アイテム選択画面へ遷移
  void _goToItemSelection(StageInfo stage) {
    AppRouter.goToStageItemSelection(context, stage);
  }
  
  /// 練習モード開始（アイテム選択なし）
  void _startPracticeMode() {
    final currentInventory = ref.read(inventoryProvider);
    ref.read(battleSessionProvider.notifier).startPractice(currentInventory);
    AppRouter.goToBattle(context);
  }
}
```

### 6.2 StageItemSelectionScreen クラス（新規実装）

```dart
class StageItemSelectionScreen extends ConsumerStatefulWidget {
  final StageInfo stage;
  
  const StageItemSelectionScreen({
    super.key,
    required this.stage,
  });
  
  @override
  ConsumerState<StageItemSelectionScreen> createState() => _StageItemSelectionScreenState();
}

class _StageItemSelectionScreenState extends ConsumerState<StageItemSelectionScreen> {
  Set<int> selectedPrimeValues = {};
  
  /// ステージ別アイテム制限数を取得
  int get maxSelectableItems {
    switch (widget.stage.stageNumber) {
      case 1: return 3;  // 初心者向け：3個まで
      case 2: return 5;  // 中級者向け：5個まで
      case 3: return 7;  // 上級者向け：7個まで  
      case 4: return 10; // 最上級者向け：10個まで
      default: return 5;
    }
  }
  
  /// アイテム選択/選択解除の処理
  void _toggleItemSelection(int primeValue) {
    setState(() {
      if (selectedPrimeValues.contains(primeValue)) {
        selectedPrimeValues.remove(primeValue);
      } else if (selectedPrimeValues.length < maxSelectableItems) {
        selectedPrimeValues.add(primeValue);
      }
    });
  }
  
  /// 選択されたアイテムでバトル開始
  void _startBattleWithSelectedItems() {
    // 選択されたアイテムで一時的なインベントリを作成
    final selectedInventory = _createSelectedInventory();
    
    // バトルセッションを開始（選択されたアイテムのみ）
    ref.read(battleSessionProvider.notifier).startStageWithSelectedItems(
      widget.stage.stageNumber,
      selectedInventory,
    );
    
    // バトル画面に遷移
    AppRouter.goToBattle(context);
  }
  
  /// 選択されたアイテムからインベントリを作成
  List<Prime> _createSelectedInventory() {
    final allPrimes = ref.read(inventoryProvider);
    return allPrimes.where((prime) => 
      selectedPrimeValues.contains(prime.value) && prime.count > 0
    ).toList();
  }
}
```

### 6.2 StageInfo エンティティ（現在の実装）

```dart
class StageInfo {
  final int stageNumber;
  final String title;
  final String description;
  final int enemyRangeMin;        // 敵数値の最小値
  final int enemyRangeMax;        // 敵数値の最大値
  final int timeLimit;            // 制限時間
  final bool isUnlocked;          // アンロック状態
  final bool isCompleted;         // クリア状態
  final int stars;                // 獲得星数
  
  /// ステージ挑戦可能性の判定
  bool canChallenge(List<Prime> inventory) {
    return isUnlocked && inventory.isNotEmpty;
  }
  
  /// ローカライズされたタイトル取得
  String getLocalizedTitle(AppLocalizations l10n) {
    switch (stageNumber) {
      case 1: return l10n.stage1Title;
      case 2: return l10n.stage2Title;
      case 3: return l10n.stage3Title;
      case 4: return l10n.stage4Title;
      default: return title;
    }
  }
}
```

### 6.3 ステージ挑戦前の状態管理フロー（アイテム選択画面追加）

```mermaid
flowchart TD
    A[ユーザーがステージ選択] --> B[StageSelectScreen]
    B --> C[ステージ情報表示]
    C --> D{ステージアンロック状態}
    
    D -->|アンロック済み| E[ステージカードタップ可能]
    D -->|ロック中| F[ステージカード無効化]
    
    E --> G[_goToItemSelection実行]
    G --> H[StageItemSelectionScreen遷移]
    H --> I[所持アイテム一覧表示]
    I --> J[ステージ制限数表示]
    J --> K[アイテム選択UI]
    
    K --> L{選択完了？}
    L -->|未選択| M[選択継続]
    L -->|選択完了| N[_startBattleWithSelectedItems実行]
    
    M --> K
    N --> O[選択アイテムでインベントリ作成]
    O --> P[BattleSessionProvider.startStageWithSelectedItems]
    P --> Q[選択アイテム状態スナップショット保存]
    Q --> R[戦闘画面遷移]
    
    F --> S[ロック表示]
    
    T[練習モードボタン] --> U[_startPracticeMode実行]
    U --> V[BattleSessionProvider.startPractice]
    V --> W[練習モードフラグ設定]
    W --> R
```

### 6.4 アイテム選択画面の詳細仕様

#### 6.4.1 ステージ別制限数（素数の総個数）
```dart
Map<int, int> stageItemLimits = {
  1: 8,  // ステージ1：初心者向け、8個までの素数を選択
  2: 15, // ステージ2：中級者向け、15個までの素数を選択
  3: 25, // ステージ3：上級者向け、25個までの素数を選択
  4: 40, // ステージ4：最上級者向け、40個までの素数を選択
};
```

**重要な変更点：**
- 制限対象：素数の種類数 → 素数の総個数
- 例：Prime(value: 2, count: 5)の場合、5個分としてカウント
- プレイヤーは各素数から何個取るかを選択可能

#### 6.4.2 UI状態管理（個数ベース選択）
```dart
class ItemSelectionState {
  final Map<int, int> selectedCounts; // prime value -> selected count
  final int maxSelectableCount;       // 最大選択可能な総個数
  final List<Prime> availableItems;
  
  int get totalSelectedCount => selectedCounts.values.fold(0, (sum, count) => sum + count);
  bool get hasReachedLimit => totalSelectedCount >= maxSelectableCount;
  bool get hasMinimumSelection => totalSelectedCount >= 1;
  int get remainingCount => maxSelectableCount - totalSelectedCount;
  
  ItemSelectionState copyWith({
    Map<int, int>? selectedCounts,
    int? maxSelectableCount,
    List<Prime>? availableItems,
  }) {
    return ItemSelectionState(
      selectedCounts: selectedCounts ?? this.selectedCounts,
      maxSelectableCount: maxSelectableCount ?? this.maxSelectableCount,
      availableItems: availableItems ?? this.availableItems,
    );
  }
}
```

#### 6.4.3 教育的配慮
- **選択制限の可視化**: 現在選択数/最大選択数を常に表示
- **戦略的思考の促進**: 制限された選択肢での最適解を考えさせる
- **段階的難易度**: ステージが進むにつれて選択肢が増加
- **失敗からの学習**: 選択ミスによる失敗も学習機会として提供

## 7. 無効攻撃システムの設計（教育強化機能）

### 7.1 基本方針
従来は「正しくない素数では攻撃できない」仕様でしたが、教育効果を高めるため「正しくない素数でも攻撃可能だが効果なし」に変更。

### 7.2 無効攻撃の動作

#### 7.2.1 攻撃可能条件
```dart
// 従来の条件
bool canAttack = (enemy % prime == 0) && (prime.count > 0);

// 新しい条件
bool canAttack = prime.count > 0; // 所持数があれば常に攻撃可能
bool isEffective = (enemy % prime == 0) && (prime.count > 0); // 効果的かどうかは別判定
```

#### 7.2.2 攻撃処理フロー
```mermaid
flowchart TD
    A[プレイヤーが素数ボタンを押下] --> B{所持数 > 0？}
    B -->|No| C[攻撃不可]
    B -->|Yes| D{enemy % prime == 0？}
    
    D -->|Yes| E[有効攻撃]
    D -->|No| F[無効攻撃]
    
    E --> G[敵の数値を更新]
    E --> H[アイテムを消費]
    E --> I[使用記録]
    
    F --> J[教育的フィードバック表示]
    F --> K[アイテムを消費]
    F --> L[無効攻撃記録]
    
    G --> M[ゲームオーバー条件チェック]
    J --> N[ダイアログ表示]
    N --> O[素因数分解の説明]
```

### 7.3 教育的フィードバック機能

#### 7.3.1 フィードバック内容
1. **即座の視覚的フィードバック**
   - SnackBar: "Prime X wasted! Enemy ÷ X is not a whole number."
   - 色: エラー色（赤）

2. **詳細な教育ダイアログ**
   - タイトル: "Attack Failed!"
   - 説明: なぜ攻撃が失敗したか
   - 数学的解説: 「X ÷ Y = Z.abc (not a whole number)」
   - 敵の素因数分解表示: 「Enemy = 2 × 3 × 5」
   - 推奨行動: "Try using one of these factors instead!"

#### 7.3.2 UI視覚的区別
```dart
// 素数ボタンの状態表示
enum PrimeButtonState {
  unavailable,  // 所持数0：グレーアウト
  ineffective,  // 所持数あり・無効：警告色（オレンジ）+ ？アイコン
  effective,    // 所持数あり・有効：通常色（青/緑）+ ✓アイコン
}
```

#### 7.3.3 学習効果測定
```dart
class BattleAnalytics {
  int validAttacks = 0;
  int invalidAttacks = 0;
  Map<int, int> invalidAttacksByPrime = {}; // どの素数で間違いやすいか
  
  double get attackAccuracy => validAttacks / (validAttacks + invalidAttacks);
  List<int> get problematicPrimes => invalidAttacksByPrime.entries
      .where((e) => e.value > 2)
      .map((e) => e.key)
      .toList();
}
```

## 7. アイテム消費ロジックの詳細設計（現在の実装ベース）

### 7.1 BattleSessionProvider クラス

```dart
class BattleSessionProvider extends StateNotifier<BattleSession> {
  /// ステージ戦闘開始
  void startStage(int stageNumber, Inventory currentInventory) {
    state = state.copyWith(
      stageNumber: stageNumber,
      isPracticeMode: false,
      stageStartInventory: currentInventory.primes, // スナップショット保存
      victories: 0,
      escapes: 0,
      wrongClaims: 0,
      usedPrimesInCurrentBattle: [],
    );
  }
  
  /// 練習モード開始
  void startPractice(Inventory currentInventory) {
    state = state.copyWith(
      stageNumber: null,
      isPracticeMode: true,
      stageStartInventory: currentInventory.primes,
      victories: 0,
      escapes: 0,
      wrongClaims: 0,
      usedPrimesInCurrentBattle: [],
    );
  }
  
  /// アイテム状態復元
  void restoreInventory() {
    if (state.stageStartInventory != null) {
      // インベントリプロバイダーに復元指示
    }
  }
}
```

### 7.2 アイテム消費・復元フロー

```mermaid
flowchart TD
    A[戦闘開始] --> B[アイテム状態スナップショット]
    B --> C[戦闘実行]
    
    C --> D{練習モード？}
    D -->|Yes| E[アイテム消費なし]
    D -->|No| F[アイテム通常消費]
    
    E --> G[戦闘継続]
    F --> G
    
    G --> H{戦闘結果}
    H -->|勝利| I[勝利報酬獲得]
    H -->|エスケープ| J[アイテム状態復元]
    H -->|タイムアウト| J
    H -->|ゲームオーバー| J
    
    I --> K[次の戦闘 or ステージクリア]
    J --> L[復元アニメーション]
    L --> M[新しい戦闘開始]
    
    M --> B
```

### 7.3 実装における教育的配慮

#### 練習モードの非消費設計
```dart
// 戦闘中のアイテム使用処理
if (canAttack && prime.count > 0) {
  final session = ref.read(battleSessionProvider);
  
  // 敵の数値を更新
  ref.read(battleEnemyProvider.notifier).state = enemy ~/ prime.value;
  
  // 練習モードでない場合のみアイテムを消費
  if (!session.isPracticeMode) {
    ref.read(inventoryProvider.notifier).usePrime(prime.value);
  }
  
  // 使用した素数を記録（復元用）
  ref.read(battleSessionProvider.notifier).recordUsedPrime(prime.value);
}
```

#### 復元システムの実装
```dart
// エスケープ時の復元処理
void _escapeButton() {
  // アイテム状態をステージ開始時に復元
  final session = ref.read(battleSessionProvider);
  if (session.stageStartInventory != null) {
    ref.read(inventoryProvider.notifier).restoreInventory(session.stageStartInventory!);
  }
  
  // 使用素数記録をリセット
  ref.read(battleSessionProvider.notifier).resetUsedPrimes();
  
  // 新しい敵を生成して戦闘継続
  _generateNewEnemy();
  _restartTimer();
}
```

この詳細設計書により、現在の実装における各クラスの実装指針と相互作用が明確になり、開発時の指針として活用できます。簡素化されたアーキテクチャにより、教育的価値を保ちながら開発・保守コストを最小限に抑えることができます。