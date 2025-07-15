## 合成数ハンター データベース設計書（修正版v4）

### 1. データベース概要

- **データベース種別**: SQLite（ローカル DB）
- **目的**: ユーザーの進捗、インベントリ、ステージ進行、戦闘履歴、仮報酬、タイマー状態、勝利判定、実績などの永続化
- **対象層**: データレイヤー（`data/datasources/local_database.dart`）
- **新機能**: ステージシステム、アイテム消費システム、仮報酬管理に対応

---

### 2. テーブル設計

#### 2.1 `game_progress` テーブル

| カラム名                     | 型      | NOT NULL | 主キー | 備考                 |
| ---------------------------- | ------- | -------- | ------ | -------------------- |
| id                           | INTEGER | YES      | YES    | 自動採番 ID          |
| player_level                 | INTEGER | YES      |        | プレイヤーレベル     |
| current_stage                | INTEGER | YES      |        | 現在のステージ       |
| max_unlocked_stage           | INTEGER | YES      |        | 最大解放ステージ     |
| total_experience             | INTEGER | YES      |        | 累計経験値           |
| total_battles                | INTEGER | YES      |        | 総バトル数           |
| total_victories              | INTEGER | YES      |        | 勝利数               |
| total_stage_clears           | INTEGER | YES      |        | ステージクリア数     |
| total_stage_failures         | INTEGER | YES      |        | ステージ失敗数       |
| total_items_collected        | INTEGER | YES      |        | アイテム獲得総数     |
| total_items_consumed         | INTEGER | YES      |        | アイテム消費総数     |
| total_power_enemies_defeated | INTEGER | YES      |        | 累乗敵の撃破数       |
| total_time_penalties         | INTEGER | YES      |        | 時間ペナルティの合計 |
| win_rate                     | REAL    | YES      |        | 勝率（0〜1）         |
| stage_clear_rate             | REAL    | YES      |        | ステージクリア率     |
| victory_claim_accuracy       | REAL    | YES      |        | 勝利判定精度         |
| created_at                   | TEXT    | YES      |        | 作成日時（ISO8601）  |
| updated_at                   | TEXT    | YES      |        | 更新日時（ISO8601）  |

#### 2.2 `stages` テーブル（新規）

| カラム名               | 型      | NOT NULL | 主キー | 備考                      |
| ---------------------- | ------- | -------- | ------ | ------------------------- |
| id                     | INTEGER | YES      | YES    | 自動採番 ID               |
| stage_number           | INTEGER | YES      | UNIQUE | ステージ番号              |
| stage_name             | TEXT    | YES      |        | ステージ名                |
| stage_description      | TEXT    | YES      |        | ステージ説明              |
| stage_type             | TEXT    | YES      |        | tutorial/normal/challenge |
| difficulty_level       | TEXT    | YES      |        | easy/normal/hard/extreme  |
| slot_limit             | INTEGER | YES      |        | 持込アイテム上限数        |
| base_time_seconds      | INTEGER | YES      |        | 基本制限時間（秒）        |
| enemy_count            | INTEGER | YES      |        | 敵の数                    |
| min_enemy_value        | INTEGER | YES      |        | 敵の最小値                |
| max_enemy_value        | INTEGER | YES      |        | 敵の最大値                |
| is_unlocked            | INTEGER | YES      |        | 1:解放済, 0:未解放        |
| unlock_condition       | TEXT    | NO       |        | 解放条件（JSON）          |
| rewards                | TEXT    | YES      |        | 報酬情報（JSON）          |
| best_clear_time_ms     | INTEGER | NO       |        | 最速クリア時間（ms）      |
| total_attempts         | INTEGER | YES      |        | 挑戦回数                  |
| total_clears           | INTEGER | YES      |        | クリア回数                |
| first_unlocked_at      | TEXT    | NO       |        | 初回解放日時              |
| first_cleared_at       | TEXT    | NO       |        | 初回クリア日時            |
| last_attempted_at      | TEXT    | NO       |        | 最終挑戦日時              |
| created_at             | TEXT    | YES      |        | 作成日時                  |
| updated_at             | TEXT    | YES      |        | 更新日時                  |

#### 2.3 `item_inventory` テーブル（prime_inventoryから改名・更新）

| カラム名             | 型      | NOT NULL | 主キー | 備考                   |
| -------------------- | ------- | -------- | ------ | ---------------------- |
| id                   | INTEGER | YES      | YES    | 自動採番 ID            |
| item_value           | INTEGER | YES      | UNIQUE | アイテム値（素数値）   |
| item_type            | TEXT    | YES      |        | prime/special など     |
| count                | INTEGER | YES      |        | 所持数                 |
| total_obtained       | INTEGER | YES      |        | 累計取得数             |
| total_consumed       | INTEGER | YES      |        | 累計消費数             |
| battle_usage_count   | INTEGER | YES      |        | 戦闘使用回数           |
| power_enemy_rewards  | INTEGER | YES      |        | 累乗敵からの報酬数     |
| stage_rewards        | INTEGER | YES      |        | ステージ報酬からの獲得 |
| temp_rewards         | INTEGER | YES      |        | 仮報酬からの獲得       |
| first_obtained_at    | TEXT    | YES      |        | 初取得日時（ISO 8601） |
| last_used_at         | TEXT    | NO       |        | 最終使用日時           |
| last_obtained_at     | TEXT    | YES      |        | 最終取得日時           |
| created_at           | TEXT    | YES      |        | 作成日時               |
| updated_at           | TEXT    | YES      |        | 更新日時               |

