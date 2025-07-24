/// Database schema definitions for Composite Hunter
class DatabaseSchema {
  static const String databaseName = 'composite_hunter.db';
  static const int currentVersion = 1;

  // Table names
  static const String playersTable = 'players';
  static const String primesTable = 'primes';
  static const String enemiesTable = 'enemies';
  static const String battlesTable = 'battles';
  static const String achievementsTable = 'achievements';
  static const String playerAchievementsTable = 'player_achievements';
  static const String gameSettingsTable = 'game_settings';
  static const String gameSessionsTable = 'game_sessions';
  static const String battleActionsTable = 'battle_actions';
  static const String playerStatisticsTable = 'player_statistics';

  /// Players table - プレイヤー情報
  static const String createPlayersTable =
      '''
    CREATE TABLE $playersTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      level INTEGER NOT NULL DEFAULT 1,
      experience INTEGER NOT NULL DEFAULT 0,
      total_battles INTEGER NOT NULL DEFAULT 0,
      total_victories INTEGER NOT NULL DEFAULT 0,
      total_defeats INTEGER NOT NULL DEFAULT 0,
      total_escapes INTEGER NOT NULL DEFAULT 0,
      total_timeouts INTEGER NOT NULL DEFAULT 0,
      total_power_enemies_defeated INTEGER NOT NULL DEFAULT 0,
      total_turns_used INTEGER NOT NULL DEFAULT 0,
      total_time_spent INTEGER NOT NULL DEFAULT 0,
      perfect_battles INTEGER NOT NULL DEFAULT 0,
      fastest_battle_time INTEGER NOT NULL DEFAULT 0,
      longest_win_streak INTEGER NOT NULL DEFAULT 0,
      current_win_streak INTEGER NOT NULL DEFAULT 0,
      total_primes_collected INTEGER NOT NULL DEFAULT 0,
      unique_primes_collected INTEGER NOT NULL DEFAULT 0,
      largest_prime_collected INTEGER NOT NULL DEFAULT 0,
      smallest_enemy_defeated INTEGER NOT NULL DEFAULT 0,
      largest_enemy_defeated INTEGER NOT NULL DEFAULT 0,
      giant_enemies_defeated INTEGER NOT NULL DEFAULT 0,
      speed_victories INTEGER NOT NULL DEFAULT 0,
      efficient_victories INTEGER NOT NULL DEFAULT 0,
      comeback_victories INTEGER NOT NULL DEFAULT 0,
      tutorial_completed INTEGER NOT NULL DEFAULT 0,
      created_at INTEGER NOT NULL,
      last_played_at INTEGER NOT NULL,
      last_level_up_at INTEGER,
      last_achievement_at INTEGER
    )
  ''';

  /// Primes table - 素数インベントリ
  static const String createPrimesTable =
      '''
    CREATE TABLE $primesTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player_id INTEGER NOT NULL,
      value INTEGER NOT NULL,
      count INTEGER NOT NULL DEFAULT 0,
      first_obtained INTEGER NOT NULL,
      usage_count INTEGER NOT NULL DEFAULT 0,
      last_used INTEGER,
      is_favorite INTEGER NOT NULL DEFAULT 0,
      notes TEXT,
      FOREIGN KEY (player_id) REFERENCES $playersTable (id) ON DELETE CASCADE,
      UNIQUE(player_id, value)
    )
  ''';

  /// Enemies table - 敵情報
  static const String createEnemiesTable =
      '''
    CREATE TABLE $enemiesTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      original_value INTEGER NOT NULL,
      current_value INTEGER NOT NULL,
      enemy_type TEXT NOT NULL,
      prime_factors TEXT NOT NULL,
      is_power_enemy INTEGER NOT NULL DEFAULT 0,
      power_base INTEGER,
      power_exponent INTEGER,
      difficulty_level INTEGER NOT NULL DEFAULT 1,
      base_time_limit INTEGER NOT NULL,
      created_at INTEGER NOT NULL
    )
  ''';

