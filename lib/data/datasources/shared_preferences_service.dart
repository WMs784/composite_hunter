import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/logger.dart';
import '../../core/exceptions/data_exception.dart' as core_exceptions;

/// Service for managing shared preferences data
class SharedPreferencesService {
  static SharedPreferences? _prefs;
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  
  factory SharedPreferencesService() => _instance;
  SharedPreferencesService._internal();

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ========== KEYS CONSTANTS ==========
  static const String _keyFirstLaunch = 'first_launch';
  static const String _keyTutorialCompleted = 'tutorial_completed';
  static const String _keyPlayerLevel = 'player_level';
  static const String _keyTotalBattles = 'total_battles';
  static const String _keyTotalVictories = 'total_victories';
  static const String _keyCurrentPlayerId = 'current_player_id';
  static const String _keyLastBackupTime = 'last_backup_time';
  static const String _keyDatabaseVersion = 'database_version';
  static const String _keyAppVersion = 'app_version';
  static const String _keyGameDifficulty = 'game_difficulty';
  static const String _keyGameLanguage = 'game_language';
  static const String _keyLastSessionTime = 'last_session_time';
  static const String _keyTotalPlayTime = 'total_play_time';
  static const String _keyDailyGoalProgress = 'daily_goal_progress';
  static const String _keyWeeklyGoalProgress = 'weekly_goal_progress';
  static const String _keyMonthlyGoalProgress = 'monthly_goal_progress';
  static const String _keyAchievementNotifications = 'achievement_notifications';
  static const String _keyLevelUpNotifications = 'level_up_notifications';
  static const String _keyDailyReminders = 'daily_reminders';
  static const String _keySoundEffects = 'sound_effects';
  static const String _keyBackgroundMusic = 'background_music';
  static const String _keySoundVolume = 'sound_volume';
  static const String _keyMusicVolume = 'music_volume';
  static const String _keyVibration = 'vibration';
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyAnimations = 'animations';
  static const String _keyAnimationSpeed = 'animation_speed';
  static const String _keyAutoSave = 'auto_save';
  static const String _keyShowHints = 'show_hints';
  static const String _keyShowTimer = 'show_timer';
  static const String _keyShowProgress = 'show_progress';
  static const String _keyShowStatistics = 'show_statistics';
  static const String _keyOfflineMode = 'offline_mode';
  static const String _keyDebugMode = 'debug_mode';
  static const String _keyTelemetryEnabled = 'telemetry_enabled';
  static const String _keyAnalyticsEnabled = 'analytics_enabled';
  static const String _keyPrimeInventorySort = 'prime_inventory_sort';
  static const String _keyBattleHistoryLimit = 'battle_history_limit';
  static const String _keyRecentAchievements = 'recent_achievements';
  static const String _keyFavoriteStrategies = 'favorite_strategies';
  static const String _keyCustomTheme = 'custom_theme';

  // ========== FIRST LAUNCH & TUTORIAL ==========

  /// Check if this is the first launch
  Future<bool> isFirstLaunch() async {
    try {
      final prefs = await _preferences;
      final isFirst = prefs.getBool(_keyFirstLaunch) ?? true;
      Logger.info('First launch check: $isFirst');
      return isFirst;
    } catch (e, stackTrace) {
      Logger.error('Failed to check first launch', e, stackTrace);
      return true; // Default to first launch on error
    }
  }