#### 2.4 `battle_sessions` テーブル（battle_historyから改名・更新）

| カラム名                | 型      | NOT NULL | 主キー | 備考                          |
| ----------------------- | ------- | -------- | ------ | ----------------------------- |
| id                      | INTEGER | YES      | YES    | 自動採番 ID                   |
| stage_id                | INTEGER | YES      |        | stages.id 外部キー            |
| enemy_original_value    | INTEGER | YES      |        | 敵の元の値                    |
| enemy_final_value       | INTEGER | YES      |        | 敵の最終値                    |
| enemy_type              | TEXT    | YES      |        | small/medium/large/power など |
| is_power_enemy          | INTEGER | YES      |        | 1:累乗敵, 0:通常              |
| power_base              | INTEGER | NO       |        | 累乗の底                      |
| power_exponent          | INTEGER | NO       |        | 累乗の指数                    |
| loadout_items           | TEXT    | YES      |        | 持込アイテム（JSON）          |
| items_consumed          | TEXT    | YES      |        | 消費したアイテム（JSON）      |
| turn_count              | INTEGER | YES      |        | ターン数                      |
| attack_count            | INTEGER | YES      |        | 攻撃回数                      |
| successful_attacks      | INTEGER | YES      |        | 成功した攻撃数                |
| failed_attacks          | INTEGER | YES      |        | 失敗した攻撃数                |
| prime_attacks           | INTEGER | YES      |        | 素数への攻撃数                |
| battle_duration_ms      | INTEGER | YES      |        | バトル所要時間(ms)            |
| timer_remaining_seconds | INTEGER | NO       |        | タイマー残り時間              |
| session_result          | TEXT    | YES      |        | stageComplete/stageFailed など|
| temp_rewards_json       | TEXT    | YES      |        | 仮報酬情報（JSON）            |
| finalized_rewards_json  | TEXT    | NO       |        | 確定報酬情報（JSON）          |
| victory_claim_correct   | INTEGER | NO       |        | 1:正解, 0:誤り                |
| victory_claim_attempts  | INTEGER | YES      |        | 勝利判定試行回数              |
| session_date            | TEXT    | YES      |        | セッション実行日（ISO 8601）  |
| created_at              | TEXT    | YES      |        | 作成日時                      |

#### 2.5 `temp_rewards` テーブル（新規）

| カラム名            | 型      | NOT NULL | 主キー | 備考                           |
| ------------------- | ------- | -------- | ------ | ------------------------------ |
| id                  | INTEGER | YES      | YES    | 自動採番 ID                    |
| session_id          | INTEGER | YES      |        | battle_sessions.id 外部キー    |
| item_value          | INTEGER | YES      |        | 仮獲得アイテム値               |
| item_count          | INTEGER | YES      |        | 仮獲得数                       |
| reward_source       | TEXT    | YES      |        | enemy/powerEnemy/stage など    |
| source_enemy_value  | INTEGER | NO       |        | 報酬元の敵値                   |
| is_finalized        | INTEGER | YES      |        | 1:確定済, 0:仮状態             |
| obtained_at         | TEXT    | YES      |        | 仮獲得日時                     |
| finalized_at        | TEXT    | NO       |        | 確定日時                       |
| discarded_at        | TEXT    | NO       |        | 破棄日時                       |
| created_at          | TEXT    | YES      |        | 作成日時                       |

#### 2.6 `item_consumption_log` テーブル（新規）

| カラム名           | 型      | NOT NULL | 主キー | 備考                        |
| ------------------ | ------- | -------- | ------ | --------------------------- |
| id                 | INTEGER | YES      | YES    | 自動採番 ID                 |
| session_id         | INTEGER | YES      |        | battle_sessions.id 外部キー |
| item_value         | INTEGER | YES      |        | 消費したアイテム値          |
| consumption_reason | TEXT    | YES      |        | attack/failed_attack など   |
| target_enemy_value | INTEGER | YES      |        | 攻撃対象の敵値              |
| attack_successful  | INTEGER | YES      |        | 1:成功, 0:失敗              |
| turn_number        | INTEGER | YES      |        | ターン番号                  |
| consumed_at        | TEXT    | YES      |        | 消費日時                    |
| created_at         | TEXT    | YES      |        | 作成日時                    |

#### 2.7 `timer_history` テーブル（更新）

| カラム名            | 型      | NOT NULL | 主キー | 備考                         |
| ------------------- | ------- | -------- | ------ | ---------------------------- |
| id                  | INTEGER | YES      | YES    | 自動採番 ID                  |
| session_id          | INTEGER | YES      |        | `battle_sessions.id` 外部キー|
| stage_id            | INTEGER | YES      |        | stages.id 外部キー           |
| original_seconds    | INTEGER | YES      |        | 元々の制限時間（秒）         |
| final_seconds       | INTEGER | YES      |        | 最終残り時間（秒）           |
| penalty_seconds     | INTEGER | YES      |        | ペナルティ秒数               |
| warning_duration_ms | INTEGER | YES      |        | 警告状態の経過時間（ms）     |
| timed_out           | INTEGER | YES      |        | 1:タイムアウト, 0:通常       |
| timer_start_at      | TEXT    | YES      |        | 開始時刻                     |
| timer_end_at        | TEXT    | NO       |        | 終了時刻                     |
| created_at          | TEXT    | YES      |        | 作成日時                     |

#### 2.8 `penalty_records` テーブル（更新）

