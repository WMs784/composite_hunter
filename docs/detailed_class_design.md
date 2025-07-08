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

## 4. UI画面遷移図

### 4.1 全体画面遷移

```mermaid
stateDiagram-v2
    [*] --> SplashScreen : アプリ起動
    
    SplashScreen --> TutorialScreen : 初回起動
    SplashScreen --> BattleScreen : 通常起動
    
    TutorialScreen --> BattleScreen : チュートリアル完了
    
    BattleScreen --> InventoryScreen : インベントリタップ
    BattleScreen --> AchievementScreen : 実績タップ
    BattleScreen --> BattleResultDialog : 戦闘終了
    
    InventoryScreen --> BattleScreen : 戻るボタン
    AchievementScreen --> BattleScreen : 戻るボタン
    
    BattleResultDialog --> BattleScreen : 継続ボタン
    
    state BattleScreen {
        [*] --> WaitingState
        WaitingState --> FightingState : 戦闘開始
        FightingState --> AwaitingVictoryState : 敵が素数に
        FightingState --> FightingState : 攻撃継続
        FightingState --> EscapeState : 逃走選択
        FightingState --> TimeOutState : 時間切れ
        AwaitingVictoryState --> VictoryState : 正しい勝利宣言
        AwaitingVictoryState --> FightingState : 間違った勝利宣言
        VictoryState --> WaitingState : 次の戦闘
        EscapeState --> WaitingState : 次の戦闘（ペナルティ）
        TimeOutState --> WaitingState : 次の戦闘（ペナルティ）
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

この詳細設計書により、各クラスの実装指針と相互作用が明確になり、開発時の指針として活用できます。