  /// Mark first launch as completed
  Future<void> setFirstLaunchCompleted() async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keyFirstLaunch, false);
      Logger.info('First launch marked as completed');
    } catch (e, stackTrace) {
      Logger.error('Failed to set first launch completed', e, stackTrace);
      throw core_exceptions.DataException('Failed to set first launch completed: $e');
    }
  }

  /// Check if tutorial is completed
  Future<bool> isTutorialCompleted() async {
    try {
      final prefs = await _preferences;
      final isCompleted = prefs.getBool(_keyTutorialCompleted) ?? false;
      Logger.info('Tutorial completion check: $isCompleted');
      return isCompleted;
    } catch (e, stackTrace) {
      Logger.error('Failed to check tutorial completion', e, stackTrace);
      return false; // Default to not completed on error
    }
  }

  /// Mark tutorial as completed
  Future<void> setTutorialCompleted() async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keyTutorialCompleted, true);
      Logger.info('Tutorial marked as completed');
    } catch (e, stackTrace) {
      Logger.error('Failed to set tutorial completed', e, stackTrace);
      throw core_exceptions.DataException('Failed to set tutorial completed: $e');
    }
  }

  // ========== PLAYER DATA ==========

  /// Get current player ID
  Future<int?> getCurrentPlayerId() async {
    try {
      final prefs = await _preferences;
      return prefs.getInt(_keyCurrentPlayerId);
    } catch (e, stackTrace) {
      Logger.error('Failed to get current player ID', e, stackTrace);
      return null;
    }
  }

  /// Set current player ID
  Future<void> setCurrentPlayerId(int playerId) async {
    try {
      final prefs = await _preferences;
      await prefs.setInt(_keyCurrentPlayerId, playerId);
      Logger.info('Current player ID set to: $playerId');
    } catch (e, stackTrace) {
      Logger.error('Failed to set current player ID', e, stackTrace);
      throw core_exceptions.DataException('Failed to set current player ID: $e');
    }
  }

  /// Get player level
  Future<int> getPlayerLevel() async {
    try {
      final prefs = await _preferences;
      return prefs.getInt(_keyPlayerLevel) ?? 1;
    } catch (e, stackTrace) {
      Logger.error('Failed to get player level', e, stackTrace);
      return 1; // Default level
    }
  }

  /// Set player level
  Future<void> setPlayerLevel(int level) async {
    try {
      final prefs = await _preferences;
      await prefs.setInt(_keyPlayerLevel, level);
      Logger.info('Player level set to: $level');
    } catch (e, stackTrace) {
      Logger.error('Failed to set player level', e, stackTrace);
      throw core_exceptions.DataException('Failed to set player level: $e');
    }
  }

  /// Get total battles
  Future<int> getTotalBattles() async {
    try {
      final prefs = await _preferences;
      return prefs.getInt(_keyTotalBattles) ?? 0;
    } catch (e, stackTrace) {
      Logger.error('Failed to get total battles', e, stackTrace);
      return 0;
    }
  }

  /// Set total battles
  Future<void> setTotalBattles(int battles) async {
    try {
      final prefs = await _preferences;
      await prefs.setInt(_keyTotalBattles, battles);
      Logger.info('Total battles set to: $battles');
    } catch (e, stackTrace) {
      Logger.error('Failed to set total battles', e, stackTrace);
      throw core_exceptions.DataException('Failed to set total battles: $e');
    }
  }

  /// Get total victories
  Future<int> getTotalVictories() async {
    try {
      final prefs = await _preferences;
      return prefs.getInt(_keyTotalVictories) ?? 0;
    } catch (e, stackTrace) {
      Logger.error('Failed to get total victories', e, stackTrace);
      return 0;
    }
  }

  /// Set total victories
  Future<void> setTotalVictories(int victories) async {
    try {
      final prefs = await _preferences;
      await prefs.setInt(_keyTotalVictories, victories);
      Logger.info('Total victories set to: $victories');
    } catch (e, stackTrace) {
      Logger.error('Failed to set total victories', e, stackTrace);
      throw core_exceptions.DataException('Failed to set total victories: $e');
    }
  }

  // ========== GAME SETTINGS ==========

  /// Get game difficulty
  Future<String> getGameDifficulty() async {
    try {
      final prefs = await _preferences;
      return prefs.getString(_keyGameDifficulty) ?? 'normal';
    } catch (e, stackTrace) {
      Logger.error('Failed to get game difficulty', e, stackTrace);
      return 'normal';
    }
  }

  /// Set game difficulty
  Future<void> setGameDifficulty(String difficulty) async {
    try {
      final prefs = await _preferences;
      await prefs.setString(_keyGameDifficulty, difficulty);
      Logger.info('Game difficulty set to: $difficulty');
    } catch (e, stackTrace) {
      Logger.error('Failed to set game difficulty', e, stackTrace);
      throw core_exceptions.DataException('Failed to set game difficulty: $e');
    }
  }

  /// Get game language
  Future<String> getGameLanguage() async {
    try {
      final prefs = await _preferences;
      return prefs.getString(_keyGameLanguage) ?? 'japanese';
    } catch (e, stackTrace) {
      Logger.error('Failed to get game language', e, stackTrace);
      return 'japanese';
    }
  }

  /// Set game language
  Future<void> setGameLanguage(String language) async {
    try {
      final prefs = await _preferences;
      await prefs.setString(_keyGameLanguage, language);
      Logger.info('Game language set to: $language');
    } catch (e, stackTrace) {
      Logger.error('Failed to set game language', e, stackTrace);
      throw core_exceptions.DataException('Failed to set game language: $e');
    }
  }

  // ========== AUDIO SETTINGS ==========

  /// Get sound effects enabled
  Future<bool> isSoundEffectsEnabled() async {
    try {
      final prefs = await _preferences;
      return prefs.getBool(_keySoundEffects) ?? true;
    } catch (e, stackTrace) {
      Logger.error('Failed to get sound effects setting', e, stackTrace);
      return true;
    }
  }

  /// Set sound effects enabled
  Future<void> setSoundEffectsEnabled(bool enabled) async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keySoundEffects, enabled);
      Logger.info('Sound effects set to: $enabled');
    } catch (e, stackTrace) {
      Logger.error('Failed to set sound effects', e, stackTrace);
      throw core_exceptions.DataException('Failed to set sound effects: $e');
    }
  }

  /// Get background music enabled
  Future<bool> isBackgroundMusicEnabled() async {
    try {
      final prefs = await _preferences;
      return prefs.getBool(_keyBackgroundMusic) ?? true;
    } catch (e, stackTrace) {
      Logger.error('Failed to get background music setting', e, stackTrace);
      return true;
    }
  }

  /// Set background music enabled
  Future<void> setBackgroundMusicEnabled(bool enabled) async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keyBackgroundMusic, enabled);
      Logger.info('Background music set to: $enabled');
    } catch (e, stackTrace) {
      Logger.error('Failed to set background music', e, stackTrace);
      throw core_exceptions.DataException('Failed to set background music: $e');
    }
  }

  /// Get sound volume
  Future<double> getSoundVolume() async {
    try {
      final prefs = await _preferences;
      return prefs.getDouble(_keySoundVolume) ?? 0.8;
    } catch (e, stackTrace) {
      Logger.error('Failed to get sound volume', e, stackTrace);
      return 0.8;
    }
  }

  /// Set sound volume
  Future<void> setSoundVolume(double volume) async {
    try {
      final prefs = await _preferences;
      await prefs.setDouble(_keySoundVolume, volume.clamp(0.0, 1.0));
      Logger.info('Sound volume set to: $volume');
    } catch (e, stackTrace) {
      Logger.error('Failed to set sound volume', e, stackTrace);
      throw core_exceptions.DataException('Failed to set sound volume: $e');
    }
  }

  /// Get music volume
  Future<double> getMusicVolume() async {
    try {
      final prefs = await _preferences;
      return prefs.getDouble(_keyMusicVolume) ?? 0.6;
    } catch (e, stackTrace) {
      Logger.error('Failed to get music volume', e, stackTrace);
      return 0.6;
    }
  }

  /// Set music volume
  Future<void> setMusicVolume(double volume) async {
    try {
      final prefs = await _preferences;
      await prefs.setDouble(_keyMusicVolume, volume.clamp(0.0, 1.0));
      Logger.info('Music volume set to: $volume');
    } catch (e, stackTrace) {
      Logger.error('Failed to set music volume', e, stackTrace);
      throw core_exceptions.DataException('Failed to set music volume: $e');
    }
  }

  /// Get vibration enabled
  Future<bool> isVibrationEnabled() async {
    try {
      final prefs = await _preferences;
      return prefs.getBool(_keyVibration) ?? true;
    } catch (e, stackTrace) {
      Logger.error('Failed to get vibration setting', e, stackTrace);
      return true;
    }
  }

  /// Set vibration enabled
  Future<void> setVibrationEnabled(bool enabled) async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keyVibration, enabled);
      Logger.info('Vibration set to: $enabled');
    } catch (e, stackTrace) {
      Logger.error('Failed to set vibration', e, stackTrace);
      throw core_exceptions.DataException('Failed to set vibration: $e');
    }
  }

  // ========== DISPLAY SETTINGS ==========

  /// Get dark mode enabled
  Future<bool> isDarkModeEnabled() async {
    try {
      final prefs = await _preferences;
      return prefs.getBool(_keyDarkMode) ?? false;
    } catch (e, stackTrace) {
      Logger.error('Failed to get dark mode setting', e, stackTrace);
      return false;
    }
  }

  /// Set dark mode enabled
  Future<void> setDarkModeEnabled(bool enabled) async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keyDarkMode, enabled);
      Logger.info('Dark mode set to: $enabled');
    } catch (e, stackTrace) {
      Logger.error('Failed to set dark mode', e, stackTrace);
      throw core_exceptions.DataException('Failed to set dark mode: $e');
    }
  }

  /// Get animations enabled
  Future<bool> isAnimationsEnabled() async {
    try {
      final prefs = await _preferences;
      return prefs.getBool(_keyAnimations) ?? true;
    } catch (e, stackTrace) {
      Logger.error('Failed to get animations setting', e, stackTrace);
      return true;
    }
  }

  /// Set animations enabled
  Future<void> setAnimationsEnabled(bool enabled) async {
    try {
      final prefs = await _preferences;
      await prefs.setBool(_keyAnimations, enabled);
      Logger.info('Animations set to: $enabled');
    } catch (e, stackTrace) {
      Logger.error('Failed to set animations', e, stackTrace);
      throw core_exceptions.DataException('Failed to set animations: $e');
    }
  }

  /// Get animation speed
  Future<double> getAnimationSpeed() async {
    try {
      final prefs = await _preferences;
      return prefs.getDouble(_keyAnimationSpeed) ?? 1.0;
    } catch (e, stackTrace) {
      Logger.error('Failed to get animation speed', e, stackTrace);
      return 1.0;
    }
  }

  /// Set animation speed
  Future<void> setAnimationSpeed(double speed) async {
    try {
      final prefs = await _preferences;
      await prefs.setDouble(_keyAnimationSpeed, speed.clamp(0.5, 2.0));
      Logger.info('Animation speed set to: $speed');
    } catch (e, stackTrace) {
      Logger.error('Failed to set animation speed', e, stackTrace);
      throw core_exceptions.DataException('Failed to set animation speed: $e');
    }
  }

  // ========== UTILITY METHODS ==========

  /// Clear all preferences
  Future<void> clear() async {
    try {
      final prefs = await _preferences;
      await prefs.clear();
      Logger.info('All preferences cleared');
    } catch (e, stackTrace) {
      Logger.error('Failed to clear preferences', e, stackTrace);
      throw core_exceptions.DataException('Failed to clear preferences: $e');
    }
  }

  /// Get all preferences as a map
  Future<Map<String, dynamic>> getAllPreferences() async {
    try {
      final prefs = await _preferences;
      final keys = prefs.getKeys();
      final prefsMap = <String, dynamic>{};
      
      for (final key in keys) {
        final value = prefs.get(key);
        prefsMap[key] = value;
      }
      
      return prefsMap;
    } catch (e, stackTrace) {
      Logger.error('Failed to get all preferences', e, stackTrace);
      throw core_exceptions.DataException('Failed to get all preferences: $e');
    }
  }

  /// Check if a preference exists
  Future<bool> containsKey(String key) async {
    try {
      final prefs = await _preferences;
      return prefs.containsKey(key);
    } catch (e, stackTrace) {
      Logger.error('Failed to check preference key', e, stackTrace);
      return false;
    }
  }

  /// Remove a specific preference
  Future<void> remove(String key) async {
    try {
      final prefs = await _preferences;
      await prefs.remove(key);
      Logger.info('Preference removed: $key');
    } catch (e, stackTrace) {
      Logger.error('Failed to remove preference', e, stackTrace);
      throw core_exceptions.DataException('Failed to remove preference: $e');
    }
  }

  /// Get custom setting
  Future<T?> getCustomSetting<T>(String key) async {
    try {
      final prefs = await _preferences;
      return prefs.get(key) as T?;
    } catch (e, stackTrace) {
      Logger.error('Failed to get custom setting $key', e, stackTrace);
      return null;
    }
  }

  /// Set custom setting
  Future<void> setCustomSetting<T>(String key, T value) async {
    try {
      final prefs = await _preferences;
      
      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      } else {
        // For complex objects, store as JSON string
        await prefs.setString(key, jsonEncode(value));
      }
      
      Logger.info('Custom setting set: $key = $value');
    } catch (e, stackTrace) {
      Logger.error('Failed to set custom setting $key', e, stackTrace);
      throw core_exceptions.DataException('Failed to set custom setting: $e');
    }
  }

  /// Export preferences to JSON
  Future<String> exportPreferences() async {
    try {
      final allPrefs = await getAllPreferences();
      return jsonEncode(allPrefs);
    } catch (e, stackTrace) {
      Logger.error('Failed to export preferences', e, stackTrace);
      throw core_exceptions.DataException('Failed to export preferences: $e');
    }
  }

  /// Import preferences from JSON
  Future<void> importPreferences(String jsonData) async {
    try {
      final Map<String, dynamic> prefsMap = jsonDecode(jsonData);
      final prefs = await _preferences;
      
      for (final entry in prefsMap.entries) {
        final key = entry.key;
        final value = entry.value;
        
        if (value is String) {
          await prefs.setString(key, value);
        } else if (value is int) {
          await prefs.setInt(key, value);
        } else if (value is double) {
          await prefs.setDouble(key, value);
        } else if (value is bool) {
          await prefs.setBool(key, value);
        } else if (value is List) {
          await prefs.setStringList(key, value.cast<String>());
        }
      }
      
      Logger.info('Preferences imported successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to import preferences', e, stackTrace);
      throw core_exceptions.DataException('Failed to import preferences: $e');
    }
  }

  // ========== BACKWARD COMPATIBILITY METHODS ==========

  /// Basic operations for backward compatibility
  Future<bool> setBool(String key, bool value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setBool(key, value);
      Logger.debug('Set bool: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set bool $key', e, stackTrace);
      throw core_exceptions.DataException('Failed to set boolean preference: $e');
    }
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getBool(key) ?? defaultValue;
      Logger.debug('Get bool: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get bool $key', e, stackTrace);
      return defaultValue;
    }
  }

  Future<bool> setInt(String key, int value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setInt(key, value);
      Logger.debug('Set int: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set int $key', e, stackTrace);
      throw core_exceptions.DataException('Failed to set integer preference: $e');
    }
  }

  Future<int> getInt(String key, {int defaultValue = 0}) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getInt(key) ?? defaultValue;
      Logger.debug('Get int: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get int $key', e, stackTrace);
      return defaultValue;
    }
  }

  Future<bool> setString(String key, String value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setString(key, value);
      Logger.debug('Set string: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set string $key', e, stackTrace);
      throw core_exceptions.DataException('Failed to set string preference: $e');
    }
  }

  Future<String?> getString(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getString(key);
      Logger.debug('Get string: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get string $key', e, stackTrace);
      return null;
    }
  }

  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await setString(key, jsonString);
    } catch (e, stackTrace) {
      Logger.error('Failed to set JSON $key', e, stackTrace);
      throw core_exceptions.DataException('Failed to set JSON preference: $e');
    }
  }

  Future<Map<String, dynamic>?> getJson(String key) async {
    try {
      final jsonString = await getString(key);
      if (jsonString == null) return null;
      
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      Logger.error('Failed to get JSON $key', e, stackTrace);
      return null;
    }
  }

  Future<bool> setStringList(String key, List<String> value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setStringList(key, value);
      Logger.debug('Set string list: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set string list $key', e, stackTrace);
      throw core_exceptions.DataException('Failed to set string list preference: $e');
    }
  }

  Future<List<String>> getStringList(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getStringList(key) ?? [];
      Logger.debug('Get string list: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get string list $key', e, stackTrace);
      return [];
    }
  }
}