| カラム名        | 型      | NOT NULL | 主キー | 備考                                        |
| --------------- | ------- | -------- | ------ | ------------------------------------------- |
| id              | INTEGER | YES      | YES    | 自動採番 ID                                 |
| session_id      | INTEGER | NO       |        | `battle_sessions.id` 外部キー               |
| stage_id        | INTEGER | YES      |        | stages.id 外部キー                          |
| penalty_type    | TEXT    | YES      |        | retire/wrongVictoryClaim/timeout/itemUsage |
| penalty_seconds | INTEGER | YES      |        | ペナルティ時間（秒）                        |
| penalty_reason  | TEXT    | YES      |        | 理由                                        |
| applied_at      | TEXT    | YES      |        | 適用日時（ISO 8601）                        |
| created_at      | TEXT    | YES      |        | 作成日時                                    |

#### 2.9 `victory_claims` テーブル（更新）

| カラム名        | 型      | NOT NULL | 主キー | 備考                         |
| --------------- | ------- | -------- | ------ | ---------------------------- |
| id              | INTEGER | YES      | YES    | 自動採番 ID                  |
| session_id      | INTEGER | YES      |        | `battle_sessions.id` 外部キー|
| stage_id        | INTEGER | YES      |        | stages.id 外部キー           |
| claimed_value   | INTEGER | YES      |        | ユーザーが主張した値         |
| actual_value    | INTEGER | YES      |        | 実際の敵の値                 |
| is_correct      | INTEGER | YES      |        | 1:正解, 0:誤り               |
| penalty_applied | INTEGER | YES      |        | ペナルティ時間（秒）         |
| reward_obtained | INTEGER | NO       |        | 獲得した報酬アイテム値       |
| claimed_at      | TEXT    | YES      |        | 主張日時                     |
| created_at      | TEXT    | YES      |        | 作成日時                     |

#### 2.10 `power_enemy_encounters` テーブル（更新）

| カラム名                  | 型      | NOT NULL | 主キー | 備考                     |
| ------------------------- | ------- | -------- | ------ | ------------------------ |
| id                        | INTEGER | YES      | YES    | 自動採番 ID              |
| enemy_value               | INTEGER | YES      | UNIQUE | 累乗敵の値               |
| power_base                | INTEGER | YES      |        | 底                       |
| power_exponent            | INTEGER | YES      |        | 指数                     |
| stage_first_encountered   | INTEGER | YES      |        | 初遭遇ステージ           |
| player_level_at_encounter | INTEGER | YES      |        | 遭遇時のプレイヤーレベル |
| total_encounters          | INTEGER | YES      |        | 遭遇回数                 |
| total_defeats             | INTEGER | YES      |        | 撃破回数                 |
| attempts_count            | INTEGER | YES      |        | 試行回数                 |
| rewards_obtained          | INTEGER | YES      |        | 報酬数                   |
| temp_rewards_lost         | INTEGER | YES      |        | 失った仮報酬数           |
| first_encounter_at        | TEXT    | YES      |        | 初遭遇日時               |
| last_encounter_at         | TEXT    | YES      |        | 最終遭遇日時             |
| first_defeat_at           | TEXT    | NO       |        | 初撃破日時               |
| created_at                | TEXT    | YES      |        | 作成日時                 |
| updated_at                | TEXT    | YES      |        | 更新日時                 |

#### 2.11 `achievements` テーブル（更新）

| カラム名                | 型      | NOT NULL | 主キー | 備考                            |
| ----------------------- | ------- | -------- | ------ | ------------------------------- |
| id                      | INTEGER | YES      | YES    | 自動採番 ID                     |
| achievement_id          | TEXT    | YES      | UNIQUE | 識別子                          |
| achievement_name        | TEXT    | YES      |        | 名前                            |
| achievement_description | TEXT    | YES      |        | 説明                            |
| achievement_category    | TEXT    | YES      |        | stage/battle/item/timer/special |
| achievement_type        | TEXT    | YES      |        | progress/milestone/hidden など  |
| target_value            | INTEGER | NO       |        | 目標値（数値系実績用）          |
| current_progress        | INTEGER | YES      |        | 現在の進捗                      |
| is_unlocked             | INTEGER | YES      |        | 1:解除済, 0:未解除              |
| reward_items            | TEXT    | NO       |        | 報酬アイテム（JSON）            |
| unlocked_at             | TEXT    | NO       |        | 解除日時                        |
| created_at              | TEXT    | YES      |        | 作成日時                        |
| updated_at              | TEXT    | YES      |        | 更新日時                        |

#### 2.12 `tutorial_progress` テーブル（新規）

| カラム名         | 型      | NOT NULL | 主キー | 備考                     |
| ---------------- | ------- | -------- | ------ | ------------------------ |
| id               | INTEGER | YES      | YES    | 自動採番 ID              |
| tutorial_id      | TEXT    | YES      | UNIQUE | チュートリアル識別子     |
| tutorial_name    | TEXT    | YES      |        | チュートリアル名         |
| is_completed     | INTEGER | YES      |        | 1:完了, 0:未完了         |
| current_step     | INTEGER | YES      |        | 現在のステップ           |
| total_steps      | INTEGER | YES      |        | 総ステップ数             |
| completion_rate  | REAL    | YES      |        | 完了率（0〜1）           |
| started_at       | TEXT    | NO       |        | 開始日時                 |
| completed_at     | TEXT    | NO       |        | 完了日時                 |
| last_accessed_at | TEXT    | YES      |        | 最終アクセス日時         |
| created_at       | TEXT    | YES      |        | 作成日時                 |
| updated_at       | TEXT    | YES      |        | 更新日時                 |

