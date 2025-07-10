import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_schema.dart';

/// Local SQLite database implementation for Composite Hunter
class LocalDatabase {
  static Database? _database;
  static final LocalDatabase _instance = LocalDatabase._internal();
  
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, DatabaseSchema.databaseName);

      print('Initializing database at: $path');

      return await openDatabase(
        path,
        version: DatabaseSchema.currentVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    } catch (e) {
      print('Failed to initialize database: $e');
      throw Exception('Failed to initialize database: $e');
    }
  }

  Future<void> _onConfigure(Database db) async {
    // Enable foreign key constraints
    await db.execute('PRAGMA foreign_keys = ON');
    print('Foreign key constraints enabled');
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      print('Creating database tables for version $version');

      // Create all tables
      for (final statement in DatabaseSchema.allTableCreationStatements) {
        await db.execute(statement);
      }

      // Create indexes
      for (final index in DatabaseSchema.indexDefinitions) {
        await db.execute(index);
      }

      // Create views
      for (final view in DatabaseSchema.allViewCreationStatements) {
        await db.execute(view);
      }

      // Create triggers
      for (final trigger in DatabaseSchema.allTriggerCreationStatements) {
        await db.execute(trigger);
      }

      // Insert default achievements
      await _insertDefaultAchievements(db);

      print('Database tables, indexes, views, and triggers created successfully');
    } catch (e) {
      print('Failed to create database tables: $e');
      throw Exception('Failed to create database tables: $e');
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion');
    
    try {
      // Handle database migrations here
      if (oldVersion < 2) {
        // Future migration logic
      }
      
      print('Database upgrade completed');
    } catch (e) {
      print('Failed to upgrade database: $e');
      throw Exception('Failed to upgrade database: $e');
    }
  }

  Future<void> _insertDefaultAchievements(Database db) async {
    try {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      
      for (final achievement in DatabaseSchema.defaultAchievements) {
        final achievementData = Map<String, dynamic>.from(achievement);
        achievementData['created_at'] = currentTime;
        
        await db.insert(
          DatabaseSchema.achievementsTable,
          achievementData,
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      
      print('Default achievements inserted');
    } catch (e) {
      print('Failed to insert default achievements: $e');
      throw Exception('Failed to insert default achievements: $e');
    }
  }

  // ========== PLAYER OPERATIONS ==========

  /// Create a new player
  Future<int> createPlayer(Map<String, dynamic> playerData) async {
    try {
      final db = await database;
      final playerId = await db.insert(
        DatabaseSchema.playersTable,
        playerData,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      
      // Initialize player achievements
      await _initializePlayerAchievements(db, playerId);
      
      print('Player created with ID: $playerId');
      return playerId;
    } catch (e) {
      print('Failed to create player: $e');
      throw Exception('Failed to create player: $e');
    }
  }

  /// Get player by ID
  Future<Map<String, dynamic>?> getPlayer(int playerId) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseSchema.playersTable,
        where: 'id = ?',
        whereArgs: [playerId],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Failed to get player $playerId: $e');
      throw Exception('Failed to get player: $e');
    }
  }

  /// Update player data
  Future<void> updatePlayer(int playerId, Map<String, dynamic> playerData) async {
    try {
      final db = await database;
      await db.update(
        DatabaseSchema.playersTable,
        playerData,
        where: 'id = ?',
        whereArgs: [playerId],
      );
      print('Player $playerId updated');
    } catch (e) {
      print('Failed to update player $playerId: $e');
      throw Exception('Failed to update player: $e');
    }
  }

  /// Get player statistics view
  Future<Map<String, dynamic>?> getPlayerStats(int playerId) async {
    try {
      final db = await database;
      final results = await db.query(
        'player_stats_view',
        where: 'id = ?',
        whereArgs: [playerId],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Failed to get player stats for $playerId: $e');
      throw Exception('Failed to get player stats: $e');
    }
  }

  Future<void> _initializePlayerAchievements(Database db, int playerId) async {
    try {
      final achievements = await db.query(DatabaseSchema.achievementsTable);
      
      for (final achievement in achievements) {
        await db.insert(
          DatabaseSchema.playerAchievementsTable,
          {
            'player_id': playerId,
            'achievement_id': achievement['id'],
            'current_progress': 0,
            'is_unlocked': 0,
            'progress_snapshots': '[]',
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      
      print('Player achievements initialized for player $playerId');
    } catch (e) {
      print('Failed to initialize player achievements: $e');
      throw Exception('Failed to initialize player achievements: $e');
    }
  }

  // ========== PRIME OPERATIONS ==========

  /// Insert or update prime in player's inventory
  Future<void> insertOrUpdatePrime(int playerId, Map<String, dynamic> primeData) async {
    try {
      final db = await database;
      await db.insert(
        DatabaseSchema.primesTable,
        {...primeData, 'player_id': playerId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Prime ${primeData['value']} updated for player $playerId');
    } catch (e) {
      print('Failed to insert/update prime: $e');
      throw Exception('Failed to insert/update prime: $e');
    }
  }

  /// Get all primes for a player
  Future<List<Map<String, dynamic>>> getPlayerPrimes(int playerId) async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.primesTable,
        where: 'player_id = ?',
        whereArgs: [playerId],
        orderBy: 'value ASC',
      );
    } catch (e) {
      print('Failed to get primes for player $playerId: $e');
      throw Exception('Failed to get player primes: $e');
    }
  }

  /// Get specific prime for a player
  Future<Map<String, dynamic>?> getPlayerPrime(int playerId, int primeValue) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseSchema.primesTable,
        where: 'player_id = ? AND value = ?',
        whereArgs: [playerId, primeValue],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Failed to get prime $primeValue for player $playerId: $e');
      throw Exception('Failed to get player prime: $e');
    }
  }

  /// Delete prime from player's inventory
  Future<void> deletePlayerPrime(int playerId, int primeValue) async {
    try {
      final db = await database;
      await db.delete(
        DatabaseSchema.primesTable,
        where: 'player_id = ? AND value = ?',
        whereArgs: [playerId, primeValue],
      );
      print('Prime $primeValue deleted for player $playerId');
    } catch (e) {
      print('Failed to delete prime $primeValue for player $playerId: $e');
      throw Exception('Failed to delete player prime: $e');
    }
  }

  // ========== ENEMY OPERATIONS ==========

  /// Create a new enemy
  Future<int> createEnemy(Map<String, dynamic> enemyData) async {
    try {
      final db = await database;
      final enemyId = await db.insert(
        DatabaseSchema.enemiesTable,
        enemyData,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      print('Enemy created with ID: $enemyId');
      return enemyId;
    } catch (e) {
      print('Failed to create enemy: $e');
      throw Exception('Failed to create enemy: $e');
    }
  }

  /// Get enemy by ID
  Future<Map<String, dynamic>?> getEnemy(int enemyId) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseSchema.enemiesTable,
        where: 'id = ?',
        whereArgs: [enemyId],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Failed to get enemy $enemyId: $e');
      throw Exception('Failed to get enemy: $e');
    }
  }

  /// Get enemies by type
  Future<List<Map<String, dynamic>>> getEnemiesByType(String enemyType) async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.enemiesTable,
        where: 'enemy_type = ?',
        whereArgs: [enemyType],
        orderBy: 'created_at DESC',
      );
    } catch (e) {
      print('Failed to get enemies by type $enemyType: $e');
      throw Exception('Failed to get enemies by type: $e');
    }
  }

  /// Get power enemies
  Future<List<Map<String, dynamic>>> getPowerEnemies() async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.enemiesTable,
        where: 'is_power_enemy = 1',
        orderBy: 'created_at DESC',
      );
    } catch (e) {
      print('Failed to get power enemies: $e');
      throw Exception('Failed to get power enemies: $e');
    }
  }

  // ========== BATTLE OPERATIONS ==========

  /// Start a new battle
  Future<int> startBattle(Map<String, dynamic> battleData) async {
    try {
      final db = await database;
      final battleId = await db.insert(
        DatabaseSchema.battlesTable,
        battleData,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      print('Battle started with ID: $battleId');
      return battleId;
    } catch (e) {
      print('Failed to start battle: $e');
      throw Exception('Failed to start battle: $e');
    }
  }

  /// Update battle (typically to complete it)
  Future<void> updateBattle(int battleId, Map<String, dynamic> battleData) async {
    try {
      final db = await database;
      await db.update(
        DatabaseSchema.battlesTable,
        battleData,
        where: 'id = ?',
        whereArgs: [battleId],
      );
      print('Battle $battleId updated');
    } catch (e) {
      print('Failed to update battle $battleId: $e');
      throw Exception('Failed to update battle: $e');
    }
  }

  /// Get battle by ID
  Future<Map<String, dynamic>?> getBattle(int battleId) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseSchema.battlesTable,
        where: 'id = ?',
        whereArgs: [battleId],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Failed to get battle $battleId: $e');
      throw Exception('Failed to get battle: $e');
    }
  }

  /// Get player's battle history
  Future<List<Map<String, dynamic>>> getPlayerBattleHistory(int playerId, {int? limit}) async {
    try {
      final db = await database;
      return await db.query(
        'battle_history_view',
        where: 'player_id = ?',
        whereArgs: [playerId],
        orderBy: 'started_at DESC',
        limit: limit,
      );
    } catch (e) {
      print('Failed to get battle history for player $playerId: $e');
      throw Exception('Failed to get battle history: $e');
    }
  }

  /// Add battle action
  Future<void> addBattleAction(int battleId, Map<String, dynamic> actionData) async {
    try {
      final db = await database;
      await db.insert(
        DatabaseSchema.battleActionsTable,
        {...actionData, 'battle_id': battleId},
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      print('Battle action added for battle $battleId');
    } catch (e) {
      print('Failed to add battle action: $e');
      throw Exception('Failed to add battle action: $e');
    }
  }

  /// Get battle actions
  Future<List<Map<String, dynamic>>> getBattleActions(int battleId) async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.battleActionsTable,
        where: 'battle_id = ?',
        whereArgs: [battleId],
        orderBy: 'turn_number ASC',
      );
    } catch (e) {
      print('Failed to get battle actions for battle $battleId: $e');
      throw Exception('Failed to get battle actions: $e');
    }
  }

  // ========== ACHIEVEMENT OPERATIONS ==========

  /// Get all achievements
  Future<List<Map<String, dynamic>>> getAllAchievements() async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.achievementsTable,
        orderBy: 'category ASC, target_value ASC',
      );
    } catch (e) {
      print('Failed to get all achievements: $e');
      throw Exception('Failed to get all achievements: $e');
    }
  }

  /// Get player's achievement progress
  Future<List<Map<String, dynamic>>> getPlayerAchievementProgress(int playerId) async {
    try {
      final db = await database;
      return await db.query(
        'achievement_progress_view',
        where: 'player_id = ?',
        whereArgs: [playerId],
        orderBy: 'category ASC, target_value ASC',
      );
    } catch (e) {
      print('Failed to get achievement progress for player $playerId: $e');
      throw Exception('Failed to get achievement progress: $e');
    }
  }

  /// Update achievement progress
  Future<void> updateAchievementProgress(
    int playerId,
    String achievementId,
    int progress,
    {bool? isUnlocked, int? unlockedAt}
  ) async {
    try {
      final db = await database;
      final updateData = <String, dynamic>{
        'current_progress': progress,
      };
      
      if (isUnlocked != null) {
        updateData['is_unlocked'] = isUnlocked ? 1 : 0;
      }
      
      if (unlockedAt != null) {
        updateData['unlocked_at'] = unlockedAt;
      }
      
      await db.update(
        DatabaseSchema.playerAchievementsTable,
        updateData,
        where: 'player_id = ? AND achievement_id = ?',
        whereArgs: [playerId, achievementId],
      );
      
      print('Achievement progress updated for player $playerId, achievement $achievementId');
    } catch (e) {
      print('Failed to update achievement progress: $e');
      throw Exception('Failed to update achievement progress: $e');
    }
  }

  /// Get unlocked achievements for player
  Future<List<Map<String, dynamic>>> getPlayerUnlockedAchievements(int playerId) async {
    try {
      final db = await database;
      return await db.query(
        'achievement_progress_view',
        where: 'player_id = ? AND is_unlocked = 1',
        whereArgs: [playerId],
        orderBy: 'unlocked_at DESC',
      );
    } catch (e) {
      print('Failed to get unlocked achievements for player $playerId: $e');
      throw Exception('Failed to get unlocked achievements: $e');
    }
  }

  // ========== GAME SETTINGS OPERATIONS ==========

  /// Set game setting
  Future<void> setGameSetting(int playerId, String key, String value, String type) async {
    try {
      final db = await database;
      await db.insert(
        DatabaseSchema.gameSettingsTable,
        {
          'player_id': playerId,
          'setting_key': key,
          'setting_value': value,
          'setting_type': type,
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Game setting $key set for player $playerId');
    } catch (e) {
      print('Failed to set game setting $key for player $playerId: $e');
      throw Exception('Failed to set game setting: $e');
    }
  }

  /// Get game setting
  Future<Map<String, dynamic>?> getGameSetting(int playerId, String key) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseSchema.gameSettingsTable,
        where: 'player_id = ? AND setting_key = ?',
        whereArgs: [playerId, key],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Failed to get game setting $key for player $playerId: $e');
      throw Exception('Failed to get game setting: $e');
    }
  }

  /// Get all game settings for player
  Future<List<Map<String, dynamic>>> getPlayerGameSettings(int playerId) async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.gameSettingsTable,
        where: 'player_id = ?',
        whereArgs: [playerId],
        orderBy: 'setting_key ASC',
      );
    } catch (e) {
      print('Failed to get game settings for player $playerId: $e');
      throw Exception('Failed to get game settings: $e');
    }
  }

  // ========== GAME SESSION OPERATIONS ==========

  /// Start game session
  Future<int> startGameSession(int playerId) async {
    try {
      final db = await database;
      final sessionId = await db.insert(
        DatabaseSchema.gameSessionsTable,
        {
          'player_id': playerId,
          'session_start': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      print('Game session started with ID: $sessionId');
      return sessionId;
    } catch (e) {
      print('Failed to start game session: $e');
      throw Exception('Failed to start game session: $e');
    }
  }

  /// End game session
  Future<void> endGameSession(int sessionId, Map<String, dynamic> sessionData) async {
    try {
      final db = await database;
      await db.update(
        DatabaseSchema.gameSessionsTable,
        {
          ...sessionData,
          'session_end': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [sessionId],
      );
      print('Game session $sessionId ended');
    } catch (e) {
      print('Failed to end game session $sessionId: $e');
      throw Exception('Failed to end game session: $e');
    }
  }

  /// Get player's game sessions
  Future<List<Map<String, dynamic>>> getPlayerGameSessions(int playerId, {int? limit}) async {
    try {
      final db = await database;
      return await db.query(
        DatabaseSchema.gameSessionsTable,
        where: 'player_id = ?',
        whereArgs: [playerId],
        orderBy: 'session_start DESC',
        limit: limit,
      );
    } catch (e) {
      print('Failed to get game sessions for player $playerId: $e');
      throw Exception('Failed to get game sessions: $e');
    }
  }

  // ========== STATISTICS OPERATIONS ==========

  /// Update player daily statistics
  Future<void> updatePlayerDailyStatistics(int playerId, Map<String, dynamic> statsData) async {
    try {
      final db = await database;
      final today = DateTime.now();
      final statDate = DateTime(today.year, today.month, today.day).millisecondsSinceEpoch;
      
      await db.insert(
        DatabaseSchema.playerStatisticsTable,
        {
          'player_id': playerId,
          'stat_date': statDate,
          ...statsData,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      
      print('Daily statistics updated for player $playerId');
    } catch (e) {
      print('Failed to update daily statistics for player $playerId: $e');
      throw Exception('Failed to update daily statistics: $e');
    }
  }

  /// Get player statistics for date range
  Future<List<Map<String, dynamic>>> getPlayerStatistics(
    int playerId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final db = await database;
      final startTimestamp = startDate.millisecondsSinceEpoch;
      final endTimestamp = endDate.millisecondsSinceEpoch;
      
      return await db.query(
        DatabaseSchema.playerStatisticsTable,
        where: 'player_id = ? AND stat_date >= ? AND stat_date <= ?',
        whereArgs: [playerId, startTimestamp, endTimestamp],
        orderBy: 'stat_date ASC',
      );
    } catch (e) {
      print('Failed to get statistics for player $playerId: $e');
      throw Exception('Failed to get player statistics: $e');
    }
  }

  // ========== UTILITY OPERATIONS ==========

  /// Execute raw query
  Future<List<Map<String, dynamic>>> executeRawQuery(String query, [List<dynamic>? arguments]) async {
    try {
      final db = await database;
      return await db.rawQuery(query, arguments);
    } catch (e) {
      print('Failed to execute raw query: $e');
      throw Exception('Failed to execute raw query: $e');
    }
  }

  /// Execute transaction
  Future<T> executeTransaction<T>(Future<T> Function(Transaction) action) async {
    try {
      final db = await database;
      return await db.transaction(action);
    } catch (e) {
      print('Failed to execute transaction: $e');
      throw Exception('Failed to execute transaction: $e');
    }
  }

  /// Clear all data
  Future<void> clearAllData() async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        // Clear data in reverse order of dependencies
        await txn.delete(DatabaseSchema.playerStatisticsTable);
        await txn.delete(DatabaseSchema.battleActionsTable);
        await txn.delete(DatabaseSchema.gameSessionsTable);
        await txn.delete(DatabaseSchema.gameSettingsTable);
        await txn.delete(DatabaseSchema.playerAchievementsTable);
        await txn.delete(DatabaseSchema.battlesTable);
        await txn.delete(DatabaseSchema.enemiesTable);
        await txn.delete(DatabaseSchema.primesTable);
        await txn.delete(DatabaseSchema.playersTable);
        // Don't delete achievements table as it contains static data
      });
      print('All data cleared successfully');
    } catch (e) {
      print('Failed to clear all data: $e');
      throw Exception('Failed to clear all data: $e');
    }
  }

  /// Get database info
  Future<Map<String, dynamic>> getDatabaseInfo() async {
    try {
      final db = await database;
      final version = await db.getVersion();
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
      );
      
      return {
        'version': version,
        'tables': tables.map((t) => t['name']).toList(),
        'path': db.path,
      };
    } catch (e) {
      print('Failed to get database info: $e');
      throw Exception('Failed to get database info: $e');
    }
  }

  /// Close database connection
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
      print('Database connection closed');
    }
  }

  /// Check database health
  Future<bool> checkDatabaseHealth() async {
    try {
      final db = await database;
      await db.rawQuery('SELECT 1');
      return true;
    } catch (e) {
      print('Database health check failed: $e');
      return false;
    }
  }
}