import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/prime.dart';
import 'battle_session_provider.dart';

/// プレイヤーのアイテム（素数）インベントリを管理するプロバイダー
class InventoryNotifier extends StateNotifier<List<Prime>> {
  InventoryNotifier() : super([]) {
    _loadInventory();
  }

  /// インベントリを初期化（ゲーム開始時）
  void _initializeInventory() {
    state = [
      Prime(value: 2, count: 5, firstObtained: DateTime.now()),
      Prime(value: 3, count: 2, firstObtained: DateTime.now()),
      Prime(value: 5, count: 1, firstObtained: DateTime.now()),
      Prime(value: 7, count: 0, firstObtained: DateTime.now()),
      Prime(value: 11, count: 0, firstObtained: DateTime.now()),
      Prime(value: 13, count: 0, firstObtained: DateTime.now()),
    ];
    _saveInventory();
  }

  /// インベントリを読み込み
  Future<void> _loadInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final inventoryJson = prefs.getString('player_inventory');
    
    if (inventoryJson == null) {
      // 初回起動時は初期アイテムを設定
      _initializeInventory();
      return;
    }
    
    try {
      final List<dynamic> inventoryData = json.decode(inventoryJson);
      state = inventoryData.map((item) {
        return Prime(
          value: item['value'],
          count: item['count'],
          firstObtained: DateTime.parse(item['firstObtained']),
        );
      }).toList();
    } catch (e) {
      // データが破損している場合は初期化
      _initializeInventory();
    }
  }

  /// インベントリを保存
  Future<void> _saveInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final inventoryData = state.map((prime) {
      return {
        'value': prime.value,
        'count': prime.count,
        'firstObtained': prime.firstObtained.toIso8601String(),
      };
    }).toList();
    
    await prefs.setString('player_inventory', json.encode(inventoryData));
  }

  /// 素数を使用（減算）
  void usePrime(int primeValue) {
    if (primeValue <= 1) return;
    
    final updatedInventory = state.map((prime) {
      if (prime.value == primeValue && prime.count > 0) {
        return prime.copyWith(count: prime.count - 1);
      }
      return prime;
    }).toList();
    
    state = updatedInventory;
    _saveInventory();
  }

  /// 素数を獲得（加算）
  void addPrime(int primeValue) {
    if (primeValue <= 1) return;
    
    final existingIndex = state.indexWhere((prime) => prime.value == primeValue);
    
    if (existingIndex >= 0) {
      // 既に所持している素数の場合は個数を増やす
      final updatedInventory = state.map((prime) {
        if (prime.value == primeValue) {
          return prime.copyWith(count: prime.count + 1);
        }
        return prime;
      }).toList();
      state = updatedInventory;
    } else {
      // 新しい素数の場合は追加
      final newPrime = Prime(
        value: primeValue,
        count: 1,
        firstObtained: DateTime.now(),
      );
      state = [...state, newPrime];
    }
    
    _saveInventory();
  }

  /// 指定した素数の所持数を取得
  int getPrimeCount(int primeValue) {
    final prime = state.firstWhere(
      (p) => p.value == primeValue,
      orElse: () => Prime(value: primeValue, count: 0, firstObtained: DateTime.now()),
    );
    return prime.count;
  }

  /// 素数が使用可能かチェック
  bool canUsePrime(int primeValue, int enemyValue) {
    if (enemyValue % primeValue != 0) return false; // 割り切れない
    return getPrimeCount(primeValue) > 0; // 在庫がある
  }

  /// インベントリをリセット（デバッグ用）
  Future<void> resetInventory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('player_inventory');
    _initializeInventory();
  }
  
  /// アイテム状態を指定した状態に復元
  void restoreInventory(List<Prime> savedInventory) {
    state = List.from(savedInventory);
    _saveInventory();
  }

  /// 勝利時の報酬として素数を獲得
  void receiveVictoryReward(int defeatedEnemy) {
    // 倒した敵が素数の場合、その素数を獲得
    if (_isPrime(defeatedEnemy)) {
      addPrime(defeatedEnemy);
    }
  }
  
  /// 完全な素因数分解の結果を獲得
  void receiveFactorizationReward(int finalPrime, List<int> usedPrimes) {
    // 最終的に残った素数を獲得
    if (_isPrime(finalPrime)) {
      addPrime(finalPrime);
    }
    
    // バトル中に使用した素数もすべて獲得
    for (int prime in usedPrimes) {
      if (_isPrime(prime)) {
        addPrime(prime);
      }
    }
    
    _saveInventory();
  }

  /// 累乗敵からの特別報酬
  void receivePowerEnemyReward(int baseValue, int power) {
    for (int i = 0; i < power; i++) {
      addPrime(baseValue);
    }
  }

  /// 素数判定
  bool _isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    
    for (int i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    
    return true;
  }
}

final inventoryProvider = StateNotifierProvider<InventoryNotifier, List<Prime>>(
  (ref) => InventoryNotifier(),
);

/// バトル用インベントリプロバイダー（ステージ選択時は選択されたアイテムのみ）
final battleInventoryProvider = Provider<List<Prime>>((ref) {
  final battleSession = ref.watch(battleSessionProvider);
  final mainInventory = ref.watch(inventoryProvider);
  
  // ステージモードで選択されたアイテムがある場合はそれを使用
  if (!battleSession.isPracticeMode && 
      battleSession.stageStartInventory != null && 
      battleSession.stageStartInventory!.isNotEmpty) {
    return battleSession.stageStartInventory!;
  }
  
  // それ以外は通常のインベントリを使用
  return mainInventory;
});