  /// Battles table - バトル記録
  static const String createBattlesTable =
      '''
    CREATE TABLE $battlesTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player_id INTEGER NOT NULL,
      enemy_id INTEGER NOT NULL,
      battle_result TEXT NOT NULL,
      battle_status TEXT NOT NULL,
      turns_used INTEGER NOT NULL DEFAULT 0,
      time_used INTEGER NOT NULL DEFAULT 0,
      primes_used TEXT NOT NULL,
      victory_claim_value INTEGER,
      victory_claim_correct INTEGER,
      penalties_applied TEXT,
      score INTEGER NOT NULL DEFAULT 0,
      experience_gained INTEGER NOT NULL DEFAULT 0,
      primes_rewarded TEXT,
      special_conditions TEXT,
      started_at INTEGER NOT NULL,
      completed_at INTEGER,
      FOREIGN KEY (player_id) REFERENCES $playersTable (id) ON DELETE CASCADE,
      FOREIGN KEY (enemy_id) REFERENCES $enemiesTable (id) ON DELETE CASCADE
    )
  ''';

  /// Achievements table - アチーブメント定義
  static const String createAchievementsTable =
      '''
    CREATE TABLE $achievementsTable (
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      category TEXT NOT NULL,
      achievement_type TEXT NOT NULL,
      target_value INTEGER NOT NULL,
      rarity TEXT NOT NULL DEFAULT 'common',
      is_hidden INTEGER NOT NULL DEFAULT 0,
      is_secret INTEGER NOT NULL DEFAULT 0,
      reward_type TEXT NOT NULL,
      reward_value INTEGER NOT NULL,
      reward_count INTEGER NOT NULL DEFAULT 1,
      icon_path TEXT,
      hint TEXT,
      prerequisites TEXT,
      created_at INTEGER NOT NULL
    )
  ''';

  /// Player achievements table - プレイヤーアチーブメント進捗
  static const String createPlayerAchievementsTable =
      '''
    CREATE TABLE $playerAchievementsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player_id INTEGER NOT NULL,
      achievement_id TEXT NOT NULL,
      current_progress INTEGER NOT NULL DEFAULT 0,
      is_unlocked INTEGER NOT NULL DEFAULT 0,
      unlocked_at INTEGER,
      progress_snapshots TEXT,
      FOREIGN KEY (player_id) REFERENCES $playersTable (id) ON DELETE CASCADE,
      FOREIGN KEY (achievement_id) REFERENCES $achievementsTable (id) ON DELETE CASCADE,
      UNIQUE(player_id, achievement_id)
    )
  ''';

  /// Game settings table - ゲーム設定
  static const String createGameSettingsTable =
      '''
    CREATE TABLE $gameSettingsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player_id INTEGER NOT NULL,
      setting_key TEXT NOT NULL,
      setting_value TEXT NOT NULL,
      setting_type TEXT NOT NULL,
      updated_at INTEGER NOT NULL,
      FOREIGN KEY (player_id) REFERENCES $playersTable (id) ON DELETE CASCADE,
      UNIQUE(player_id, setting_key)
    )
  ''';

  /// Game sessions table - ゲームセッション
  static const String createGameSessionsTable =
      '''
    CREATE TABLE $gameSessionsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player_id INTEGER NOT NULL,
      session_start INTEGER NOT NULL,
      session_end INTEGER,
      battles_played INTEGER NOT NULL DEFAULT 0,
      victories_achieved INTEGER NOT NULL DEFAULT 0,
      experience_gained INTEGER NOT NULL DEFAULT 0,
      achievements_unlocked INTEGER NOT NULL DEFAULT 0,
      longest_battle_time INTEGER NOT NULL DEFAULT 0,
      shortest_battle_time INTEGER NOT NULL DEFAULT 0,
      average_battle_time INTEGER NOT NULL DEFAULT 0,
      session_notes TEXT,
      FOREIGN KEY (player_id) REFERENCES $playersTable (id) ON DELETE CASCADE
    )
  ''';