---

### 3. ER 図（修正版）

```
game_progress --< stages --< battle_sessions --< timer_history
                  |              |                  |
                  |              |                  --> penalty_records
                  |              --> temp_rewards
                  |              --> victory_claims
                  |              --> item_consumption_log
                  |
                  --> tutorial_progress

item_inventory --< battle_sessions
power_enemy_encounters --< battle_sessions
achievements --< game_progress
```

---

### 4. 新機能対応の設計ポイント

#### 4.1 ステージシステム
- `stages`テーブルでステージ情報を管理
- スロット制限、時間制限、解放条件を設定
- ステージ別の統計情報を追跡

#### 4.2 アイテム消費システム
- `item_consumption_log`でアイテム使用を詳細記録
- 成功/失敗に関わらず消費を記録
- 消費理由と攻撃結果を分離管理

#### 4.3 仮報酬システム
- `temp_rewards`で一時的な報酬を管理
- ステージクリア時の確定処理を追跡
- 失敗時の破棄処理も記録

#### 4.4 拡張された統計
- ステージ別クリア率
- アイテム消費効率
- 仮報酬の確定/破棄比率

---

### 5. SQL DDL（CREATE TABLE 文）

```sql
-- game_progress（更新）
CREATE TABLE game_progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  player_level INTEGER NOT NULL,
  current_stage INTEGER NOT NULL,
  max_unlocked_stage INTEGER NOT NULL,
  total_experience INTEGER NOT NULL,
  total_battles INTEGER NOT NULL,
  total_victories INTEGER NOT NULL,
  total_stage_clears INTEGER NOT NULL,
  total_stage_failures INTEGER NOT NULL,
  total_items_collected INTEGER NOT NULL,
  total_items_consumed INTEGER NOT NULL,
  total_power_enemies_defeated INTEGER NOT NULL,
  total_time_penalties INTEGER NOT NULL,
  win_rate REAL NOT NULL,
  stage_clear_rate REAL NOT NULL,
  victory_claim_accuracy REAL NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- stages（新規）
CREATE TABLE stages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  stage_number INTEGER NOT NULL UNIQUE,
  stage_name TEXT NOT NULL,
  stage_description TEXT NOT NULL,
  stage_type TEXT NOT NULL,
  difficulty_level TEXT NOT NULL,
  slot_limit INTEGER NOT NULL,
  base_time_seconds INTEGER NOT NULL,
  enemy_count INTEGER NOT NULL,
  min_enemy_value INTEGER NOT NULL,
  max_enemy_value INTEGER NOT NULL,
  is_unlocked INTEGER NOT NULL,
  unlock_condition TEXT,
  rewards TEXT NOT NULL,
  best_clear_time_ms INTEGER,
  total_attempts INTEGER NOT NULL,
  total_clears INTEGER NOT NULL,
  first_unlocked_at TEXT,
  first_cleared_at TEXT,
  last_attempted_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- item_inventory（更新）
CREATE TABLE item_inventory (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  item_value INTEGER NOT NULL UNIQUE,
  item_type TEXT NOT NULL,
  count INTEGER NOT NULL,
  total_obtained INTEGER NOT NULL,
  total_consumed INTEGER NOT NULL,
  battle_usage_count INTEGER NOT NULL,
  power_enemy_rewards INTEGER NOT NULL,
  stage_rewards INTEGER NOT NULL,
  temp_rewards INTEGER NOT NULL,
  first_obtained_at TEXT NOT NULL,
  last_used_at TEXT,
  last_obtained_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- battle_sessions（更新）
CREATE TABLE battle_sessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  stage_id INTEGER NOT NULL,
  enemy_original_value INTEGER NOT NULL,
  enemy_final_value INTEGER NOT NULL,
  enemy_type TEXT NOT NULL,
  is_power_enemy INTEGER NOT NULL,
  power_base INTEGER,
  power_exponent INTEGER,
  loadout_items TEXT NOT NULL,
  items_consumed TEXT NOT NULL,
  turn_count INTEGER NOT NULL,
  attack_count INTEGER NOT NULL,
  successful_attacks INTEGER NOT NULL,
  failed_attacks INTEGER NOT NULL,
  prime_attacks INTEGER NOT NULL,
  battle_duration_ms INTEGER NOT NULL,
  timer_remaining_seconds INTEGER,
  session_result TEXT NOT NULL,
  temp_rewards_json TEXT NOT NULL,
  finalized_rewards_json TEXT,
  victory_claim_correct INTEGER,
  victory_claim_attempts INTEGER NOT NULL,
  session_date TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY(stage_id) REFERENCES stages(id) ON DELETE CASCADE
);

-- temp_rewards（新規）
CREATE TABLE temp_rewards (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id INTEGER NOT NULL,
  item_value INTEGER NOT NULL,
  item_count INTEGER NOT NULL,
  reward_source TEXT NOT NULL,
  source_enemy_value INTEGER,
  is_finalized INTEGER NOT NULL,
  obtained_at TEXT NOT NULL,
  finalized_at TEXT,
  discarded_at TEXT,
  created_at TEXT NOT NULL,
  FOREIGN KEY(session_id) REFERENCES battle_sessions(id) ON DELETE CASCADE
);

-- item_consumption_log（新規）
CREATE TABLE item_consumption_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id INTEGER NOT NULL,
  item_value INTEGER NOT NULL,
  consumption_reason TEXT NOT NULL,
  target_enemy_value INTEGER NOT NULL,
  attack_successful INTEGER NOT NULL,
  turn_number INTEGER NOT NULL,
  consumed_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY(session_id) REFERENCES battle_sessions(id) ON DELETE CASCADE
);

-- timer_history（更新）
CREATE TABLE timer_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id INTEGER NOT NULL,
  stage_id INTEGER NOT NULL,
  original_seconds INTEGER NOT NULL,
  final_seconds INTEGER NOT NULL,
  penalty_seconds INTEGER NOT NULL,
  warning_duration_ms INTEGER NOT NULL,
  timed_out INTEGER NOT NULL,
  timer_start_at TEXT NOT NULL,
  timer_end_at TEXT,
  created_at TEXT NOT NULL,
  FOREIGN KEY(session_id) REFERENCES battle_sessions(id) ON DELETE CASCADE,
  FOREIGN KEY(stage_id) REFERENCES stages(id)
);

-- penalty_records（更新）
CREATE TABLE penalty_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id INTEGER,
  stage_id INTEGER NOT NULL,
  penalty_type TEXT NOT NULL,
  penalty_seconds INTEGER NOT NULL,
  penalty_reason TEXT NOT NULL,
  applied_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY(session_id) REFERENCES battle_sessions(id),
  FOREIGN KEY(stage_id) REFERENCES stages(id)
);

-- victory_claims（更新）
CREATE TABLE victory_claims (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id INTEGER NOT NULL,
  stage_id INTEGER NOT NULL,
  claimed_value INTEGER NOT NULL,
  actual_value INTEGER NOT NULL,
  is_correct INTEGER NOT NULL,
  penalty_applied INTEGER NOT NULL,
  reward_obtained INTEGER,
  claimed_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY(session_id) REFERENCES battle_sessions(id) ON DELETE CASCADE,
  FOREIGN KEY(stage_id) REFERENCES stages(id)
);

-- power_enemy_encounters（更新）
CREATE TABLE power_enemy_encounters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  enemy_value INTEGER NOT NULL UNIQUE,
  power_base INTEGER NOT NULL,
  power_exponent INTEGER NOT NULL,
  stage_first_encountered INTEGER NOT NULL,
  player_level_at_encounter INTEGER NOT NULL,
  total_encounters INTEGER NOT NULL,
  total_defeats INTEGER NOT NULL,
  attempts_count INTEGER NOT NULL,
  rewards_obtained INTEGER NOT NULL,
  temp_rewards_lost INTEGER NOT NULL,
  first_encounter_at TEXT NOT NULL,
  last_encounter_at TEXT NOT NULL,
  first_defeat_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY(stage_first_encountered) REFERENCES stages(id)
);

-- achievements（更新）
CREATE TABLE achievements (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  achievement_id TEXT NOT NULL UNIQUE,
  achievement_name TEXT NOT NULL,
  achievement_description TEXT NOT NULL,
  achievement_category TEXT NOT NULL,
  achievement_type TEXT NOT NULL,
  target_value INTEGER,
  current_progress INTEGER NOT NULL,
  is_unlocked INTEGER NOT NULL,
  reward_items TEXT,
  unlocked_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- tutorial_progress（新規）
CREATE TABLE tutorial_progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  tutorial_id TEXT NOT NULL UNIQUE,
  tutorial_name TEXT NOT NULL,
  is_completed INTEGER NOT NULL,
  current_step INTEGER NOT NULL,
  total_steps INTEGER NOT NULL,
  completion_rate REAL NOT NULL,
  started_at TEXT,
  completed_at TEXT,
  last_accessed_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
```

