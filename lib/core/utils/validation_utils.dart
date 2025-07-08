import '../extensions/int_extensions.dart';

class ValidationUtils {
  /// Validate if a prime number is valid for the game
  static bool isValidPrime(int value) {
    return value > 1 && value.isPrime;
  }
  
  /// Validate if an enemy value is valid
  static bool isValidEnemyValue(int value) {
    return value > 1 && !value.isPrime; // Must be composite
  }
  
  /// Validate if a prime can attack an enemy
  static bool canAttack(int prime, int enemyValue) {
    return isValidPrime(prime) && enemyValue % prime == 0;
  }
  
  /// Validate victory claim
  static bool isValidVictoryClaim(int claimedValue) {
    return isValidPrime(claimedValue);
  }
  
  /// Validate timer duration
  static bool isValidTimerDuration(int seconds) {
    return seconds >= 0;
  }
  
  /// Validate player level
  static bool isValidPlayerLevel(int level) {
    return level >= 1 && level <= 100; // Reasonable range
  }
  
  /// Validate prime count
  static bool isValidPrimeCount(int count) {
    return count >= 0;
  }
  
  /// Validate enemy type transition
  static bool isValidEnemyTypeForValue(int value, EnemyType type) {
    switch (type) {
      case EnemyType.small:
        return value >= 6 && value <= 20;
      case EnemyType.medium:
        return value >= 21 && value <= 100;
      case EnemyType.large:
        return value >= 101 && value <= 1000;
      case EnemyType.power:
        return value.isPowerOfPrime;
      case EnemyType.special:
        return value > 1000;
    }
  }
}

enum EnemyType {
  small,
  medium,
  large,
  power,
  special,
}