  /// Battle actions table - バトルアクション詳細
  static const String createBattleActionsTable =
      '''
    CREATE TABLE $battleActionsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      battle_id INTEGER NOT NULL,
      turn_number INTEGER NOT NULL,
      action_type TEXT NOT NULL,
      prime_used INTEGER,
      enemy_value_before INTEGER NOT NULL,
      enemy_value_after INTEGER NOT NULL,
      time_elapsed INTEGER NOT NULL,
      action_result TEXT NOT NULL,
      is_successful INTEGER NOT NULL DEFAULT 0,
      created_at INTEGER NOT NULL,
      FOREIGN KEY (battle_id) REFERENCES $battlesTable (id) ON DELETE CASCADE
    )
  ''';

  /// Player statistics table - プレイヤー統計情報
  static const String createPlayerStatisticsTable =
      '''
    CREATE TABLE $playerStatisticsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player_id INTEGER NOT NULL,
      stat_date INTEGER NOT NULL,
      daily_battles INTEGER NOT NULL DEFAULT 0,
      daily_victories INTEGER NOT NULL DEFAULT 0,
      daily_experience INTEGER NOT NULL DEFAULT 0,
      daily_play_time INTEGER NOT NULL DEFAULT 0,
      weekly_battles INTEGER NOT NULL DEFAULT 0,
      weekly_victories INTEGER NOT NULL DEFAULT 0,
      weekly_experience INTEGER NOT NULL DEFAULT 0,
      weekly_play_time INTEGER NOT NULL DEFAULT 0,
      monthly_battles INTEGER NOT NULL DEFAULT 0,
      monthly_victories INTEGER NOT NULL DEFAULT 0,
      monthly_experience INTEGER NOT NULL DEFAULT 0,
      monthly_play_time INTEGER NOT NULL DEFAULT 0,
      FOREIGN KEY (player_id) REFERENCES $playersTable (id) ON DELETE CASCADE,
      UNIQUE(player_id, stat_date)
    )
  ''';

  // Index definitions for better performance
  static const List<String> indexDefinitions = [
    'CREATE INDEX idx_primes_player_id ON $primesTable (player_id)',
    'CREATE INDEX idx_primes_value ON $primesTable (value)',
    'CREATE INDEX idx_primes_player_value ON $primesTable (player_id, value)',
    'CREATE INDEX idx_battles_player_id ON $battlesTable (player_id)',
    'CREATE INDEX idx_battles_enemy_id ON $battlesTable (enemy_id)',
    'CREATE INDEX idx_battles_started_at ON $battlesTable (started_at)',
    'CREATE INDEX idx_battles_completed_at ON $battlesTable (completed_at)',
    'CREATE INDEX idx_battles_player_completed ON $battlesTable (player_id, completed_at)',
    'CREATE INDEX idx_player_achievements_player_id ON $playerAchievementsTable (player_id)',
    'CREATE INDEX idx_player_achievements_achievement_id ON $playerAchievementsTable (achievement_id)',
    'CREATE INDEX idx_player_achievements_unlocked ON $playerAchievementsTable (player_id, is_unlocked)',
    'CREATE INDEX idx_game_settings_player_key ON $gameSettingsTable (player_id, setting_key)',
    'CREATE INDEX idx_game_sessions_player_id ON $gameSessionsTable (player_id)',
    'CREATE INDEX idx_game_sessions_start_end ON $gameSessionsTable (session_start, session_end)',
    'CREATE INDEX idx_battle_actions_battle_id ON $battleActionsTable (battle_id)',
    'CREATE INDEX idx_battle_actions_turn ON $battleActionsTable (battle_id, turn_number)',
    'CREATE INDEX idx_player_statistics_player_date ON $playerStatisticsTable (player_id, stat_date)',
    'CREATE INDEX idx_enemies_type ON $enemiesTable (enemy_type)',
    'CREATE INDEX idx_enemies_power ON $enemiesTable (is_power_enemy)',
    'CREATE INDEX idx_enemies_difficulty ON $enemiesTable (difficulty_level)',
  ];

