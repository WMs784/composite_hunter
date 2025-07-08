import '../models/game_data_model.dart';
import '../models/prime_model.dart';
import '../models/battle_result_model.dart';
import '../datasources/local_database.dart';
import '../datasources/shared_preferences_service.dart';
import '../mappers/game_mapper.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/entities/prime.dart';
import '../../core/exceptions/data_exception.dart';
import '../../core/utils/logger.dart';

/// Repository for game data persistence and retrieval
class GameRepository {
  final LocalDatabase _database;
  final SharedPreferencesService _preferences;
  final GameMapper _mapper;

  GameRepository({
    LocalDatabase? database,
    SharedPreferencesService? preferences,
    GameMapper? mapper,
  }) : _database = database ?? LocalDatabase(),
       _preferences = preferences ?? SharedPreferencesService(),
       _mapper = mapper ?? GameMapper();

  /// Load complete game data
  Future<GameDataModel> loadGameData() async {
    try {
      Logger.info('Loading game data');

      // Load from database first
      final dbData = await _database.getGameData();
      
      if (dbData != null) {
        Logger.info('Game data loaded from database');
        return GameDataModel.fromJson(dbData);
      }

      // If no database data, create new game
      Logger.info('No existing game data, creating new game');
      return await _createNewGameData();
      
    } catch (e, stackTrace) {
      Logger.error('Failed to load game data', e, stackTrace);
      throw DataException('Failed to load game data: $e');
    }
  }

  /// Save complete game data
  Future<void> saveGameData(GameDataModel gameData) async {
    try {
      Logger.info('Saving game data');

      // Update last played time
      final updatedData = gameData.copyWith(
        lastPlayedAt: DateTime.now(),
      );

      // Save to database
      await _database.insertOrUpdateGameData(updatedData.toJson());

      // Save key metrics to shared preferences for quick access
      await _preferences.setPlayerLevel(updatedData.playerLevel);
      await _preferences.setTotalBattles(updatedData.totalBattles);
      await _preferences.setTotalVictories(updatedData.totalVictories);

      Logger.info('Game data saved successfully');
      
    } catch (e, stackTrace) {
      Logger.error('Failed to save game data', e, stackTrace);
      throw DataException('Failed to save game data: $e');
    }
  }

  /// Load player inventory
  Future<Inventory> loadInventory() async {
    try {
      Logger.info('Loading inventory');

      final primeData = await _database.getAllPrimes();
      final primes = primeData
          .map((data) => _mapper.primeModelToDomain(PrimeModel.fromJson(data)))
          .toList();

      return Inventory(primes: primes);
      
    } catch (e, stackTrace) {
      Logger.error('Failed to load inventory', e, stackTrace);
      throw DataException('Failed to load inventory: $e');
    }
  }

  /// Save player inventory
  Future<void> saveInventory(Inventory inventory) async {
    try {
      Logger.info('Saving inventory');

      // Clear existing primes and save new ones
      for (final prime in inventory.primes) {
        final model = _mapper.primeToModel(prime);
        await _database.insertOrUpdatePrime(model.toJson());
      }

      Logger.info('Inventory saved successfully');
      
    } catch (e, stackTrace) {
      Logger.error('Failed to save inventory', e, stackTrace);
      throw DataException('Failed to save inventory: $e');
    }
  }

  /// Add or update a single prime in inventory
  Future<void> updatePrime(Prime prime) async {
    try {
      final model = _mapper.primeToModel(prime);
      await _database.insertOrUpdatePrime(model.toJson());
      
    } catch (e, stackTrace) {
      Logger.error('Failed to update prime', e, stackTrace);
      throw DataException('Failed to update prime: $e');
    }
  }

  /// Remove a prime from inventory
  Future<void> removePrime(int primeValue) async {
    try {
      await _database.deletePrime(primeValue);
      
    } catch (e, stackTrace) {
      Logger.error('Failed to remove prime', e, stackTrace);
      throw DataException('Failed to remove prime: $e');
    }
  }

  /// Save battle result to history
  Future<void> saveBattleResult(BattleResultModel result) async {
    try {
      Logger.info('Saving battle result');

      final battleData = {
        'battle_type': result.runtimeType.toString(),
        'result_data': result.toJson(),
        'completed_at': DateTime.now().millisecondsSinceEpoch,
      };

      // Add enemy and duration info if available
      result.when(
        victory: (enemy, reward, completedAt, duration) {
          battleData['enemy_value'] = enemy.currentValue;
          battleData['enemy_type'] = enemy.type.name;
          battleData['battle_duration'] = duration;
        },
        powerVictory: (enemy, reward, count, completedAt, duration) {
          battleData['enemy_value'] = enemy.currentValue;
          battleData['enemy_type'] = enemy.type.name;
          battleData['battle_duration'] = duration;
        },
        continue_: (_, __) {},
        awaitingVictoryClaim: (_, __) {},
        wrongClaim: (_, __) {},
        escape: (_, escapedAt) {},
        timeOut: (_, timedOutAt) {},
        error: (_, __) {},
      );

      await _database.insertBattleHistory(battleData);

      Logger.info('Battle result saved successfully');
      
    } catch (e, stackTrace) {
      Logger.error('Failed to save battle result', e, stackTrace);
      throw DataException('Failed to save battle result: $e');
    }
  }

