import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/math_utils.dart';
import '../../core/exceptions/game_exception.dart';
import '../../core/extensions/int_extensions.dart';

part 'enemy.freezed.dart';

@freezed
class Enemy with _$Enemy {
  const factory Enemy({
    required int currentValue,
    required int originalValue,
    required EnemyType type,
    required List<int> primeFactors,
    @Default(false) bool isPowerEnemy,
    int? powerBase,
    int? powerExponent,
  }) = _Enemy;

  const Enemy._();

  /// Check if the enemy can be attacked by the given prime
  bool canBeAttackedBy(int prime) {
    return currentValue % prime == 0;
  }

  /// Attack the enemy with the given prime
  Enemy attack(int prime) {
    if (!canBeAttackedBy(prime)) {
      throw InvalidAttackException(
        'Cannot attack $currentValue with $prime',
        'Prime $prime does not divide $currentValue',
      );
    }

    final newValue = currentValue ~/ prime;
    return copyWith(currentValue: newValue);
  }

  /// Check if the enemy is defeated (reduced to a prime number)
  bool get isDefeated => MathUtils.isPrime(currentValue);

  /// Get the reward count for power enemies
  int get powerRewardCount => isPowerEnemy && powerExponent != null ? powerExponent! : 1;

  /// Get the reward prime for power enemies
  int get powerRewardPrime => isPowerEnemy && powerBase != null ? powerBase! : currentValue;

  /// Check if this enemy is a composite number
  bool get isComposite => currentValue > 1 && !currentValue.isPrime;

  /// Get the difficulty level of this enemy
  int get difficulty => MathUtils.getDifficulty(originalValue);

  /// Get a list of available attacks (primes that can divide current value)
  List<int> get availableAttacks {
    if (isDefeated) return [];
    
    final factors = <int>[];
    int n = currentValue;
    
    // Find all prime factors of current value
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        factors.add(i);
        while (n % i == 0) {
          n ~/= i;
        }
      }
    }
    
    if (n > 1) factors.add(n);
    
    return factors;
  }

  /// Get display information for UI
  String get displayInfo {
    if (isPowerEnemy && powerBase != null && powerExponent != null) {
      return '$powerBase^$powerExponent = $currentValue';
    }
    return currentValue.toString();
  }

  /// Get the enemy size category
  EnemySize get size {
    if (originalValue <= 20) return EnemySize.small;
    if (originalValue <= 100) return EnemySize.medium;
    return EnemySize.large;
  }

  @override
  String toString() {
    return 'Enemy(value: $currentValue, original: $originalValue, type: $type${isPowerEnemy ? ', power: $powerBase^$powerExponent' : ''})';
  }
}

enum EnemyType {
  small,
  medium,
  large,
  power,
  special,
}

enum EnemySize {
  small,
  medium,
  large,
}