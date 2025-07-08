import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/constants/app_constants.dart';
import '../../core/exceptions/data_exception.dart' as core_exceptions;
import '../../core/utils/logger.dart';

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
      final path = join(databasesPath, AppConstants.databaseName);

      Logger.info('Initializing database at: $path');

      return await openDatabase(
        path,
        version: AppConstants.databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to initialize database', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to initialize database: $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      Logger.info('Creating database tables');

      // Primes table
      await db.execute('''
        CREATE TABLE primes (
          value INTEGER PRIMARY KEY,
          count INTEGER NOT NULL DEFAULT 0,
          first_obtained INTEGER NOT NULL,
          usage_count INTEGER NOT NULL DEFAULT 0
        )
      ''');

      // Game data table
      await db.execute('''
        CREATE TABLE game_data (
          id INTEGER PRIMARY KEY,
          player_level INTEGER NOT NULL DEFAULT 1,
          experience INTEGER NOT NULL DEFAULT 0,
          total_battles INTEGER NOT NULL DEFAULT 0,
          total_victories INTEGER NOT NULL DEFAULT 0,
          total_escapes INTEGER NOT NULL DEFAULT 0,
          total_time_outs INTEGER NOT NULL DEFAULT 0,
          total_power_enemies_defeated INTEGER NOT NULL DEFAULT 0,
          tutorial_completed INTEGER NOT NULL DEFAULT 0,
          created_at INTEGER NOT NULL,
          last_played_at INTEGER NOT NULL
        )
      ''');

      // Battle history table
      await db.execute('''
        CREATE TABLE battle_history (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          battle_type TEXT NOT NULL,
          enemy_value INTEGER,
          enemy_type TEXT,
          result_data TEXT NOT NULL,
          completed_at INTEGER NOT NULL,
          battle_duration INTEGER
        )
      ''');

      // Achievements table
      await db.execute('''
        CREATE TABLE achievements (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          description TEXT NOT NULL,
          unlocked INTEGER NOT NULL DEFAULT 0,
          unlocked_at INTEGER,
          progress INTEGER NOT NULL DEFAULT 0,
          target INTEGER NOT NULL DEFAULT 1
        )
      ''');

      Logger.info('Database tables created successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to create database tables', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to create database tables: $e');
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Logger.info('Upgrading database from version $oldVersion to $newVersion');
    // Handle database migrations here when needed
  }

  // Prime operations
  Future<void> insertOrUpdatePrime(Map<String, dynamic> prime) async {
    try {
      final db = await database;
      await db.insert(
        'primes',
        prime,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to insert/update prime', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to insert/update prime: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllPrimes() async {
    try {
      final db = await database;
      return await db.query('primes', orderBy: 'value ASC');
    } catch (e, stackTrace) {
      Logger.error('Failed to get all primes', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to get all primes: $e');
    }
  }

  Future<Map<String, dynamic>?> getPrime(int value) async {
    try {
      final db = await database;
      final results = await db.query(
        'primes',
        where: 'value = ?',
        whereArgs: [value],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e, stackTrace) {
      Logger.error('Failed to get prime $value', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to get prime: $e');
    }
  }

  Future<void> deletePrime(int value) async {
    try {
      final db = await database;
      await db.delete('primes', where: 'value = ?', whereArgs: [value]);
    } catch (e, stackTrace) {
      Logger.error('Failed to delete prime $value', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to delete prime: $e');
    }
  }

  // Game data operations
  Future<void> insertOrUpdateGameData(Map<String, dynamic> gameData) async {
    try {
      final db = await database;
      await db.insert(
        'game_data',
        {...gameData, 'id': 1}, // Single row for game data
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to insert/update game data', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to insert/update game data: $e');
    }
  }

  Future<Map<String, dynamic>?> getGameData() async {
    try {
      final db = await database;
      final results = await db.query('game_data', where: 'id = ?', whereArgs: [1]);
      return results.isNotEmpty ? results.first : null;
    } catch (e, stackTrace) {
      Logger.error('Failed to get game data', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to get game data: $e');
    }
  }

  // Battle history operations
  Future<void> insertBattleHistory(Map<String, dynamic> battleData) async {
    try {
      final db = await database;
      await db.insert('battle_history', battleData);
    } catch (e, stackTrace) {
      Logger.error('Failed to insert battle history', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to insert battle history: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBattleHistory({int? limit}) async {
    try {
      final db = await database;
      return await db.query(
        'battle_history',
        orderBy: 'completed_at DESC',
        limit: limit,
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to get battle history', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to get battle history: $e');
    }
  }

  // Utility methods
  Future<void> clearAllData() async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('primes');
        await txn.delete('game_data');
        await txn.delete('battle_history');
        await txn.delete('achievements');
      });
      Logger.info('All data cleared successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to clear all data', e, stackTrace);
      throw core_exceptions.DatabaseException('Failed to clear all data: $e');
    }
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
      Logger.info('Database closed');
    }
  }
}