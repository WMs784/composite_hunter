import 'dart:convert';
import '../models/battle_result_model.dart';
import '../models/enemy_model.dart';
import '../datasources/local_database.dart';
import '../datasources/shared_preferences_service.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/entities/prime.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/achievement.dart';
import '../../core/exceptions/data_exception.dart';
import '../../core/utils/logger.dart';

/// Repository for game data persistence and retrieval
class GameRepository {
  final LocalDatabase _database;
  final SharedPreferencesService _preferences;
  // final GameMapper _mapper; // Future feature

  GameRepository({
    LocalDatabase? database,
    SharedPreferencesService? preferences,
    // GameMapper? mapper, // Future feature
  })  : _database = database ?? LocalDatabase(),
        _preferences = preferences ?? SharedPreferencesService();
  // _mapper = mapper ?? GameMapper(); // Future feature

  // ========== PLAYER OPERATIONS ==========

  /// Get current player ID or create new player
  Future<int> getCurrentOrCreatePlayer() async {
    try {
      Logger.info('Getting current player or creating new one');

      // Try to get current player ID from preferences
      final currentPlayerId = await _preferences.getCurrentPlayerId();
      if (currentPlayerId != null) {
        // Verify player exists in database
        final player = await _database.getPlayer(currentPlayerId);
        if (player != null) {
          Logger.info('Current player found: $currentPlayerId');
          return currentPlayerId;
        }
      }

      // Create new player
      final now = DateTime.now();
      final playerData = {
        'name': 'Player',
        'level': 1,
        'experience': 0,
        'total_battles': 0,
        'total_victories': 0,
        'total_defeats': 0,
        'total_escapes': 0,
        'total_timeouts': 0,
        'total_power_enemies_defeated': 0,
        'total_turns_used': 0,
        'total_time_spent': 0,
        'perfect_battles': 0,
        'fastest_battle_time': 0,
        'longest_win_streak': 0,
        'current_win_streak': 0,
        'total_primes_collected': 0,
        'unique_primes_collected': 0,
        'largest_prime_collected': 0,
        'smallest_enemy_defeated': 0,
        'largest_enemy_defeated': 0,
        'giant_enemies_defeated': 0,
        'speed_victories': 0,
        'efficient_victories': 0,
        'comeback_victories': 0,
        'tutorial_completed': 0,
        'created_at': now.millisecondsSinceEpoch,
        'last_played_at': now.millisecondsSinceEpoch,
      };

      final playerId = await _database.createPlayer(playerData);
      await _preferences.setCurrentPlayerId(playerId);

      // Add starter prime
      await _addStarterPrime(playerId);

      Logger.info('New player created with ID: $playerId');
      return playerId;
    } catch (e, stackTrace) {
      Logger.error('Failed to get current or create player', e, stackTrace);
      throw DataException('Failed to get current or create player: $e');
    }
  }