---

### 6. クエリ最適化戦略（更新）

#### 6.1 インデックス

```sql
-- 既存のインデックス
CREATE INDEX idx_session_result_date ON battle_sessions(session_result, session_date);
CREATE INDEX idx_items_available ON item_inventory(count);
CREATE INDEX idx_timer_timeout ON timer_history(timed_out);
CREATE INDEX idx_penalty_type ON penalty_records(penalty_type);
CREATE INDEX idx_claim_accuracy ON victory_claims(is_correct);
CREATE INDEX idx_power_enemy_base ON power_enemy_encounters(power_base);

-- 新規インデックス
CREATE INDEX idx_stages_unlocked ON stages(is_unlocked, stage_number);
CREATE INDEX idx_stages_difficulty ON stages(difficulty_level, stage_type);
CREATE INDEX idx_temp_rewards_finalized ON temp_rewards(is_finalized, session_id);
CREATE INDEX idx_item_consumption_reason ON item_consumption_log(consumption_reason, attack_successful);
CREATE INDEX idx_tutorial_completion ON tutorial_progress(is_completed, tutorial_id);
CREATE INDEX idx_achievements_category ON achievements(achievement_category, is_unlocked);
CREATE INDEX idx_sessions_stage ON battle_sessions(stage_id, session_result);
```

#### 6.2 推奨クエリ構成

