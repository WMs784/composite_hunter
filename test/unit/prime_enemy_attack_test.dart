import 'package:flutter_test/flutter_test.dart';
import 'package:composite_hunter/domain/entities/enemy.dart';
import 'package:composite_hunter/domain/entities/prime.dart';
import 'package:composite_hunter/domain/services/battle_engine.dart';

void main() {
  group('Prime Enemy Attack Tests', () {
    test('should prevent attack when enemy becomes prime', () {
      // Create a composite enemy (6 = 2 * 3)
      const enemy = Enemy(
        currentValue: 6,
        originalValue: 6,
        type: EnemyType.small,
        primeFactors: [2, 3],
      );

      // Attack with prime 2, reducing enemy to 3 (prime)
      final attackedEnemy = enemy.attack(2);
      expect(attackedEnemy.currentValue, equals(3));
      expect(attackedEnemy.isDefeated, isTrue);

      // Now try to attack the prime enemy (3) with prime 3
      // This should NOT be allowed
      expect(attackedEnemy.canBeAttackedBy(3), isFalse);
    });

    test('should return error when attempting to attack prime enemy', () {
      // Create a prime enemy
      const primeEnemy = Enemy(
        currentValue: 7,
        originalValue: 14,
        type: EnemyType.small,
        primeFactors: [2, 7],
      );

      // Try to attack with prime 7
      final prime = Prime(value: 7, count: 1, firstObtained: DateTime.now());
      final result = BattleEngine.executeAttack(primeEnemy, prime);

      // Should return error since prime enemy cannot be attacked
      expect(result, isA<BattleError>());
    });

    test('should allow attack on composite enemy even with same prime factor',
        () {
      // Create a composite enemy (12 = 2^2 * 3)
      const enemy = Enemy(
        currentValue: 12,
        originalValue: 12,
        type: EnemyType.small,
        primeFactors: [2, 2, 3],
      );

      // Attack with prime 3 should be allowed (12 is composite)
      expect(enemy.canBeAttackedBy(3), isTrue);
      expect(enemy.isDefeated, isFalse);

      // Perform attack
      final attackedEnemy = enemy.attack(3);
      expect(attackedEnemy.currentValue, equals(4));
      expect(attackedEnemy.isDefeated, isFalse);
    });

    test('should prevent attack when enemy value is 1', () {
      // Create enemy with value 1 (neither prime nor composite)
      const enemy = Enemy(
        currentValue: 1,
        originalValue: 6,
        type: EnemyType.small,
        primeFactors: [2, 3],
      );

      // Cannot attack enemy with value 1
      expect(enemy.canBeAttackedBy(2), isFalse);
      expect(enemy.canBeAttackedBy(3), isFalse);
    });

    test('battle engine should handle prime enemy attack correctly', () {
      // Start with composite enemy
      const enemy = Enemy(
        currentValue: 10,
        originalValue: 10,
        type: EnemyType.small,
        primeFactors: [2, 5],
      );

      // Attack with 2, reducing to 5 (prime)
      final prime2 = Prime(value: 2, count: 1, firstObtained: DateTime.now());
      final result1 = BattleEngine.executeAttack(enemy, prime2);

      // Should be awaiting victory claim
      expect(result1, isA<BattleAwaitingVictoryClaim>());

      final newEnemy = (result1 as BattleAwaitingVictoryClaim).newEnemy;
      expect(newEnemy.currentValue, equals(5));
      expect(newEnemy.isDefeated, isTrue);

      // Now try to attack the prime enemy (5) with prime 5
      final prime5 = Prime(value: 5, count: 1, firstObtained: DateTime.now());
      final result2 = BattleEngine.executeAttack(newEnemy, prime5);

      // Should return error
      expect(result2, isA<BattleError>());
    });
  });
}
