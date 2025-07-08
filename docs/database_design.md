## 合成数ハンター データベース設計書（統合最新版）

### 1. データベース概要

- **データベース種別**: SQLite（ローカル DB）
- **目的**: ユーザーの進捗、インベントリ、戦闘履歴、タイマー状態、勝利判定、実績などの永続化
- **対象層**: データレイヤー（`data/datasources/local_database.dart`）

---

### 2. テーブル設計

#### 2.1 `game_progress` テーブル

| カラム名                     | 型      | NOT NULL | 主キー | 備考                 |
| ---------------------------- | ------- | -------- | ------ | -------------------- |
| id                           | INTEGER | YES      | YES    | 自動採番 ID          |
| player_level                 | INTEGER | YES      |        | プレイヤーレベル     |
| total_experience             | INTEGER | YES      |        | 累計経験値           |
| total_battles                | INTEGER | YES      |        | 総バトル数           |
| total_victories              | INTEGER | YES      |        | 勝利数               |
| total_primes_collected       | INTEGER | YES      |        | 素数獲得総数         |
| total_power_enemies_defeated | INTEGER | YES      |        | 累乗敵の撃破数       |
| total_time_penalties         | INTEGER | YES      |        | 時間ペナルティの合計 |
| win_rate                     | REAL    | YES      |        | 勝率（0〜1）         |
| victory_claim_accuracy       | REAL    | YES      |        | 勝利判定精度         |
| created_at                   | TEXT    | YES      |        | 作成日時（ISO8601）  |
| updated_at                   | TEXT    | YES      |        | 更新日時（ISO8601）  |

#### 2.2 `prime_inventory` テーブル

| カラム名            | 型      | NOT NULL | 主キー | 備考                   |
| ------------------- | ------- | -------- | ------ | ---------------------- |
| id                  | INTEGER | YES      | YES    | 自動採番 ID            |
| prime_value         | INTEGER | YES      | UNIQUE | 素数値                 |
| count               | INTEGER | YES      |        | 所持数                 |
| total_obtained      | INTEGER | YES      |        | 累計取得数             |
| usage_count         | INTEGER | YES      |        | 使用回数               |
| power_enemy_rewards | INTEGER | YES      |        | 累乗敵からの報酬数     |
| first_obtained_at   | TEXT    | YES      |        | 初取得日時（ISO 8601） |
| last_used_at        | TEXT    | NO       |        | 最終使用日時           |
| created_at          | TEXT    | YES      |        | 作成日時               |
| updated_at          | TEXT    | YES      |        | 更新日時               |

#### 2.3 `battle_history` テーブル

| カラム名                | 型      | NOT NULL | 主キー | 備考                          |
| ----------------------- | ------- | -------- | ------ | ----------------------------- |
| id                      | INTEGER | YES      | YES    | 自動採番 ID                   |
| enemy_original_value    | INTEGER | YES      |        | 敵の元の値                    |
| enemy_final_value       | INTEGER | YES      |        | 敵の残り HP 的な数値          |
| enemy_type              | TEXT    | YES      |        | small/medium/large/power など |
| is_power_enemy          | INTEGER | YES      |        | 1:累乗敵, 0:通常              |
| power_base              | INTEGER | NO       |        | 累乗の底                      |
| power_exponent          | INTEGER | NO       |        | 累乗の指数                    |
| turn_count              | INTEGER | YES      |        | ターン数                      |
| battle_duration_ms      | INTEGER | YES      |        | バトル所要時間(ms)            |
| timer_remaining_seconds | INTEGER | NO       |        | タイマー残り時間              |
| battle_result           | TEXT    | YES      |        | victory/escape/timeout など   |
| primes_used             | TEXT    | YES      |        | JSON 形式で記録               |
| reward_prime            | INTEGER | NO       |        | 報酬素数                      |
| reward_count            | INTEGER | YES      |        | 報酬個数（1 以上）            |
| victory_claim_correct   | INTEGER | NO       |        | 1:正解, 0:誤り                |
| victory_claim_attempts  | INTEGER | YES      |        | 勝利判定試行回数              |
| battle_date             | TEXT    | YES      |        | バトル実行日（ISO 8601）      |
| created_at              | TEXT    | YES      |        | 作成日時                      |