  /// Load battle history
  Future<List<BattleResultModel>> loadBattleHistory({int? limit}) async {
    try {
      Logger.info('Loading battle history');

      final historyData = await _database.getBattleHistory(limit: limit);
      final results = historyData
          .map((data) => BattleResultModel.fromJson(data['result_data']))
          .toList();

      return results;
      
    } catch (e, stackTrace) {
      Logger.error('Failed to load battle history', e, stackTrace);
      throw DataException('Failed to load battle history: $e');
    }
  }

  /// Check if this is first launch
  Future<bool> isFirstLaunch() async {
    try {
      return await _preferences.isFirstLaunch();
    } catch (e) {
      Logger.error('Failed to check first launch', e);
      return true; // Default to first launch on error
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
      return false; // Default to not completed on error
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

  /// Get quick player stats from preferences
  Future<PlayerQuickStats> getQuickStats() async {
    try {
      final level = await _preferences.getPlayerLevel();
      final battles = await _preferences.getTotalBattles();
      final victories = await _preferences.getTotalVictories();

      return PlayerQuickStats(
        level: level,
        totalBattles: battles,
        totalVictories: victories,
        winRate: battles > 0 ? victories / battles : 0.0,
      );
      
    } catch (e) {
      Logger.error('Failed to get quick stats', e);
      return const PlayerQuickStats(
        level: 1,
        totalBattles: 0,
        totalVictories: 0,
        winRate: 0.0,
      );
    }
  }

  /// Clear all game data (for reset)
  Future<void> clearAllData() async {
    try {
      Logger.info('Clearing all game data');

      await _database.clearAllData();
      await _preferences.clear();

      Logger.info('All game data cleared');
      
    } catch (e, stackTrace) {
      Logger.error('Failed to clear game data', e, stackTrace);
      throw DataException('Failed to clear game data: $e');
    }
  }

  /// Create new game data for first-time players
  Future<GameDataModel> _createNewGameData() async {
    final now = DateTime.now();
    
    // Create initial inventory with starter prime
    final starterPrime = PrimeModel(
      value: 2,
      count: 3,
      firstObtained: now,
      usageCount: 0,
    );

    final gameData = GameDataModel(
      playerLevel: 1,
      experience: 0,
      totalBattles: 0,
      totalVictories: 0,
      totalEscapes: 0,
      totalTimeOuts: 0,
      totalPowerEnemiesDefeated: 0,
      inventory: [starterPrime],
      battleHistory: [],
      tutorialCompleted: false,
      createdAt: now,
      lastPlayedAt: now,
    );

    // Save the new game data
    await saveGameData(gameData);

    // Also save the initial prime to database
    await _database.insertOrUpdatePrime(starterPrime.toJson());

    return gameData;
  }

  /// Export game data for backup
  Future<Map<String, dynamic>> exportGameData() async {
    try {
      Logger.info('Exporting game data');

      final gameData = await loadGameData();
      final inventory = await loadInventory();
      final battleHistory = await loadBattleHistory();

      return {
        'gameData': gameData.toJson(),
        'inventory': inventory.primes.map((p) => _mapper.primeToModel(p).toJson()).toList(),
        'battleHistory': battleHistory.map((b) => b.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0.0',
      };
      
    } catch (e, stackTrace) {
      Logger.error('Failed to export game data', e, stackTrace);
      throw DataException('Failed to export game data: $e');
    }
  }

  /// Import game data from backup
  Future<void> importGameData(Map<String, dynamic> data) async {
    try {
      Logger.info('Importing game data');

      // Clear existing data
      await clearAllData();

      // Import game data
      final gameData = GameDataModel.fromJson(data['gameData']);
      await saveGameData(gameData);

      // Import inventory
      final inventoryData = data['inventory'] as List;
      for (final primeData in inventoryData) {
        await _database.insertOrUpdatePrime(primeData);
      }

      // Import battle history
      final historyData = data['battleHistory'] as List;
      for (final battleData in historyData) {
        final result = BattleResultModel.fromJson(battleData);
        await saveBattleResult(result);
      }

      Logger.info('Game data imported successfully');
      
    } catch (e, stackTrace) {
      Logger.error('Failed to import game data', e, stackTrace);
      throw DataException('Failed to import game data: $e');
    }
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