  // Views for common queries
  static const String createPlayerStatsView =
      '''
    CREATE VIEW player_stats_view AS
    SELECT 
      p.id,
      p.name,
      p.level,
      p.experience,
      p.total_battles,
      p.total_victories,
      CASE 
        WHEN p.total_battles > 0 THEN ROUND((p.total_victories * 100.0) / p.total_battles, 2)
        ELSE 0.0
      END as win_rate,
      p.total_power_enemies_defeated,
      p.longest_win_streak,
      p.current_win_streak,
      p.unique_primes_collected,
      p.largest_prime_collected,
      COUNT(pa.id) as total_achievements,
      COUNT(CASE WHEN pa.is_unlocked = 1 THEN 1 END) as unlocked_achievements
    FROM $playersTable p
    LEFT JOIN $playerAchievementsTable pa ON p.id = pa.player_id
    GROUP BY p.id
  ''';

  static const String createBattleHistoryView =
      '''
    CREATE VIEW battle_history_view AS
    SELECT 
      b.id,
      b.player_id,
      p.name as player_name,
      e.original_value as enemy_original_value,
      e.current_value as enemy_current_value,
      e.enemy_type,
      e.is_power_enemy,
      b.battle_result,
      b.battle_status,
      b.turns_used,
      b.time_used,
      b.score,
      b.experience_gained,
      b.started_at,
      b.completed_at
    FROM $battlesTable b
    JOIN $playersTable p ON b.player_id = p.id
    JOIN $enemiesTable e ON b.enemy_id = e.id
  ''';

  static const String createAchievementProgressView =
      '''
    CREATE VIEW achievement_progress_view AS
    SELECT 
      pa.player_id,
      pa.achievement_id,
      a.title,
      a.description,
      a.category,
      a.achievement_type,
      a.target_value,
      pa.current_progress,
      CASE 
        WHEN a.target_value > 0 THEN ROUND((pa.current_progress * 100.0) / a.target_value, 2)
        ELSE 0.0
      END as completion_percentage,
      pa.is_unlocked,
      pa.unlocked_at,
      a.reward_type,
      a.reward_value,
      a.reward_count
    FROM $playerAchievementsTable pa
    JOIN $achievementsTable a ON pa.achievement_id = a.id
  ''';

  // Triggers for automatic updates
  static const String createUpdatePlayerStatsTriggger =
      '''
    CREATE TRIGGER update_player_stats_on_battle_complete
    AFTER UPDATE ON $battlesTable
    WHEN NEW.completed_at IS NOT NULL AND OLD.completed_at IS NULL
    BEGIN
      UPDATE $playersTable 
      SET 
        total_battles = total_battles + 1,
        total_victories = total_victories + CASE WHEN NEW.battle_result = 'victory' THEN 1 ELSE 0 END,
        total_defeats = total_defeats + CASE WHEN NEW.battle_result = 'defeat' THEN 1 ELSE 0 END,
        total_escapes = total_escapes + CASE WHEN NEW.battle_result = 'escape' THEN 1 ELSE 0 END,
        total_timeouts = total_timeouts + CASE WHEN NEW.battle_result = 'timeout' THEN 1 ELSE 0 END,
        total_turns_used = total_turns_used + NEW.turns_used,
        total_time_spent = total_time_spent + NEW.time_used,
        experience = experience + NEW.experience_gained,
        last_played_at = NEW.completed_at
      WHERE id = NEW.player_id;
    END
  ''';

  static const String createUpdateWinStreakTrigger =
      '''
    CREATE TRIGGER update_win_streak_on_battle_complete
    AFTER UPDATE ON $battlesTable
    WHEN NEW.completed_at IS NOT NULL AND OLD.completed_at IS NULL
    BEGIN
      UPDATE $playersTable 
      SET 
        current_win_streak = CASE 
          WHEN NEW.battle_result = 'victory' THEN current_win_streak + 1
          ELSE 0
        END,
        longest_win_streak = CASE 
          WHEN NEW.battle_result = 'victory' AND current_win_streak + 1 > longest_win_streak 
          THEN current_win_streak + 1
          ELSE longest_win_streak
        END
      WHERE id = NEW.player_id;
    END
  ''';