#### 2.4 `timer_history` テーブル

| カラム名            | 型      | NOT NULL | 主キー | 備考                         |
| ------------------- | ------- | -------- | ------ | ---------------------------- |
| id                  | INTEGER | YES      | YES    | 自動採番 ID                  |
| battle_id           | INTEGER | YES      |        | `battle_history.id` 外部キー |
| original_seconds    | INTEGER | YES      |        | 元々の制限時間（秒）         |
| final_seconds       | INTEGER | YES      |        | 最終残り時間（秒）           |
| penalty_seconds     | INTEGER | YES      |        | ペナルティ秒数               |
| warning_duration_ms | INTEGER | YES      |        | 警告状態の経過時間（ms）     |
| timed_out           | INTEGER | YES      |        | 1:タイムアウト, 0:通常       |
| timer_start_at      | TEXT    | YES      |        | 開始時刻                     |
| timer_end_at        | TEXT    | NO       |        | 終了時刻                     |
| created_at          | TEXT    | YES      |        | 作成日時                     |

#### 2.5 `penalty_records` テーブル

| カラム名        | 型      | NOT NULL | 主キー | 備考                                |
| --------------- | ------- | -------- | ------ | ----------------------------------- |
| id              | INTEGER | YES      | YES    | 自動採番 ID                         |
| battle_id       | INTEGER | NO       |        | `battle_history.id` 外部キー        |
| penalty_type    | TEXT    | YES      |        | escape/wrongVictoryClaim/timeout 等 |
| penalty_seconds | INTEGER | YES      |        | ペナルティ時間（秒）                |
| penalty_reason  | TEXT    | YES      |        | 理由                                |
| applied_at      | TEXT    | YES      |        | 適用日時（ISO 8601）                |
| created_at      | TEXT    | YES      |        | 作成日時                            |

#### 2.6 `victory_claims` テーブル

| カラム名        | 型      | NOT NULL | 主キー | 備考                         |
| --------------- | ------- | -------- | ------ | ---------------------------- |
| id              | INTEGER | YES      | YES    | 自動採番 ID                  |
| battle_id       | INTEGER | YES      |        | `battle_history.id` 外部キー |
| claimed_value   | INTEGER | YES      |        | ユーザーが主張した素数値     |
| is_correct      | INTEGER | YES      |        | 1:正解, 0:誤り               |
| penalty_applied | INTEGER | YES      |        | ペナルティ時間（秒）         |
| claimed_at      | TEXT    | YES      |        | 主張日時                     |
| created_at      | TEXT    | YES      |        | 作成日時                     |

#### 2.7 `power_enemy_encounters` テーブル

| カラム名                  | 型      | NOT NULL | 主キー | 備考                     |
| ------------------------- | ------- | -------- | ------ | ------------------------ |
| id                        | INTEGER | YES      | YES    | 自動採番 ID              |
| enemy_value               | INTEGER | YES      | UNIQUE | 累乗敵の値               |
| power_base                | INTEGER | YES      |        | 底                       |
| power_exponent            | INTEGER | YES      |        | 指数                     |
| player_level_at_encounter | INTEGER | YES      |        | 遭遇時のプレイヤーレベル |
| was_defeated              | INTEGER | YES      |        | 1:撃破済, 0:未撃破       |
| attempts_count            | INTEGER | YES      |        | 試行回数                 |
| rewards_obtained          | INTEGER | YES      |        | 報酬数                   |
| first_encounter_at        | TEXT    | YES      |        | 初遭遇日時               |
| last_encounter_at         | TEXT    | YES      |        | 最終遭遇日時             |
| created_at                | TEXT    | YES      |        | 作成日時                 |
| updated_at                | TEXT    | YES      |        | 更新日時                 |

