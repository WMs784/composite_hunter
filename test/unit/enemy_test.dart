import 'package:flutter_test/flutter_test.dart';
import 'package:composite_hunter/domain/entities/enemy.dart';
import 'package:composite_hunter/core/exceptions/game_exception.dart';

void main() {
  group('Enemy Tests', () {
    group('canBeAttackedBy', () {
      test('should return true for valid prime factors', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        expect(enemy.canBeAttackedBy(2), true);
        expect(enemy.canBeAttackedBy(3), true);
        expect(enemy.canBeAttackedBy(4), true); // 12 is divisible by 4
        expect(enemy.canBeAttackedBy(6), true); // 12 is divisible by 6
      });

      test('should return false for invalid attacks', () {
        const enemy = Enemy(
          currentValue: 15,
          originalValue: 15,
          type: EnemyType.small,
          primeFactors: [3, 5],
        );

        expect(enemy.canBeAttackedBy(2), false);
        expect(enemy.canBeAttackedBy(4), false);
        expect(enemy.canBeAttackedBy(7), false);
      });
    });

    group('attack', () {
      test('should reduce enemy value correctly', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        final attackedEnemy = enemy.attack(2);

        expect(attackedEnemy.currentValue, 6);
        expect(attackedEnemy.originalValue, 12); // Should remain unchanged
        expect(attackedEnemy.type, EnemyType.small);
      });

      test('should throw exception for invalid attacks', () {
        const enemy = Enemy(
          currentValue: 15,
          originalValue: 15,
          type: EnemyType.small,
          primeFactors: [3, 5],
        );

        expect(() => enemy.attack(2), throwsA(isA<InvalidAttackException>()));
        expect(() => enemy.attack(4), throwsA(isA<InvalidAttackException>()));
      });

      test('should preserve enemy properties after attack', () {
        const enemy = Enemy(
          currentValue: 20,
          originalValue: 20,
          type: EnemyType.small,
          primeFactors: [2, 2, 5],
          isPowerEnemy: false,
        );

        final attackedEnemy = enemy.attack(4);

        expect(attackedEnemy.currentValue, 5);
        expect(attackedEnemy.originalValue, 20);
        expect(attackedEnemy.type, EnemyType.small);
        expect(attackedEnemy.isPowerEnemy, false);
        expect(attackedEnemy.primeFactors, [2, 2, 5]);
      });
    });

    group('isDefeated', () {
      test('should return true when enemy value is prime', () {
        const enemy = Enemy(
          currentValue: 7,
          originalValue: 14,
          type: EnemyType.small,
          primeFactors: [2, 7],
        );

        expect(enemy.isDefeated, true);
      });

      test('should return false when enemy value is composite', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        expect(enemy.isDefeated, false);
      });

      test('should return false for value 1', () {
        const enemy = Enemy(
          currentValue: 1,
          originalValue: 2,
          type: EnemyType.small,
          primeFactors: [2],
        );

        expect(enemy.isDefeated, false);
      });
    });

    group('Power Enemy Properties', () {
      test('should calculate power rewards correctly', () {
        const powerEnemy = Enemy(
          currentValue: 8,
          originalValue: 8,
          type: EnemyType.power,
          primeFactors: [2, 2, 2],
          isPowerEnemy: true,
          powerBase: 2,
          powerExponent: 3,
        );

        expect(powerEnemy.powerRewardCount, 3);
        expect(powerEnemy.powerRewardPrime, 2);
      });

      test('should return default values for non-power enemies', () {
        const normalEnemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
          isPowerEnemy: false,
        );

        expect(normalEnemy.powerRewardCount, 1);
        expect(normalEnemy.powerRewardPrime, 12);
      });
    });

    group('availableAttacks', () {
      test('should return correct prime factors for composite numbers', () {
        const enemy = Enemy(
          currentValue: 30,
          originalValue: 30,
          type: EnemyType.medium,
          primeFactors: [2, 3, 5],
        );

        final attacks = enemy.availableAttacks;
        expect(attacks, containsAll([2, 3, 5]));
      });

      test('should return empty list for defeated enemies', () {
        const enemy = Enemy(
          currentValue: 7,
          originalValue: 14,
          type: EnemyType.small,
          primeFactors: [2, 7],
        );

        expect(enemy.availableAttacks, isEmpty);
      });

      test('should return unique prime factors only', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        final attacks = enemy.availableAttacks;
        expect(attacks, containsAll([2, 3]));
        expect(
          attacks.where((p) => p == 2).length,
          1,
        ); // Should appear only once
      });
    });

    group('size', () {
      test('should categorize enemy sizes correctly', () {
        const smallEnemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        const mediumEnemy = Enemy(
          currentValue: 50,
          originalValue: 50,
          type: EnemyType.medium,
          primeFactors: [2, 5, 5],
        );

        const largeEnemy = Enemy(
          currentValue: 200,
          originalValue: 200,
          type: EnemyType.large,
          primeFactors: [2, 2, 2, 5, 5],
        );

        expect(smallEnemy.size, EnemySize.small);
        expect(mediumEnemy.size, EnemySize.medium);
        expect(largeEnemy.size, EnemySize.large);
      });
    });

    group('displayInfo', () {
      test('should show power notation for power enemies', () {
        const powerEnemy = Enemy(
          currentValue: 8,
          originalValue: 8,
          type: EnemyType.power,
          primeFactors: [2, 2, 2],
          isPowerEnemy: true,
          powerBase: 2,
          powerExponent: 3,
        );

        expect(powerEnemy.displayInfo, '2^3 = 8');
      });

      test('should show value only for normal enemies', () {
        const normalEnemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        expect(normalEnemy.displayInfo, '12');
      });
    });

    group('isComposite', () {
      test('should return true for composite numbers', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        expect(enemy.isComposite, true);
      });

      test('should return false for prime numbers', () {
        const enemy = Enemy(
          currentValue: 7,
          originalValue: 14,
          type: EnemyType.small,
          primeFactors: [2, 7],
        );

        expect(enemy.isComposite, false);
      });

      test('should return false for 1', () {
        const enemy = Enemy(
          currentValue: 1,
          originalValue: 2,
          type: EnemyType.small,
          primeFactors: [2],
        );

        expect(enemy.isComposite, false);
      });
    });
  });
}