  static const String createUpdatePrimeUsageTrigger =
      '''
    CREATE TRIGGER update_prime_usage_on_battle_action
    AFTER INSERT ON $battleActionsTable
    WHEN NEW.prime_used IS NOT NULL AND NEW.is_successful = 1
    BEGIN
      UPDATE $primesTable 
      SET 
        usage_count = usage_count + 1,
        last_used = NEW.created_at
      WHERE player_id = (SELECT player_id FROM $battlesTable WHERE id = NEW.battle_id) 
        AND value = NEW.prime_used;
    END
  ''';

  // Get all table creation statements
  static List<String> get allTableCreationStatements => [
    createPlayersTable,
    createPrimesTable,
    createEnemiesTable,
    createBattlesTable,
    createAchievementsTable,
    createPlayerAchievementsTable,
    createGameSettingsTable,
    createGameSessionsTable,
    createBattleActionsTable,
    createPlayerStatisticsTable,
  ];

  // Get all view creation statements
  static List<String> get allViewCreationStatements => [
    createPlayerStatsView,
    createBattleHistoryView,
    createAchievementProgressView,
  ];

  // Get all trigger creation statements
  static List<String> get allTriggerCreationStatements => [
    createUpdatePlayerStatsTriggger,
    createUpdateWinStreakTrigger,
    createUpdatePrimeUsageTrigger,
  ];

  // Default achievements data
  static const List<Map<String, dynamic>> defaultAchievements = [
    {
      'id': 'first_victory',
      'title': 'First Victory',
      'description': 'Win your first battle',
      'category': 'battle',
      'achievement_type': 'milestone',
      'target_value': 1,
      'rarity': 'common',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 50,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'battle_veteran',
      'title': 'Battle Veteran',
      'description': 'Complete 100 battles',
      'category': 'battle',
      'achievement_type': 'cumulative',
      'target_value': 100,
      'rarity': 'uncommon',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 500,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'power_hunter',
      'title': 'Power Hunter',
      'description': 'Defeat your first power enemy',
      'category': 'power_enemy',
      'achievement_type': 'milestone',
      'target_value': 1,
      'rarity': 'uncommon',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 100,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'speed_demon',
      'title': 'Speed Demon',
      'description': 'Complete a battle in under 10 seconds',
      'category': 'speed',
      'achievement_type': 'milestone',
      'target_value': 1,
      'rarity': 'rare',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 75,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'efficient_hunter',
      'title': 'Efficient Hunter',
      'description': 'Complete a battle in 3 turns or less',
      'category': 'efficiency',
      'achievement_type': 'milestone',
      'target_value': 1,
      'rarity': 'uncommon',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 60,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'collector',
      'title': 'Prime Collector',
      'description': 'Collect 10 different primes',
      'category': 'collection',
      'achievement_type': 'cumulative',
      'target_value': 10,
      'rarity': 'common',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 200,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'level_up_10',
      'title': 'Rising Star',
      'description': 'Reach level 10',
      'category': 'progression',
      'achievement_type': 'milestone',
      'target_value': 10,
      'rarity': 'common',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 300,
      'reward_count': 1,
      'created_at': 0,
    },
    {
      'id': 'perfect_battle',
      'title': 'Perfect Battle',
      'description': 'Complete a battle with perfect score',
      'category': 'special',
      'achievement_type': 'milestone',
      'target_value': 1,
      'rarity': 'rare',
      'is_hidden': 0,
      'is_secret': 0,
      'reward_type': 'experience',
      'reward_value': 150,
      'reward_count': 1,
      'created_at': 0,
    },
  ];
}