#### 2.8 `achievements` テーブル

| カラム名                | 型      | NOT NULL | 主キー | 備考                    |
| ----------------------- | ------- | -------- | ------ | ----------------------- |
| id                      | INTEGER | YES      | YES    | 自動採番 ID             |
| achievement_id          | TEXT    | YES      | UNIQUE | 識別子                  |
| achievement_name        | TEXT    | YES      |        | 名前                    |
| achievement_description | TEXT    | YES      |        | 説明                    |
| achievement_category    | TEXT    | YES      |        | general/battle/timer 等 |
| is_unlocked             | INTEGER | YES      |        | 1:解除済, 0:未解除      |
| unlocked_at             | TEXT    | NO       |        | 解除日時                |
| created_at              | TEXT    | YES      |        | 作成日時                |
| updated_at              | TEXT    | YES      |        | 更新日時                |

---

### 3. ER 図（簡易）

```
game_progress --< battle_history --< timer_history
                               |         |
                               |         --> penalty_records
                               --> victory_claims

battle_history --< power_enemy_encounters
prime_inventory --< battle_history
achievements --< game_progress
tutorial_progress -- game_progress
```

---

### 4. 備考

- TEXT 型の日付は ISO 8601 形式で格納
- boolean 相当は INTEGER（0 または 1）で表現
- 外部キー制約は ON（SQLite 設定で明示）
- `primes_used`などの配列データは JSON 文字列形式で保持

---

### 5. SQL DDL（CREATE TABLE 文）

```sql
-- game_progress
CREATE TABLE game_progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  player_level INTEGER NOT NULL,
  total_experience INTEGER NOT NULL,
  total_battles INTEGER NOT NULL,
  total_victories INTEGER NOT NULL,
  total_primes_collected INTEGER NOT NULL,
  total_power_enemies_defeated INTEGER NOT NULL,
  total_time_penalties INTEGER NOT NULL,
  win_rate REAL NOT NULL,
  victory_claim_accuracy REAL NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- prime_inventory
CREATE TABLE prime_inventory (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  prime_value INTEGER NOT NULL UNIQUE,
  count INTEGER NOT NULL,
  total_obtained INTEGER NOT NULL,
  usage_count INTEGER NOT NULL,
  power_enemy_rewards INTEGER NOT NULL,
  first_obtained_at TEXT NOT NULL,
  last_used_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- battle_history
CREATE TABLE battle_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  enemy_original_value INTEGER NOT NULL,
  enemy_final_value INTEGER NOT NULL,
  enemy_type TEXT NOT NULL,
  is_power_enemy INTEGER NOT NULL,
  power_base INTEGER,
  power_exponent INTEGER,
  turn_count INTEGER NOT NULL,
  battle_duration_ms INTEGER NOT NULL,
  timer_remaining_seconds INTEGER,
  battle_result TEXT NOT NULL,
  primes_used TEXT NOT NULL,
  reward_prime INTEGER,
  reward_count INTEGER NOT NULL,
  victory_claim_correct INTEGER,
  victory_claim_attempts INTEGER NOT NULL,
  battle_date TEXT NOT NULL,
  created_at TEXT NOT NULL
);

-- timer_history
CREATE TABLE timer_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  battle_id INTEGER NOT NULL,
  original_seconds INTEGER NOT NULL,
  final_seconds INTEGER NOT NULL,
  penalty_seconds INTEGER NOT NULL,
  warning_duration_ms INTEGER NOT NULL,
  timed_out INTEGER NOT NULL,
  timer_start_at TEXT NOT NULL,
  timer_end_at TEXT,
  created_at TEXT NOT NULL,
  FOREIGN KEY(battle_id) REFERENCES battle_history(id) ON DELETE CASCADE
);

-- penalty_records
CREATE TABLE penalty_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  battle_id INTEGER,
  penalty_type TEXT NOT NULL,
  penalty_seconds INTEGER NOT NULL,
  penalty_reason TEXT NOT NULL,
  applied_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY(battle_id) REFERENCES battle_history(id)
);

-- victory_claims
CREATE TABLE victory_claims (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  battle_id INTEGER NOT NULL,
  claimed_value INTEGER NOT NULL,
  is_correct INTEGER NOT NULL,
  penalty_applied INTEGER NOT NULL,
  claimed_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY(battle_id) REFERENCES battle_history(id) ON DELETE CASCADE
);

-- power_enemy_encounters
CREATE TABLE power_enemy_encounters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  enemy_value INTEGER NOT NULL UNIQUE,
  power_base INTEGER NOT NULL,
  power_exponent INTEGER NOT NULL,
  player_level_at_encounter INTEGER NOT NULL,
  was_defeated INTEGER NOT NULL,
  attempts_count INTEGER NOT NULL,
  rewards_obtained INTEGER NOT NULL,
  first_encounter_at TEXT NOT NULL,
  last_encounter_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- achievements
CREATE TABLE achievements (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  achievement_id TEXT NOT NULL UNIQUE,
  achievement_name TEXT NOT NULL,
  achievement_description TEXT NOT NULL,
  achievement_category TEXT NOT NULL,
  is_unlocked INTEGER NOT NULL,
  unlocked_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
```

