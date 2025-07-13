import 'package:flutter_test/flutter_test.dart';
import 'package:composite_hunter/domain/entities/enemy.dart';
import 'package:composite_hunter/domain/entities/prime.dart';
import 'package:composite_hunter/domain/services/battle_engine.dart';

void main() {
  group('BattleEngine Tests', () {
    group('executeAttack', () {
      test('should allow valid attacks', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );
        
        final prime = Prime(
          value: 2,
          count: 1,
          firstObtained: DateTime.now(),
        );

        final result = BattleEngine.executeAttack(enemy, prime);

        result.when(
          victory: (_, __, ___) => fail('Should not be victory yet'),
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (newEnemy, usedPrime) {
            expect(newEnemy.currentValue, 6);
            expect(usedPrime.value, 2);
          },
          awaitingVictoryClaim: (newEnemy, usedPrime) {
            expect(newEnemy.currentValue, 6);
            expect(usedPrime.value, 2);
          },
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (_) => fail('Should not be escape'),
          timeOut: (_) => fail('Should not be timeout'),
          error: (_) => fail('Should not be error'),
        );
      });

      test('should reach victory state when enemy becomes prime', () {
        const enemy = Enemy(
          currentValue: 6,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 3],
        );
        
        final prime = Prime(
          value: 2,
          count: 1,
          firstObtained: DateTime.now(),
        );

        final result = BattleEngine.executeAttack(enemy, prime);

        result.when(
          victory: (_, __, ___) => fail('Should await victory claim first'),
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (newEnemy, usedPrime) {
            expect(newEnemy.currentValue, 3);
            expect(newEnemy.isDefeated, true);
            expect(usedPrime.value, 2);
          },
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (_) => fail('Should not be escape'),
          timeOut: (_) => fail('Should not be timeout'),
          error: (_) => fail('Should not be error'),
        );
      });

      test('should return error for invalid attacks', () {
        const enemy = Enemy(
          currentValue: 15,
          originalValue: 15,
          type: EnemyType.small,
          primeFactors: [3, 5],
        );
        
        final prime = Prime(
          value: 2,
          count: 1,
          firstObtained: DateTime.now(),
        );

        final result = BattleEngine.executeAttack(enemy, prime);

        result.when(
          victory: (_, __, ___) => fail('Should not be victory'),
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (_, __) => fail('Should not await victory claim'),
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (_) => fail('Should not be escape'),
          timeOut: (_) => fail('Should not be timeout'),
          error: (message) {
            expect(message, contains('Cannot attack'));
          },
        );
      });
    });

    group('processVictoryClaim', () {
      test('should validate correct victory claims', () {
        const enemy = Enemy(
          currentValue: 7,
          originalValue: 14,
          type: EnemyType.small,
          primeFactors: [2, 7],
        );

        final result = BattleEngine.processVictoryClaim(enemy, 7);

        result.when(
          victory: (defeatedEnemy, rewardPrime, victoryClaim) {
            expect(defeatedEnemy.currentValue, 7);
            expect(rewardPrime, 7);
            expect(victoryClaim.isCorrect, true);
          },
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (_, __) => fail('Should not await victory claim'),
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (_) => fail('Should not be escape'),
          timeOut: (_) => fail('Should not be timeout'),
          error: (_) => fail('Should not be error'),
        );
      });

      test('should handle power enemy victories', () {
        const enemy = Enemy(
          currentValue: 3,
          originalValue: 27,
          type: EnemyType.power,
          primeFactors: [3, 3, 3],
          isPowerEnemy: true,
          powerBase: 3,
          powerExponent: 3,
        );

        final result = BattleEngine.processVictoryClaim(enemy, 3);

        result.when(
          victory: (_, __, ___) => fail('Should be power victory'),
          powerVictory: (defeatedEnemy, rewardPrime, rewardCount, victoryClaim) {
            expect(defeatedEnemy.currentValue, 3);
            expect(rewardPrime, 3);
            expect(rewardCount, 3);
            expect(victoryClaim.isCorrect, true);
          },
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (_, __) => fail('Should not await victory claim'),
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (_) => fail('Should not be escape'),
          timeOut: (_) => fail('Should not be timeout'),
          error: (_) => fail('Should not be error'),
        );
      });

      test('should penalize wrong victory claims', () {
        const enemy = Enemy(
          currentValue: 15,
          originalValue: 30,
          type: EnemyType.small,
          primeFactors: [2, 3, 5],
        );

        final result = BattleEngine.processVictoryClaim(enemy, 15);

        result.when(
          victory: (_, __, ___) => fail('Should not be victory'),
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (_, __) => fail('Should not await victory claim'),
          wrongClaim: (penalty, currentEnemy, victoryClaim) {
            expect(penalty.seconds, 10);
            expect(currentEnemy.currentValue, 15);
            expect(victoryClaim.isCorrect, false);
          },
          escape: (_) => fail('Should not be escape'),
          timeOut: (_) => fail('Should not be timeout'),
          error: (_) => fail('Should not be error'),
        );
      });
    });

    group('processEscape', () {
      test('should apply escape penalty', () {
        final result = BattleEngine.processEscape();

        result.when(
          victory: (_, __, ___) => fail('Should not be victory'),
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (_, __) => fail('Should not await victory claim'),
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (penalty) {
            expect(penalty.seconds, 10);
            expect(penalty.type.name, 'escape');
          },
          timeOut: (_) => fail('Should not be timeout'),
          error: (_) => fail('Should not be error'),
        );
      });
    });

    group('processTimeOut', () {
      test('should apply timeout penalty', () {
        final result = BattleEngine.processTimeOut();

        result.when(
          victory: (_, __, ___) => fail('Should not be victory'),
          powerVictory: (_, __, ___, ____) => fail('Should not be power victory'),
          continue_: (_, __) => fail('Should not continue'),
          awaitingVictoryClaim: (_, __) => fail('Should not await victory claim'),
          wrongClaim: (_, __, ___) => fail('Should not be wrong claim'),
          escape: (_) => fail('Should not be escape'),
          timeOut: (penalty) {
            expect(penalty.seconds, 10);
            expect(penalty.type.name, 'timeOut');
          },
          error: (_) => fail('Should not be error'),
        );
      });
    });

    group('canAttack', () {
      test('should validate attack availability', () {
        const enemy = Enemy(
          currentValue: 12,
          originalValue: 12,
          type: EnemyType.small,
          primeFactors: [2, 2, 3],
        );

        final availablePrime = Prime(
          value: 2,
          count: 1,
          firstObtained: DateTime.now(),
        );

        final unavailablePrime = Prime(
          value: 3,
          count: 0,
          firstObtained: DateTime.now(),
        );

        final invalidPrime = Prime(
          value: 5,
          count: 1,
          firstObtained: DateTime.now(),
        );

        final inventory = [availablePrime, unavailablePrime, invalidPrime];

        expect(BattleEngine.canAttack(enemy, availablePrime, inventory), true);
        expect(BattleEngine.canAttack(enemy, unavailablePrime, inventory), false);
        expect(BattleEngine.canAttack(enemy, invalidPrime, inventory), false);
      });
    });

    group('calculateBattleDifficulty', () {
      test('should calculate difficulty based on enemy and available attacks', () {
        const enemy = Enemy(
          currentValue: 30,
          originalValue: 30,
          type: EnemyType.medium,
          primeFactors: [2, 3, 5],
        );

        final inventory = [
          Prime(value: 2, count: 1, firstObtained: DateTime.now()),
          Prime(value: 3, count: 1, firstObtained: DateTime.now()),
          Prime(value: 5, count: 1, firstObtained: DateTime.now()),
        ];

        final difficulty = BattleEngine.calculateBattleDifficulty(enemy, inventory);
        expect(difficulty, greaterThan(0));
        expect(difficulty, lessThanOrEqualTo(10));
      });

      test('should increase difficulty when no attacks available', () {
        const enemy = Enemy(
          currentValue: 35,
          originalValue: 35,
          type: EnemyType.medium,
          primeFactors: [5, 7],
        );

        final inventory = [
          Prime(value: 2, count: 1, firstObtained: DateTime.now()),
          Prime(value: 3, count: 1, firstObtained: DateTime.now()),
        ];

        final difficulty = BattleEngine.calculateBattleDifficulty(enemy, inventory);
        expect(difficulty, greaterThan(5)); // Should be high due to no valid attacks
      });
    });
  });
}