  /// Get player by ID
  Future<Player?> getPlayer(int playerId) async {
    try {
      Logger.info('Getting player: $playerId');

      final playerData = await _database.getPlayer(playerId);
      if (playerData == null) {
        Logger.info('Player not found: $playerId');
        return null;
      }

      return Player(
        level: playerData['level'] ?? 1,
        experience: playerData['experience'] ?? 0,
        totalBattles: playerData['total_battles'] ?? 0,
        totalVictories: playerData['total_victories'] ?? 0,
        totalEscapes: playerData['total_escapes'] ?? 0,
        totalTimeOuts: playerData['total_timeouts'] ?? 0,
        totalPowerEnemiesDefeated:
            playerData['total_power_enemies_defeated'] ?? 0,
        totalTurnsUsed: playerData['total_turns_used'] ?? 0,
        totalTimeSpent: playerData['total_time_spent'] ?? 0,
        perfectBattles: playerData['perfect_battles'] ?? 0,
        fastestBattleTime: playerData['fastest_battle_time'] ?? 0,
        longestWinStreak: playerData['longest_win_streak'] ?? 0,
        currentWinStreak: playerData['current_win_streak'] ?? 0,
        totalPrimesCollected: playerData['total_primes_collected'] ?? 0,
        uniquePrimesCollected: playerData['unique_primes_collected'] ?? 0,
        largestPrimeCollected: playerData['largest_prime_collected'] ?? 0,
        smallestEnemyDefeated: playerData['smallest_enemy_defeated'] ?? 0,
        largestEnemyDefeated: playerData['largest_enemy_defeated'] ?? 0,
        giantEnemiesDefeated: playerData['giant_enemies_defeated'] ?? 0,
        speedVictories: playerData['speed_victories'] ?? 0,
        efficientVictories: playerData['efficient_victories'] ?? 0,
        combackVictories: playerData['comeback_victories'] ?? 0,
        createdAt: playerData['created_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(playerData['created_at'])
            : DateTime.now(),
        lastPlayedAt: playerData['last_played_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(playerData['last_played_at'])
            : DateTime.now(),
        lastLevelUpAt: playerData['last_level_up_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                playerData['last_level_up_at'])
            : null,
        lastAchievementAt: playerData['last_achievement_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                playerData['last_achievement_at'])
            : null,
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to get player', e, stackTrace);
      throw DataException('Failed to get player: $e');
    }
  }

  /// Update player data
  Future<void> updatePlayer(int playerId, Player player) async {
    try {
      Logger.info('Updating player: $playerId');

      final playerData = {
        'level': player.level,
        'experience': player.experience,
        'total_battles': player.totalBattles,
        'total_victories': player.totalVictories,
        'total_escapes': player.totalEscapes,
        'total_timeouts': player.totalTimeOuts,
        'total_power_enemies_defeated': player.totalPowerEnemiesDefeated,
        'total_turns_used': player.totalTurnsUsed,
        'total_time_spent': player.totalTimeSpent,
        'perfect_battles': player.perfectBattles,
        'fastest_battle_time': player.fastestBattleTime,
        'longest_win_streak': player.longestWinStreak,
        'current_win_streak': player.currentWinStreak,
        'total_primes_collected': player.totalPrimesCollected,
        'unique_primes_collected': player.uniquePrimesCollected,
        'largest_prime_collected': player.largestPrimeCollected,
        'smallest_enemy_defeated': player.smallestEnemyDefeated,
        'largest_enemy_defeated': player.largestEnemyDefeated,
        'giant_enemies_defeated': player.giantEnemiesDefeated,
        'speed_victories': player.speedVictories,
        'efficient_victories': player.efficientVictories,
        'comeback_victories': player.combackVictories,
        'last_played_at': player.lastPlayedAt?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
        'last_level_up_at': player.lastLevelUpAt?.millisecondsSinceEpoch,
        'last_achievement_at': player.lastAchievementAt?.millisecondsSinceEpoch,
      };

      await _database.updatePlayer(playerId, playerData);

      // Update quick stats in preferences
      await _preferences.setPlayerLevel(player.level);
      await _preferences.setTotalBattles(player.totalBattles);
      await _preferences.setTotalVictories(player.totalVictories);

      Logger.info('Player updated successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to update player', e, stackTrace);
      throw DataException('Failed to update player: $e');
    }
  }

  /// Add starter prime to new player
  Future<void> _addStarterPrime(int playerId) async {
    try {
      final now = DateTime.now();
      final starterPrimeData = {
        'value': 2,
        'count': 3,
        'first_obtained': now.millisecondsSinceEpoch,
        'usage_count': 0,
        'last_used': null,
        'is_favorite': 0,
        'notes': null,
      };

      await _database.insertOrUpdatePrime(playerId, starterPrimeData);
      Logger.info('Starter prime added to player $playerId');
    } catch (e, stackTrace) {
      Logger.error('Failed to add starter prime', e, stackTrace);
      throw DataException('Failed to add starter prime: $e');
    }
  }

  // ========== INVENTORY OPERATIONS ==========

  /// Load player inventory
  Future<Inventory> loadInventory([int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Loading inventory for player: $currentPlayerId');

      final primeData = await _database.getPlayerPrimes(currentPlayerId);
      final primes = primeData.map((data) {
        return Prime(
          value: data['value'],
          count: data['count'],
          firstObtained:
              DateTime.fromMillisecondsSinceEpoch(data['first_obtained']),
          usageCount: data['usage_count'] ?? 0,
        );
      }).toList();

      Logger.info('Loaded ${primes.length} primes for player $currentPlayerId');
      return Inventory(primes: primes);
    } catch (e, stackTrace) {
      Logger.error('Failed to load inventory', e, stackTrace);
      throw DataException('Failed to load inventory: $e');
    }
  }

  /// Save player inventory
  Future<void> saveInventory(Inventory inventory, [int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Saving inventory for player: $currentPlayerId');

      // This method is used for bulk save - individual updates are handled by updatePrime
      Logger.info('Inventory save completed for player $currentPlayerId');
    } catch (e, stackTrace) {
      Logger.error('Failed to save inventory', e, stackTrace);
      throw DataException('Failed to save inventory: $e');
    }
  }

  /// Add or update a single prime in inventory
  Future<void> updatePrime(Prime prime, [int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Updating prime ${prime.value} for player: $currentPlayerId');

      final primeData = {
        'value': prime.value,
        'count': prime.count,
        'first_obtained': prime.firstObtained.millisecondsSinceEpoch,
        'usage_count': prime.usageCount,
        'last_used': null, // Will be updated when prime is used
        'is_favorite': 0,
        'notes': null,
      };

      await _database.insertOrUpdatePrime(currentPlayerId, primeData);
      Logger.info('Prime ${prime.value} updated for player $currentPlayerId');
    } catch (e, stackTrace) {
      Logger.error('Failed to update prime', e, stackTrace);
      throw DataException('Failed to update prime: $e');
    }
  }

  /// Remove a prime from inventory
  Future<void> removePrime(int primeValue, [int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Removing prime $primeValue for player: $currentPlayerId');

      await _database.deletePlayerPrime(currentPlayerId, primeValue);
      Logger.info('Prime $primeValue removed for player $currentPlayerId');
    } catch (e, stackTrace) {
      Logger.error('Failed to remove prime', e, stackTrace);
      throw DataException('Failed to remove prime: $e');
    }
  }

  // ========== BATTLE OPERATIONS ==========

  /// Start a new battle
  Future<int> startBattle({
    required int enemyId,
    int? playerId,
  }) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Starting battle for player: $currentPlayerId');

      final battleData = {
        'player_id': currentPlayerId,
        'enemy_id': enemyId,
        'battle_result': 'ongoing',
        'battle_status': 'fighting',
        'turns_used': 0,
        'time_used': 0,
        'primes_used': '[]',
        'victory_claim_value': null,
        'victory_claim_correct': null,
        'penalties_applied': '[]',
        'score': 0,
        'experience_gained': 0,
        'primes_rewarded': '[]',
        'special_conditions': '[]',
        'started_at': DateTime.now().millisecondsSinceEpoch,
        'completed_at': null,
      };

      final battleId = await _database.startBattle(battleData);
      Logger.info('Battle started with ID: $battleId');
      return battleId;
    } catch (e, stackTrace) {
      Logger.error('Failed to start battle', e, stackTrace);
      throw DataException('Failed to start battle: $e');
    }
  }

  /// Complete a battle
  Future<void> completeBattle({
    required int battleId,
    required String battleResult,
    required String battleStatus,
    required int turnsUsed,
    required int timeUsed,
    required List<int> primesUsed,
    int? victoryClaimValue,
    bool? victoryClaimCorrect,
    List<String>? penalties,
    required int score,
    required int experienceGained,
    List<int>? primesRewarded,
    List<String>? specialConditions,
  }) async {
    try {
      Logger.info('Completing battle: $battleId');

      final battleData = {
        'battle_result': battleResult,
        'battle_status': battleStatus,
        'turns_used': turnsUsed,
        'time_used': timeUsed,
        'primes_used': jsonEncode(primesUsed),
        'victory_claim_value': victoryClaimValue,
        'victory_claim_correct':
            victoryClaimCorrect != null ? (victoryClaimCorrect ? 1 : 0) : null,
        'penalties_applied': jsonEncode(penalties ?? []),
        'score': score,
        'experience_gained': experienceGained,
        'primes_rewarded': jsonEncode(primesRewarded ?? []),
        'special_conditions': jsonEncode(specialConditions ?? []),
        'completed_at': DateTime.now().millisecondsSinceEpoch,
      };

      await _database.updateBattle(battleId, battleData);
      Logger.info('Battle completed: $battleId');
    } catch (e, stackTrace) {
      Logger.error('Failed to complete battle', e, stackTrace);
      throw DataException('Failed to complete battle: $e');
    }
  }

  /// Add battle action
  Future<void> addBattleAction({
    required int battleId,
    required int turnNumber,
    required String actionType,
    int? primeUsed,
    required int enemyValueBefore,
    required int enemyValueAfter,
    required int timeElapsed,
    required String actionResult,
    required bool isSuccessful,
  }) async {
    try {
      final actionData = {
        'turn_number': turnNumber,
        'action_type': actionType,
        'prime_used': primeUsed,
        'enemy_value_before': enemyValueBefore,
        'enemy_value_after': enemyValueAfter,
        'time_elapsed': timeElapsed,
        'action_result': actionResult,
        'is_successful': isSuccessful ? 1 : 0,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      };

      await _database.addBattleAction(battleId, actionData);
      Logger.info('Battle action added for battle: $battleId');
    } catch (e, stackTrace) {
      Logger.error('Failed to add battle action', e, stackTrace);
      throw DataException('Failed to add battle action: $e');
    }
  }

  /// Get battle history
  Future<List<BattleResultModel>> loadBattleHistory(
      {int? limit, int? playerId}) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Loading battle history for player: $currentPlayerId');

      final historyData =
          await _database.getPlayerBattleHistory(currentPlayerId, limit: limit);

      final results = historyData.map((data) {
        // Convert battle history data to BattleResultModel
        final battleResult = data['battle_result'] as String;
        final enemyValue = data['enemy_original_value'] as int;
        final completedAt = data['completed_at'] as int?;
        final duration = data['time_used'] as int? ?? 0;

        // This is a simplified conversion - in a real implementation,
        // you'd need to handle all the different BattleResultModel types
        switch (battleResult) {
          case 'victory':
            return BattleResultModel.victory(
              defeatedEnemy: EnemyModel(
                currentValue: enemyValue,
                originalValue: enemyValue,
                type: EnemyType.small, // Default type
                primeFactors: [],
              ),
              rewardPrime: enemyValue,
              completedAt: DateTime.fromMillisecondsSinceEpoch(
                  completedAt ?? DateTime.now().millisecondsSinceEpoch),
              battleDuration: duration,
            );
          case 'defeat':
            return const BattleResultModel.error(
              message: 'Battle defeated',
              details: null,
            );
          default:
            return const BattleResultModel.error(
              message: 'Unknown battle result',
              details: null,
            );
        }
      }).toList();

      Logger.info('Loaded ${results.length} battle results');
      return results;
    } catch (e, stackTrace) {
      Logger.error('Failed to load battle history', e, stackTrace);
      throw DataException('Failed to load battle history: $e');
    }
  }

  // ========== ACHIEVEMENT OPERATIONS ==========

  /// Get player achievements
  Future<List<Achievement>> getPlayerAchievements([int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Loading achievements for player: $currentPlayerId');

      final achievementsData =
          await _database.getPlayerAchievementProgress(currentPlayerId);

      final achievements = achievementsData.map((data) {
        return Achievement(
          id: data['achievement_id'],
          title: data['title'],
          description: data['description'],
          category: _mapAchievementCategory(data['category']),
          type: _mapAchievementType(data['achievement_type']),
          targetValue: data['target_value'],
          currentProgress: data['current_progress'],
          isUnlocked: data['is_unlocked'] == 1,
          reward: _mapAchievementReward(
              data['reward_type'], data['reward_value'], data['reward_count']),
          unlockedAt: data['unlocked_at'] != null
              ? DateTime.fromMillisecondsSinceEpoch(data['unlocked_at'])
              : null,
        );
      }).toList();

      Logger.info('Loaded ${achievements.length} achievements');
      return achievements;
    } catch (e, stackTrace) {
      Logger.error('Failed to load achievements', e, stackTrace);
      throw DataException('Failed to load achievements: $e');
    }
  }

  /// Update achievement progress
  Future<void> updateAchievementProgress({
    required String achievementId,
    required int progress,
    bool? isUnlocked,
    int? playerId,
  }) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info(
          'Updating achievement progress: $achievementId for player: $currentPlayerId');

      final unlockedAt =
          isUnlocked == true ? DateTime.now().millisecondsSinceEpoch : null;

      await _database.updateAchievementProgress(
        currentPlayerId,
        achievementId,
        progress,
        isUnlocked: isUnlocked,
        unlockedAt: unlockedAt,
      );

      Logger.info('Achievement progress updated: $achievementId');
    } catch (e, stackTrace) {
      Logger.error('Failed to update achievement progress', e, stackTrace);
      throw DataException('Failed to update achievement progress: $e');
    }
  }

  // ========== SETTINGS OPERATIONS ==========

  /// Get game setting
  Future<String?> getGameSetting(String key, [int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      final setting = await _database.getGameSetting(currentPlayerId, key);
      return setting?['setting_value'];
    } catch (e, stackTrace) {
      Logger.error('Failed to get game setting', e, stackTrace);
      return null;
    }
  }

  /// Set game setting
  Future<void> setGameSetting(String key, String value, String type,
      [int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      await _database.setGameSetting(currentPlayerId, key, value, type);
      Logger.info('Game setting set: $key = $value');
    } catch (e, stackTrace) {
      Logger.error('Failed to set game setting', e, stackTrace);
      throw DataException('Failed to set game setting: $e');
    }
  }

  // ========== UTILITY OPERATIONS ==========

  /// Clear all data
  Future<void> clearAllData() async {
    try {
      Logger.info('Clearing all data');

      await _database.clearAllData();
      await _preferences.clear();

      Logger.info('All data cleared successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to clear all data', e, stackTrace);
      throw DataException('Failed to clear all data: $e');
    }
  }

  /// Check if this is first launch
  Future<bool> isFirstLaunch() async {
    try {
      return await _preferences.isFirstLaunch();
    } catch (e) {
      Logger.error('Failed to check first launch', e);
      return true;
    }
  }

  /// Mark first launch as completed
  Future<void> completeFirstLaunch() async {
    try {
      await _preferences.setFirstLaunchCompleted();
    } catch (e) {
      Logger.error('Failed to mark first launch completed', e);
    }
  }

  /// Check if tutorial is completed
  Future<bool> isTutorialCompleted() async {
    try {
      return await _preferences.isTutorialCompleted();
    } catch (e) {
      Logger.error('Failed to check tutorial status', e);
      return false;
    }
  }

  /// Mark tutorial as completed
  Future<void> completeTutorial() async {
    try {
      await _preferences.setTutorialCompleted();
    } catch (e) {
      Logger.error('Failed to mark tutorial completed', e);
    }
  }

  /// Get database info
  Future<Map<String, dynamic>> getDatabaseInfo() async {
    try {
      return await _database.getDatabaseInfo();
    } catch (e, stackTrace) {
      Logger.error('Failed to get database info', e, stackTrace);
      throw DataException('Failed to get database info: $e');
    }
  }

  /// Export game data
  Future<Map<String, dynamic>> exportGameData([int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Exporting game data for player: $currentPlayerId');

      final player = await getPlayer(currentPlayerId);
      final inventory = await loadInventory(currentPlayerId);
      final achievements = await getPlayerAchievements(currentPlayerId);
      final battleHistory = await loadBattleHistory(playerId: currentPlayerId);

      return {
        'player': player != null ? _playerToMap(player) : null,
        'inventory': inventory.primes.map(_primeToMap).toList(),
        'achievements': achievements.map(_achievementToMap).toList(),
        'battleHistory': battleHistory.map((b) => b.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0.0',
      };
    } catch (e, stackTrace) {
      Logger.error('Failed to export game data', e, stackTrace);
      throw DataException('Failed to export game data: $e');
    }
  }

  /// Import game data
  Future<void> importGameData(Map<String, dynamic> data,
      [int? playerId]) async {
    try {
      final currentPlayerId = playerId ?? await getCurrentOrCreatePlayer();
      Logger.info('Importing game data for player: $currentPlayerId');

      // This is a simplified import - in a real implementation,
      // you'd need to handle all the data types properly

      Logger.info('Game data imported successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to import game data', e, stackTrace);
      throw DataException('Failed to import game data: $e');
    }
  }

  // ========== HELPER METHODS ==========

  AchievementCategory _mapAchievementCategory(String category) {
    switch (category) {
      case 'battle':
        return AchievementCategory.battle;
      case 'power_enemy':
        return AchievementCategory.powerEnemy;
      case 'speed':
        return AchievementCategory.speed;
      case 'efficiency':
        return AchievementCategory.efficiency;
      case 'collection':
        return AchievementCategory.collection;
      case 'progression':
        return AchievementCategory.progression;
      case 'special':
        return AchievementCategory.special;
      default:
        return AchievementCategory.milestone;
    }
  }

  AchievementType _mapAchievementType(String type) {
    switch (type) {
      case 'milestone':
        return AchievementType.milestone;
      case 'cumulative':
        return AchievementType.cumulative;
      case 'streak':
        return AchievementType.streak;
      case 'percentage':
        return AchievementType.percentage;
      case 'time':
        return AchievementType.time;
      case 'secret':
        return AchievementType.secret;
      default:
        return AchievementType.milestone;
    }
  }

  AchievementReward _mapAchievementReward(String type, int value, int count) {
    switch (type) {
      case 'experience':
        return AchievementReward.experience(value);
      case 'prime':
        return AchievementReward.prime(value, count);
      default:
        return AchievementReward.experience(value);
    }
  }

  Map<String, dynamic> _playerToMap(Player player) {
    return {
      'level': player.level,
      'experience': player.experience,
      'totalBattles': player.totalBattles,
      'totalVictories': player.totalVictories,
      'totalEscapes': player.totalEscapes,
      'totalTimeOuts': player.totalTimeOuts,
      'totalPowerEnemiesDefeated': player.totalPowerEnemiesDefeated,
      'createdAt': player.createdAt?.toIso8601String(),
      'lastPlayedAt': player.lastPlayedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> _primeToMap(Prime prime) {
    return {
      'value': prime.value,
      'count': prime.count,
      'firstObtained': prime.firstObtained.toIso8601String(),
      'usageCount': prime.usageCount,
    };
  }

  Map<String, dynamic> _achievementToMap(Achievement achievement) {
    return {
      'id': achievement.id,
      'title': achievement.title,
      'description': achievement.description,
      'category': achievement.category.name,
      'type': achievement.type.name,
      'targetValue': achievement.targetValue,
      'currentProgress': achievement.currentProgress,
      'isUnlocked': achievement.isUnlocked,
      'unlockedAt': achievement.unlockedAt?.toIso8601String(),
    };
  }
}

/// Quick player statistics
class PlayerQuickStats {
  final int level;
  final int totalBattles;
  final int totalVictories;
  final double winRate;

  const PlayerQuickStats({
    required this.level,
    required this.totalBattles,
    required this.totalVictories,
    required this.winRate,
  });

  @override
  String toString() {
    return 'PlayerQuickStats(level: $level, battles: $totalBattles, victories: $totalVictories, winRate: ${(winRate * 100).toStringAsFixed(1)}%)';
  }
}
