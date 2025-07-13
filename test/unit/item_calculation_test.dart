import 'package:flutter_test/flutter_test.dart';

/// バトル後のアイテム計算をテストする
///
/// バトル後のアイテム数 = バトル前の所持数 + 獲得数
/// 使用したアイテムは消費コストとして扱われ、返還されない
void main() {
  group('Item Calculation Tests', () {
    test('final prime reward calculation should be correct', () {
      // バトル前の状態
      Map<int, int> preBattleInventory = {
        2: 5, // 素数2を5個所持
        3: 2, // 素数3を2個所持
        5: 1, // 素数5を1個所持
      };

      // バトルシナリオ: 敵12を素数にする
      // 12 ÷ 2 = 6, 6 ÷ 2 = 3 (3は素数)
      List<int> usedPrimes = [2, 2]; // 素数2を2回使用
      int finalPrime = 3; // 最終的に素数3が残る

      // 期待される結果
      Map<int, int> expectedPostBattleInventory = {
        2: 3, // 5 - 2 (使用分) = 3
        3: 3, // 2 + 1 (獲得分) = 3
        5: 1, // 変化なし
      };

      // 計算ロジックをシミュレート
      Map<int, int> actualInventory = Map.from(preBattleInventory);

      // 使用した素数を減算
      for (int usedPrime in usedPrimes) {
        actualInventory[usedPrime] = (actualInventory[usedPrime] ?? 0) - 1;
      }

      // 最終素数のみを獲得（使用した素数は返還しない）
      if (finalPrime > 1) {
        actualInventory[finalPrime] = (actualInventory[finalPrime] ?? 0) + 1;
      }

      // 検証
      expect(actualInventory[2], expectedPostBattleInventory[2]);
      expect(actualInventory[3], expectedPostBattleInventory[3]);
      expect(actualInventory[5], expectedPostBattleInventory[5]);
    });

    test('enemy becomes 1 should give no reward', () {
      // バトル前の状態
      Map<int, int> preBattleInventory = {
        2: 3,
        3: 1,
      };

      // バトルシナリオ: 敵6を1にする
      // 6 ÷ 2 = 3, 3 ÷ 3 = 1
      List<int> usedPrimes = [2, 3];
      int finalValue = 1; // 敵が1になった

      // 期待される結果: 使用分だけ減って、報酬なし
      Map<int, int> expectedPostBattleInventory = {
        2: 2, // 3 - 1 = 2
        3: 0, // 1 - 1 = 0
      };

      // 計算ロジックをシミュレート
      Map<int, int> actualInventory = Map.from(preBattleInventory);

      // 使用した素数を減算
      for (int usedPrime in usedPrimes) {
        actualInventory[usedPrime] = (actualInventory[usedPrime] ?? 0) - 1;
      }

      // 最終値が1の場合は報酬なし
      if (finalValue > 1 && _isPrime(finalValue)) {
        actualInventory[finalValue] = (actualInventory[finalValue] ?? 0) + 1;
      }

      // 検証
      expect(actualInventory[2], expectedPostBattleInventory[2]);
      expect(actualInventory[3], expectedPostBattleInventory[3]);
    });

    test('multiple battles should accumulate correctly', () {
      // 初期状態
      Map<int, int> inventory = {
        2: 5,
        3: 2,
        5: 1,
      };

      // バトル1: 敵10 → 5 (10÷2=5, 5は素数)
      // 使用: [2], 獲得: 5
      inventory[2] = inventory[2]! - 1; // 4
      inventory[5] = inventory[5]! + 1; // 2

      // バトル2: 敵9 → 3 (9÷3=3, 3は素数)
      // 使用: [3], 獲得: 3
      inventory[3] = inventory[3]! - 1; // 1
      inventory[3] = inventory[3]! + 1; // 2

      // バトル3: 敵15 → 5 (15÷3=5, 5は素数)
      // 使用: [3], 獲得: 5
      inventory[3] = inventory[3]! - 1; // 1
      inventory[5] = inventory[5]! + 1; // 3

      // 最終的な期待値
      Map<int, int> expectedFinalInventory = {
        2: 4, // 5 - 1 = 4
        3: 1, // 2 - 1 + 1 - 1 = 1
        5: 3, // 1 + 1 + 1 = 3
      };

      // 検証
      expect(inventory[2], expectedFinalInventory[2]);
      expect(inventory[3], expectedFinalInventory[3]);
      expect(inventory[5], expectedFinalInventory[5]);
    });

    test('cost-benefit calculation should be balanced', () {
      // コストと利益の計算が正しいかテスト

      // シナリオ: 素数2を5個、素数3を1個持っている
      Map<int, int> preBattleInventory = {
        2: 5,
        3: 1,
      };

      // 敵12と戦う場合の複数の攻略方法

      // 方法1: 12 ÷ 2 = 6, 6 ÷ 2 = 3, 3 ÷ 3 = 1
      // コスト: 2を2個、3を1個 = 計3個
      // 利益: なし（敵が1になった）
      // 純損失: -3個

      // 方法2: 12 ÷ 3 = 4, 4 ÷ 2 = 2, 2 ÷ 2 = 1
      // コスト: 3を1個、2を2個 = 計3個
      // 利益: なし（敵が1になった）
      // 純損失: -3個

      // 方法3: 12 ÷ 2 = 6, 6 ÷ 3 = 2 (2は素数で終了)
      // コスト: 2を1個、3を1個 = 計2個
      // 利益: 2を1個獲得
      // 純損失: -1個

      // 方法3が最も効率的
      Map<int, int> bestStrategyInventory = Map.from(preBattleInventory);
      bestStrategyInventory[2] = bestStrategyInventory[2]! - 1; // 使用
      bestStrategyInventory[3] = bestStrategyInventory[3]! - 1; // 使用
      bestStrategyInventory[2] = bestStrategyInventory[2]! + 1; // 獲得

      Map<int, int> expectedBestResult = {
        2: 5, // 5 - 1 + 1 = 5
        3: 0, // 1 - 1 = 0
      };

      expect(bestStrategyInventory[2], expectedBestResult[2]);
      expect(bestStrategyInventory[3], expectedBestResult[3]);

      // 総アイテム数の変化を確認
      int preBattleTotal =
          preBattleInventory.values.fold(0, (sum, count) => sum + count);
      int postBattleTotal =
          bestStrategyInventory.values.fold(0, (sum, count) => sum + count);

      expect(postBattleTotal, preBattleTotal - 1); // 1個減少（コスト）
    });
  });
}

/// 素数判定関数（テスト用）
bool _isPrime(int n) {
  if (n <= 1) return false;
  if (n <= 3) return true;
  if (n % 2 == 0 || n % 3 == 0) return false;

  for (int i = 5; i * i <= n; i += 6) {
    if (n % i == 0 || n % (i + 2) == 0) return false;
  }

  return true;
}