---

### 6. クエリ最適化戦略

#### 6.1 インデックス

```sql
CREATE INDEX idx_battle_result_date ON battle_history(battle_result, battle_date);
CREATE INDEX idx_primes_available ON prime_inventory(count);
CREATE INDEX idx_timer_timeout ON timer_history(timed_out);
CREATE INDEX idx_penalty_type ON penalty_records(penalty_type);
CREATE INDEX idx_claim_accuracy ON victory_claims(is_correct);
CREATE INDEX idx_power_enemy_base ON power_enemy_encounters(power_base);
```

#### 6.2 推奨クエリ構成

- 集計クエリでは `COUNT(*)`, `AVG()` 等を使用する場合、必要なカラムに限定する
- `JOIN` を避け、`WHERE battle_id = ?` による個別参照を優先
- JSON 配列の検索を行う場合はアプリ側で展開して処理

---

### 7. Flutter 用 DAO/Model 設計（一部例）

#### 7.1 `PrimeInventoryModel`

```dart
class PrimeInventoryModel {
  final int id;
  final int primeValue;
  final int count;
  final int totalObtained;
  final int usageCount;
  final int powerEnemyRewards;
  final DateTime firstObtainedAt;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  PrimeInventoryModel({
    required this.id,
    required this.primeValue,
    required this.count,
    required this.totalObtained,
    required this.usageCount,
    required this.powerEnemyRewards,
    required this.firstObtainedAt,
    this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PrimeInventoryModel.fromMap(Map<String, dynamic> map) => PrimeInventoryModel(
    id: map['id'],
    primeValue: map['prime_value'],
    count: map['count'],
    totalObtained: map['total_obtained'],
    usageCount: map['usage_count'],
    powerEnemyRewards: map['power_enemy_rewards'],
    firstObtainedAt: DateTime.parse(map['first_obtained_at']),
    lastUsedAt: map['last_used_at'] != null ? DateTime.parse(map['last_used_at']) : null,
    createdAt: DateTime.parse(map['created_at']),
    updatedAt: DateTime.parse(map['updated_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'prime_value': primeValue,
    'count': count,
    'total_obtained': totalObtained,
    'usage_count': usageCount,
    'power_enemy_rewards': powerEnemyRewards,
    'first_obtained_at': firstObtainedAt.toIso8601String(),
    'last_used_at': lastUsedAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
```

※ 他モデルや DAO についても同様に定義可能。必要であれば続きも提供可能です。