```sql
-- ステージ別統計
SELECT 
  s.stage_number,
  s.stage_name,
  COUNT(bs.id) as total_attempts,
  SUM(CASE WHEN bs.session_result = 'stageComplete' THEN 1 ELSE 0 END) as clears,
  AVG(bs.battle_duration_ms) as avg_duration
FROM stages s
LEFT JOIN battle_sessions bs ON s.id = bs.stage_id
WHERE s.is_unlocked = 1
GROUP BY s.id
ORDER BY s.stage_number;

-- アイテム消費効率
SELECT 
  ii.item_value,
  ii.total_consumed,
  SUM(CASE WHEN icl.attack_successful = 1 THEN 1 ELSE 0 END) as successful_uses,
  CAST(SUM(CASE WHEN icl.attack_successful = 1 THEN 1 ELSE 0 END) AS REAL) / ii.total_consumed as efficiency
FROM item_inventory ii
JOIN item_consumption_log icl ON ii.item_value = icl.item_value
WHERE ii.total_consumed > 0
GROUP BY ii.item_value
ORDER BY efficiency DESC;

-- 仮報酬の確定/破棄統計
SELECT 
  reward_source,
  COUNT(*) as total_temp_rewards,
  SUM(CASE WHEN is_finalized = 1 THEN 1 ELSE 0 END) as finalized_count,
  SUM(CASE WHEN discarded_at IS NOT NULL THEN 1 ELSE 0 END) as discarded_count,
  AVG(item_count) as avg_reward_count
FROM temp_rewards
GROUP BY reward_source;

-- プレイヤー進捗サマリー
SELECT 
  gp.player_level,
  gp.current_stage,
  gp.total_stage_clears,
  gp.total_stage_failures,
  gp.stage_clear_rate,
  COUNT(DISTINCT s.id) as unlocked_stages,
  ii_summary.total_items,
  ii_summary.unique_items
FROM game_progress gp
CROSS JOIN (
  SELECT 
    SUM(count) as total_items,
    COUNT(*) as unique_items
  FROM item_inventory 
  WHERE count > 0
) ii_summary
LEFT JOIN stages s ON s.is_unlocked = 1;
```

---

### 7. Flutter 用 Model 設計（主要クラス）

#### 7.1 `StageModel`（新規）

```dart
class StageModel {
  final int id;
  final int stageNumber;
  final String stageName;
  final String stageDescription;
  final String stageType;
  final String difficultyLevel;
  final int slotLimit;
  final int baseTimeSeconds;
  final int enemyCount;
  final int minEnemyValue;
  final int maxEnemyValue;
  final bool isUnlocked;
  final String? unlockCondition;
  final String rewards;
  final int? bestClearTimeMs;
  final int totalAttempts;
  final int totalClears;
  final DateTime? firstUnlockedAt;
  final DateTime? firstClearedAt;
  final DateTime? lastAttemptedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  StageModel({
    required this.id,
    required this.stageNumber,
    required this.stageName,
    required this.stageDescription,
    required this.stageType,
    required this.difficultyLevel,
    required this.slotLimit,
    required this.baseTimeSeconds,
    required this.enemyCount,
    required this.minEnemyValue,
    required this.maxEnemyValue,
    required this.isUnlocked,
    this.unlockCondition,
    required this.rewards,
    this.bestClearTimeMs,
    required this.totalAttempts,
    required this.totalClears,
    this.firstUnlockedAt,
    this.firstClearedAt,
    this.lastAttemptedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StageModel.fromMap(Map<String, dynamic> map) => StageModel(
    id: map['id'],
    stageNumber: map['stage_number'],
    stageName: map['stage_name'],
    stageDescription: map['stage_description'],
    stageType: map['stage_type'],
    difficultyLevel: map['difficulty_level'],
    slotLimit: map['slot_limit'],
    baseTimeSeconds: map['base_time_seconds'],
    enemyCount: map['enemy_count'],
    minEnemyValue: map['min_enemy_value'],
    maxEnemyValue: map['max_enemy_value'],
    isUnlocked: map['is_unlocked'] == 1,
    unlockCondition: map['unlock_condition'],
    rewards: map['rewards'],
    bestClearTimeMs: map['best_clear_time_ms'],
    totalAttempts: map['total_attempts'],
    totalClears: map['total_clears'],
    firstUnlockedAt: map['first_unlocked_at'] != null 
        ? DateTime.parse(map['first_unlocked_at']) : null,
    firstClearedAt: map['first_cleared_at'] != null 
        ? DateTime.parse(map['first_cleared_at']) : null,
    lastAttemptedAt: map['last_attempted_at'] != null 
        ? DateTime.parse(map['last_attempted_at']) : null,
    createdAt: DateTime.parse(map['created_at']),
    updatedAt: DateTime.parse(map['updated_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'stage_number': stageNumber,
    'stage_name': stageName,
    'stage_description': stageDescription,
    'stage_type': stageType,
    'difficulty_level': difficultyLevel,
    'slot_limit': slotLimit,
    'base_time_seconds': baseTimeSeconds,
    'enemy_count': enemyCount,
    'min_enemy_value': minEnemyValue,
    'max_enemy_value': maxEnemyValue,
    'is_unlocked': isUnlocked ? 1 : 0,
    'unlock_condition': unlockCondition,
    'rewards': rewards,
    'best_clear_time_ms': bestClearTimeMs,
    'total_attempts': totalAttempts,
    'total_clears': totalClears,
    'first_unlocked_at': firstUnlockedAt?.toIso8601String(),
    'first_cleared_at': firstClearedAt?.toIso8601String(),
    'last_attempted_at': lastAttemptedAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  double get clearRate => totalAttempts > 0 ? totalClears / totalAttempts : 0.0;
  bool get hasBeenAttempted => totalAttempts > 0;
  bool get hasBeenCleared => totalClears > 0;
}
```

#### 7.2 `ItemInventoryModel`（更新版）

