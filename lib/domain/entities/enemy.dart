import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/math_utils.dart';
import '../../core/exceptions/game_exception.dart';

part 'enemy.freezed.dart';

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

  /// Check if the enemy is prime
  bool get isPrime => MathUtils.isPrime(currentValue);

  /// Check if the enemy is defeated
  bool get isDefeated => isPrime;

  /// Check if the enemy is composite
  bool get isComposite => !isPrime && currentValue > 1;

  /// Get the enemy size based on original value
  EnemySize get size {
    if (originalValue <= 20) return EnemySize.small;
    if (originalValue <= 100) return EnemySize.medium;
    return EnemySize.large;
  }

  /// Get difficulty rating for this enemy
  int get difficulty => MathUtils.getDifficulty(originalValue);

  /// Get available attacks for this enemy
  List<int> get availableAttacks {
    if (isPrime) return [];
    return MathUtils.getFactors(currentValue)
        .where((f) => f > 1 && f < currentValue)
        .toList();
  }

  /// Get power reward prime (for power enemies)
  int get powerRewardPrime =>
      isPowerEnemy ? (powerBase ?? currentValue) : currentValue;

  /// Get power reward count (for power enemies)
  int get powerRewardCount => isPowerEnemy ? (powerExponent ?? 1) : 1;

  /// Get display information for UI
  String get displayInfo {
    if (isPowerEnemy && powerBase != null && powerExponent != null) {
      return '$powerBase^$powerExponent = $currentValue';
    }
    return currentValue.toString();
  }

  /// Check if the enemy can be attacked by a value
  bool canBeAttackedBy(int value) {
    return !isPrime && currentValue % value == 0;
  }

  /// Attack the enemy with a value
  Enemy attack(int value) {
    if (!canBeAttackedBy(value)) {
      throw InvalidAttackException('Cannot attack enemy with value $value');
    }

    final newValue = currentValue ~/ value;
    return copyWith(currentValue: newValue);
  }

  /// Create a power enemy
  factory Enemy.power({
    required int base,
    required int exponent,
    required EnemyType type,
  }) {
    final value = _power(base, exponent);
    return Enemy(
      currentValue: value,
      originalValue: value,
      type: type,
      primeFactors: _calculatePrimeFactors(value),
      isPowerEnemy: true,
      powerBase: base,
      powerExponent: exponent,
    );
  }

  /// Create a normal enemy
  factory Enemy.normal({
    required int value,
    required EnemyType type,
  }) {
    return Enemy(
      currentValue: value,
      originalValue: value,
      type: type,
      primeFactors: _calculatePrimeFactors(value),
      isPowerEnemy: false,
    );
  }

  /// Calculate power (base^exponent)
  static int _power(int base, int exponent) {
    int result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  /// Calculate prime factors of a number
  static List<int> _calculatePrimeFactors(int n) {
    final factors = <int>[];
    int temp = n;

    // Check for factor 2
    while (temp % 2 == 0) {
      factors.add(2);
      temp ~/= 2;
    }

    // Check for odd factors
    for (int i = 3; i * i <= temp; i += 2) {
      while (temp % i == 0) {
        factors.add(i);
        temp ~/= i;
      }
    }

    // If temp is a prime greater than 2
    if (temp > 2) {
      factors.add(temp);
    }

    return factors;
  }
}
