import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../core/utils/logger.dart';

/// 素数の使用統計を管理するプロバイダー
class PrimeUsageNotifier extends StateNotifier<Map<int, int>> {
  PrimeUsageNotifier() : super({}) {
    _loadUsageData();
  }

  /// 使用統計を読み込み
  Future<void> _loadUsageData() async {
    final prefs = await SharedPreferences.getInstance();
    final usageJson = prefs.getString('prime_usage_statistics');

    if (usageJson == null) {
      return;
    }

    try {
      final Map<String, dynamic> usageData = json.decode(usageJson);
      final Map<int, int> usage = {};
      usageData.forEach((key, value) {
        usage[int.parse(key)] = value as int;
      });
      state = usage;
    } catch (e) {
      Logger.error('Failed to load usage data: $e');
    }
  }

  /// 使用統計を保存
  Future<void> _saveUsageData() async {
    final prefs = await SharedPreferences.getInstance();
    final usageData = <String, int>{};
    state.forEach((key, value) {
      usageData[key.toString()] = value;
    });

    await prefs.setString('prime_usage_statistics', json.encode(usageData));
  }

  /// 素数の使用を記録
  void recordPrimeUsage(int primeValue) {
    if (primeValue <= 1) return;

    final newState = Map<int, int>.from(state);
    newState[primeValue] = (newState[primeValue] ?? 0) + 1;
    state = newState;

    _saveUsageData().catchError((error) {
      Logger.error('Failed to save usage data: $error');
    });
  }

  /// 指定した素数の使用回数を取得
  int getUsageCount(int primeValue) {
    return state[primeValue] ?? 0;
  }

  /// 総使用回数を取得
  int get totalUsage {
    return state.values.fold(0, (sum, count) => sum + count);
  }

  /// 最も使用された素数を取得
  int? get mostUsedPrime {
    if (state.isEmpty) return null;

    int mostUsed = state.keys.first;
    int maxUsage = state[mostUsed]!;

    for (final entry in state.entries) {
      if (entry.value > maxUsage) {
        mostUsed = entry.key;
        maxUsage = entry.value;
      }
    }

    return mostUsed;
  }

  /// 使用統計をリセット（デバッグ用）
  Future<void> resetUsageData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('prime_usage_statistics');
    state = {};
  }
}

final primeUsageProvider =
    StateNotifierProvider<PrimeUsageNotifier, Map<int, int>>(
  (ref) => PrimeUsageNotifier(),
);