```dart
class ItemInventoryModel {
  final int id;
  final int itemValue;
  final String itemType;
  final int count;
  final int totalObtained;
  final int totalConsumed;
  final int battleUsageCount;
  final int powerEnemyRewards;
  final int stageRewards;
  final int tempRewards;
  final DateTime firstObtainedAt;
  final DateTime? lastUsedAt;
  final DateTime lastObtainedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemInventoryModel({
    required this.id,
    required this.itemValue,
    required this.itemType,
    required this.count,
    required this.totalObtained,
    required this.totalConsumed,
    required this.battleUsageCount,
    required this.powerEnemyRewards,
    required this.stageRewards,
    required this.tempRewards,
    required this.firstObtainedAt,
    this.lastUsedAt,
    required this.lastObtainedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemInventoryModel.fromMap(Map<String, dynamic> map) => ItemInventoryModel(
    id: map['id'],
    itemValue: map['item_value'],
    itemType: map['item_type'],
    count: map['count'],
    totalObtained: map['total_obtained'],
    totalConsumed: map['total_consumed'],
    battleUsageCount: map['battle_usage_count'],
    powerEnemyRewards: map['power_enemy_rewards'],
    stageRewards: map['stage_rewards'],
    tempRewards: map['temp_rewards'],
    firstObtainedAt: DateTime.parse(map['first_obtained_at']),
    lastUsedAt: map['last_used_at'] != null 
        ? DateTime.parse(map['last_used_at']) : null,
    lastObtainedAt: DateTime.parse(map['last_obtained_at']),
    createdAt: DateTime.parse(map['created_at']),
    updatedAt: DateTime.parse(map['updated_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'item_value': itemValue,
    'item_type': itemType,
    'count': count,
    'total_obtained': totalObtained,
    'total_consumed': totalConsumed,
    'battle_usage_count': battleUsageCount,
    'power_enemy_rewards': powerEnemyRewards,
    'stage_rewards': stageRewards,
    'temp_rewards': tempRewards,
    'first_obtained_at': firstObtainedAt.toIso8601String(),
    'last_used_at': lastUsedAt?.toIso8601String(),
    'last_obtained_at': lastObtainedAt.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  bool get isAvailable => count > 0;
  bool get isPrime => itemType == 'prime';
  double get consumptionRate => totalObtained > 0 ? totalConsumed / totalObtained : 0.0;
  double get usageEfficiency => totalConsumed > 0 ? battleUsageCount / totalConsumed : 0.0;
}
```

#### 7.3 `TempRewardModel`（新規）

```dart
class TempRewardModel {
  final int id;
  final int sessionId;
  final int itemValue;
  final int itemCount;
  final String rewardSource;
  final int? sourceEnemyValue;
  final bool isFinalized;
  final DateTime obtainedAt;
  final DateTime? finalizedAt;
  final DateTime? discardedAt;
  final DateTime createdAt;

  TempRewardModel({
    required this.id,
    required this.sessionId,
    required this.itemValue,
    required this.itemCount,
    required this.rewardSource,
    this.sourceEnemyValue,
    required this.isFinalized,
    required this.obtainedAt,
    this.finalizedAt,
    this.discardedAt,
    required this.createdAt,
  });

  factory TempRewardModel.fromMap(Map<String, dynamic> map) => TempRewardModel(
    id: map['id'],
    sessionId: map['session_id'],
    itemValue: map['item_value'],
    itemCount: map['item_count'],
    rewardSource: map['reward_source'],
    sourceEnemyValue: map['source_enemy_value'],
    isFinalized: map['is_finalized'] == 1,
    obtainedAt: DateTime.parse(map['obtained_at']),
    finalizedAt: map['finalized_at'] != null 
        ? DateTime.parse(map['finalized_at']) : null,
    discardedAt: map['discarded_at'] != null 
        ? DateTime.parse(map['discarded_at']) : null,
    createdAt: DateTime.parse(map['created_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'session_id': sessionId,
    'item_value': itemValue,
    'item_count': itemCount,
    'reward_source': rewardSource,
    'source_enemy_value': sourceEnemyValue,
    'is_finalized': isFinalized ? 1 : 0,
    'obtained_at': obtainedAt.toIso8601String(),
    'finalized_at': finalizedAt?.toIso8601String(),
    'discarded_at': discardedAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
  };

  bool get isPending => !isFinalized && discardedAt == null;
  bool get wasDiscarded => discardedAt != null;
  bool get wasFinalized => isFinalized && finalizedAt != null;
}
```

#### 7.4 `BattleSessionModel`（更新版）

