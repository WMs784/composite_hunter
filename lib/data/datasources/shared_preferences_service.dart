import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/exceptions/data_exception.dart';
import '../../core/utils/logger.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  
  factory SharedPreferencesService() => _instance;
  SharedPreferencesService._internal();

  Future<SharedPreferences> get preferences async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  // Boolean operations
  Future<bool> setBool(String key, bool value) async {
    try {
      final prefs = await preferences;
      final result = await prefs.setBool(key, value);
      Logger.debug('Set bool: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set bool $key', e, stackTrace);
      throw DataException('Failed to set boolean preference: $e');
    }
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      final prefs = await preferences;
      final value = prefs.getBool(key) ?? defaultValue;
      Logger.debug('Get bool: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get bool $key', e, stackTrace);
      return defaultValue;
    }
  }

  // Integer operations
  Future<bool> setInt(String key, int value) async {
    try {
      final prefs = await preferences;
      final result = await prefs.setInt(key, value);
      Logger.debug('Set int: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set int $key', e, stackTrace);
      throw DataException('Failed to set integer preference: $e');
    }
  }

  Future<int> getInt(String key, {int defaultValue = 0}) async {
    try {
      final prefs = await preferences;
      final value = prefs.getInt(key) ?? defaultValue;
      Logger.debug('Get int: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get int $key', e, stackTrace);
      return defaultValue;
    }
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    try {
      final prefs = await preferences;
      final result = await prefs.setString(key, value);
      Logger.debug('Set string: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set string $key', e, stackTrace);
      throw DataException('Failed to set string preference: $e');
    }
  }

  Future<String?> getString(String key) async {
    try {
      final prefs = await preferences;
      final value = prefs.getString(key);
      Logger.debug('Get string: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get string $key', e, stackTrace);
      return null;
    }
  }

  // JSON operations
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await setString(key, jsonString);
    } catch (e, stackTrace) {
      Logger.error('Failed to set JSON $key', e, stackTrace);
      throw DataException('Failed to set JSON preference: $e');
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

  // List operations
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      final prefs = await preferences;
      final result = await prefs.setStringList(key, value);
      Logger.debug('Set string list: $key = $value');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to set string list $key', e, stackTrace);
      throw DataException('Failed to set string list preference: $e');
    }
  }

  Future<List<String>> getStringList(String key) async {
    try {
      final prefs = await preferences;
      final value = prefs.getStringList(key) ?? [];
      Logger.debug('Get string list: $key = $value');
      return value;
    } catch (e, stackTrace) {
      Logger.error('Failed to get string list $key', e, stackTrace);
      return [];
    }
  }

  // Game-specific convenience methods
  Future<bool> isFirstLaunch() async {
    return await getBool(AppConstants.firstLaunchKey, defaultValue: true);
  }

  Future<void> setFirstLaunchCompleted() async {
    await setBool(AppConstants.firstLaunchKey, false);
  }

  Future<bool> isTutorialCompleted() async {
    return await getBool(AppConstants.tutorialCompletedKey);
  }

  Future<void> setTutorialCompleted() async {
    await setBool(AppConstants.tutorialCompletedKey, true);
  }

  Future<int> getPlayerLevel() async {
    return await getInt(AppConstants.playerLevelKey, defaultValue: 1);
  }

  Future<void> setPlayerLevel(int level) async {
    await setInt(AppConstants.playerLevelKey, level);
  }

  Future<int> getTotalBattles() async {
    return await getInt(AppConstants.totalBattlesKey);
  }

  Future<void> setTotalBattles(int battles) async {
    await setInt(AppConstants.totalBattlesKey, battles);
  }

  Future<int> getTotalVictories() async {
    return await getInt(AppConstants.totalVictoriesKey);
  }

  Future<void> setTotalVictories(int victories) async {
    await setInt(AppConstants.totalVictoriesKey, victories);
  }

  // Utility methods
  Future<bool> containsKey(String key) async {
    try {
      final prefs = await preferences;
      return prefs.containsKey(key);
    } catch (e, stackTrace) {
      Logger.error('Failed to check key $key', e, stackTrace);
      return false;
    }
  }

  Future<bool> remove(String key) async {
    try {
      final prefs = await preferences;
      final result = await prefs.remove(key);
      Logger.debug('Removed key: $key');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to remove key $key', e, stackTrace);
      throw DataException('Failed to remove preference: $e');
    }
  }

  Future<bool> clear() async {
    try {
      final prefs = await preferences;
      final result = await prefs.clear();
      Logger.info('Cleared all preferences');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Failed to clear preferences', e, stackTrace);
      throw DataException('Failed to clear preferences: $e');
    }
  }
}