```dart
class BattleSessionModel {
  final int id;
  final int stageId;
  final int enemyOriginalValue;
  final int enemyFinalValue;
  final String enemyType;
  final bool isPowerEnemy;
  final int? powerBase;
  final int? powerExponent;
  final String loadoutItems;
  final String itemsConsumed;
  final int turnCount;
  final int attackCount;
  final int successfulAttacks;
  final int failedAttacks;
  final int primeAttacks;
  final int battleDurationMs;
  final int? timerRemainingSeconds;
  final String sessionResult;
  final String tempRewardsJson;
  final String? finalizedRewardsJson;
  final bool? victoryClaimCorrect;
  final int victoryClaimAttempts;
  final DateTime sessionDate;
  final DateTime createdAt;

  BattleSessionModel({
    required this.id,
    required this.stageId,
    required this.enemyOriginalValue,
    required this.enemyFinalValue,
    required this.enemyType,
    required this.isPowerEnemy,
    this.powerBase,
    this.powerExponent,
    required this.loadoutItems,
    required this.itemsConsumed,
    required this.turnCount,
    required this.attackCount,
    required this.successfulAttacks,
    required this.failedAttacks,
    required this.primeAttacks,
    required this.battleDurationMs,
    this.timerRemainingSeconds,
    required this.sessionResult,
    required this.tempRewardsJson,
    this.finalizedRewardsJson,
    this.victoryClaimCorrect,
    required this.victoryClaimAttempts,
    required this.sessionDate,
    required this.createdAt,
  });

  factory BattleSessionModel.fromMap(Map<String, dynamic> map) => BattleSessionModel(
    id: map['id'],
    stageId: map['stage_id'],
    enemyOriginalValue: map['enemy_original_value'],
    enemyFinalValue: map['enemy_final_value'],
    enemyType: map['enemy_type'],
    isPowerEnemy: map['is_power_enemy'] == 1,
    powerBase: map['power_base'],
    powerExponent: map['power_exponent'],
    loadoutItems: map['loadout_items'],
    itemsConsumed: map['items_consumed'],
    turnCount: map['turn_count'],
    attackCount: map['attack_count'],
    successfulAttacks: map['successful_attacks'],
    failedAttacks: map['failed_attacks'],
    primeAttacks: map['prime_attacks'],
    battleDurationMs: map['battle_duration_ms'],
    timerRemainingSeconds: map['timer_remaining_seconds'],
    sessionResult: map['session_result'],
    tempRewardsJson: map['temp_rewards_json'],
    finalizedRewardsJson: map['finalized_rewards_json'],
    victoryClaimCorrect: map['victory_claim_correct'] == 1,
    victoryClaimAttempts: map['victory_claim_attempts'],
    sessionDate: DateTime.parse(map['session_date']),
    createdAt: DateTime.parse(map['created_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'stage_id': stageId,
    'enemy_original_value': enemyOriginalValue,
    'enemy_final_value': enemyFinalValue,
    'enemy_type': enemyType,
    'is_power_enemy': isPowerEnemy ? 1 : 0,
    'power_base': powerBase,
    'power_exponent': powerExponent,
    'loadout_items': loadoutItems,
    'items_consumed': itemsConsumed,
    'turn_count': turnCount,
    'attack_count': attackCount,
    'successful_attacks': successfulAttacks,
    'failed_attacks': failedAttacks,
    'prime_attacks': primeAttacks,
    'battle_duration_ms': battleDurationMs,
    'timer_remaining_seconds': timerRemainingSeconds,
    'session_result': sessionResult,
    'temp_rewards_json': tempRewardsJson,
    'finalized_rewards_json': finalizedRewardsJson,
    'victory_claim_correct': victoryClaimCorrect == true ? 1 : 0,
    'victory_claim_attempts': victoryClaimAttempts,
    'session_date': sessionDate.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
  };

  bool get wasSuccessful => sessionResult == 'stageComplete';
  bool get wasFailed => sessionResult == 'stageFailed';
  double get attackSuccessRate => attackCount > 0 ? successfulAttacks / attackCount : 0.0;
  double get itemEfficiency => attackCount > 0 ? successfulAttacks / attackCount : 0.0;
  bool get hadPrimeAttacks => primeAttacks > 0;
}
```

---

### 8. データマイグレーション戦略

#### 8.1 バージョン管理

```sql
-- データベースバージョン管理テーブル
CREATE TABLE db_version (
  version INTEGER PRIMARY KEY,
  migration_date TEXT NOT NULL,
  description TEXT NOT NULL
);

-- 初期バージョン挿入
INSERT INTO db_version (version, migration_date, description)
VALUES (4, datetime('now'), 'Stage system and item consumption update');
```

#### 8.2 マイグレーション手順

```dart
class DatabaseMigration {
  static Future<void> migrateToV4(Database db) async {
    await db.transaction((txn) async {
      // 1. 新しいテーブル作成
      await txn.execute('''
        CREATE TABLE stages_new AS SELECT * FROM stages_template;
      ''');
      
      // 2. 既存データの移行
      await txn.execute('''
        INSERT INTO item_inventory (item_value, item_type, count, total_obtained, ...)
        SELECT prime_value, 'prime', count, total_obtained, ...
        FROM prime_inventory;
      ''');
      
      // 3. 古いテーブル削除
      await txn.execute('DROP TABLE IF EXISTS prime_inventory;');
      
      // 4. テーブル名変更
      await txn.execute('ALTER TABLE stages_new RENAME TO stages;');
      
      // 5. インデックス再作成
      await _createIndexes(txn);
    });
  }
  
  static Future<void> _createIndexes(Transaction txn) async {
    // インデックス作成処理
  }
}
```

---

### 9. パフォーマンス考慮事項

#### 9.1 データ量予測
- **アクティブユーザー**: 10,000人
- **1日あたりの戦闘セッション**: 平均50回/ユーザー
- **1年間のデータ蓄積**: 約182万レコード（battle_sessions）
- **データベースサイズ**: 約100MB（インデックス含む）

#### 9.2 最適化戦略
- **パーティショニング**: 日付ベースの論理分割
- **アーカイブ**: 古いデータの圧縮保存
- **キャッシュ**: 頻繁にアクセスされるデータのメモリ保持

#### 9.3 監視項目
- クエリ実行時間
- データベースサイズ
- インデックス使用率
- ディスク I/O パフォーマンス
