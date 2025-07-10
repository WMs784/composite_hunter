import 'dart:math' as math;
import '../entities/enemy.dart';
import '../entities/prime.dart';
import 'prime_calculator.dart';
import 'power_enemy_detector.dart';
import '../../core/constants/game_constants.dart';
import '../../core/utils/logger.dart';

/// Service for generating enemies based on player level and inventory
class EnemyGenerator {
  final math.Random _random = math.Random();

  /// Generate an enemy appropriate for the player's level and inventory
  Enemy generateEnemy(List<Prime> playerInventory, int playerLevel) {
    Logger.debug('Generating enemy for player level $playerLevel with ${playerInventory.length} primes');

    // 10% chance to generate a power enemy
    if (_random.nextDouble() < GameConstants.powerEnemySpawnRate) {
      final powerEnemy = _generatePowerEnemy(playerInventory, playerLevel);
      if (powerEnemy != null) {
        Logger.debug('Generated power enemy with value ${powerEnemy.currentValue}');
        return powerEnemy;
      }
    }

    // Generate normal enemy
    final normalEnemy = _generateNormalEnemy(playerInventory, playerLevel);
    Logger.debug('Generated normal enemy with value ${normalEnemy.currentValue} of type ${normalEnemy.type.name}');
    return normalEnemy;
  }

  /// Generate a power enemy (prime^exponent)
  Enemy? _generatePowerEnemy(List<Prime> playerInventory, int playerLevel) {
    final availablePrimes = _getAvailablePrimes(playerInventory);
    
    if (availablePrimes.isEmpty) {
      return null; // Can't generate power enemy without available primes
    }

    // Select a prime base from player's inventory
    final basePrime = availablePrimes[_random.nextInt(availablePrimes.length)];
    
    // Determine exponent based on player level
    final maxExponent = math.min(
      GameConstants.maxPowerExponent, 
      GameConstants.minPowerExponent + (playerLevel ~/ 5)
    );
    final exponent = GameConstants.minPowerExponent + 
                    _random.nextInt(maxExponent - GameConstants.minPowerExponent + 1);
    
    return PowerEnemyDetector.createPowerEnemy(basePrime, exponent);
  }

  /// Generate a normal composite enemy
  Enemy _generateNormalEnemy(List<Prime> playerInventory, int playerLevel) {
    final availablePrimes = _getAvailablePrimes(playerInventory);
    final targetDifficulty = _calculateTargetDifficulty(playerLevel);
    
    int enemyValue;
    EnemyType enemyType;
    
    if (targetDifficulty < 10) {
      enemyValue = _generateSmallEnemy(availablePrimes);
      enemyType = EnemyType.small;
    } else if (targetDifficulty < 50) {
      enemyValue = _generateMediumEnemy(availablePrimes);
      enemyType = EnemyType.medium;
    } else {
      enemyValue = _generateLargeEnemy(availablePrimes);
      enemyType = EnemyType.large;
    }
    
    return Enemy(
      currentValue: enemyValue,
      originalValue: enemyValue,
      type: enemyType,
      primeFactors: PrimeCalculator.factorize(enemyValue),
      isPowerEnemy: false,
    );
  }

  /// Generate a small enemy (6-20 range)
  int _generateSmallEnemy(List<int> availablePrimes) {
    if (availablePrimes.length < 2) {
      return _fallbackSmallEnemy();
    }
    
    // Generate 2-3 factor composite numbers
    final factorCount = 2 + _random.nextInt(2); // 2 or 3 factors
    int result = 1;
    
    for (int i = 0; i < factorCount; i++) {
      final prime = availablePrimes[_random.nextInt(availablePrimes.length)];
      final newResult = result * prime;
      
      if (newResult > GameConstants.smallEnemyMax) {
        break;
      }
      result = newResult;
    }
    
    // Ensure result is in valid range
    if (result < GameConstants.smallEnemyMin || result > GameConstants.smallEnemyMax) {
      return _fallbackSmallEnemy();
    }
    
    return result;
  }

  /// Generate a medium enemy (21-100 range)
  int _generateMediumEnemy(List<int> availablePrimes) {
    if (availablePrimes.length < 2) {
      return _fallbackMediumEnemy();
    }
    
    // Generate 3-4 factor composite numbers
    final factorCount = 3 + _random.nextInt(2); // 3 or 4 factors
    int result = 1;
    
    for (int i = 0; i < factorCount; i++) {
      final prime = availablePrimes[_random.nextInt(availablePrimes.length)];
      final newResult = result * prime;
      
      if (newResult > GameConstants.mediumEnemyMax) {
        break;
      }
      result = newResult;
    }
    
    // Ensure result is in valid range
    if (result < GameConstants.mediumEnemyMin || result > GameConstants.mediumEnemyMax) {
      return _fallbackMediumEnemy();
    }
    
    return result;
  }

  /// Generate a large enemy (101-1000 range)
  int _generateLargeEnemy(List<int> availablePrimes) {
    if (availablePrimes.length < 3) {
      return _fallbackLargeEnemy();
    }
    
    // Generate 4-6 factor composite numbers
    final factorCount = 4 + _random.nextInt(3); // 4, 5, or 6 factors
    int result = 1;
    
    for (int i = 0; i < factorCount; i++) {
      final prime = availablePrimes[_random.nextInt(availablePrimes.length)];
      final newResult = result * prime;
      
      if (newResult > GameConstants.largeEnemyMax) {
        break;
      }
      result = newResult;
    }
    
    // Ensure result is in valid range
    if (result < GameConstants.largeEnemyMin || result > GameConstants.largeEnemyMax) {
      return _fallbackLargeEnemy();
    }
    
    return result;
  }

  /// Calculate target difficulty based on player level
  int _calculateTargetDifficulty(int playerLevel) {
    // Base difficulty increases with level, plus some randomness
    return playerLevel * 2 + _random.nextInt(10);
  }

  /// Get list of prime values that are available in inventory
  List<int> _getAvailablePrimes(List<Prime> inventory) {
    return inventory
        .where((prime) => prime.count > 0)
        .map((prime) => prime.value)
        .toList();
  }

  /// Fallback methods for when available primes are insufficient
  int _fallbackSmallEnemy() {
    // Generate from common small composites
    final smallComposites = [6, 8, 9, 10, 12, 14, 15, 16, 18, 20];
    return smallComposites[_random.nextInt(smallComposites.length)];
  }

  int _fallbackMediumEnemy() {
    // Generate from common medium composites
    final mediumComposites = [21, 24, 25, 27, 28, 30, 32, 35, 36, 40, 42, 45, 48, 49, 50];
    return mediumComposites[_random.nextInt(mediumComposites.length)];
  }

  int _fallbackLargeEnemy() {
    // Generate from large composite range
    int value;
    do {
      value = GameConstants.largeEnemyMin + 
              _random.nextInt(GameConstants.largeEnemyMax - GameConstants.largeEnemyMin + 1);
    } while (PrimeCalculator.isPrime(value));
    
    return value;
  }

  /// Generate an enemy with specific difficulty constraints
  Enemy generateEnemyWithDifficulty(
    List<Prime> playerInventory, 
    int playerLevel, 
    EnemyType targetType
  ) {
    switch (targetType) {
      case EnemyType.small:
        final value = _generateSmallEnemy(_getAvailablePrimes(playerInventory));
        return Enemy(
          currentValue: value,
          originalValue: value,
          type: EnemyType.small,
          primeFactors: PrimeCalculator.factorize(value),
        );
        
      case EnemyType.medium:
        final value = _generateMediumEnemy(_getAvailablePrimes(playerInventory));
        return Enemy(
          currentValue: value,
          originalValue: value,
          type: EnemyType.medium,
          primeFactors: PrimeCalculator.factorize(value),
        );
        
      case EnemyType.large:
        final value = _generateLargeEnemy(_getAvailablePrimes(playerInventory));
        return Enemy(
          currentValue: value,
          originalValue: value,
          type: EnemyType.large,
          primeFactors: PrimeCalculator.factorize(value),
        );
        
      case EnemyType.power:
        return _generatePowerEnemy(playerInventory, playerLevel) ??
               generateEnemyWithDifficulty(playerInventory, playerLevel, EnemyType.small);
        
      case EnemyType.special:
        // Generate a special enemy with unique characteristics
        return _generateSpecialEnemy(playerInventory, playerLevel);
    }
  }

  /// Generate a special enemy with unique properties
  Enemy _generateSpecialEnemy(List<Prime> playerInventory, int playerLevel) {
    final availablePrimes = _getAvailablePrimes(playerInventory);
    
    // Special enemies have many prime factors or are very large
    int value = 1;
    final factorCount = 5 + _random.nextInt(3); // 5-7 factors
    
    for (int i = 0; i < factorCount && value < 2000; i++) {
      if (availablePrimes.isNotEmpty) {
        final prime = availablePrimes[_random.nextInt(availablePrimes.length)];
        value *= prime;
      }
    }
    
    // Ensure it's a reasonable size
    if (value > 2000 || value < 100) {
      value = 210; // 2 × 3 × 5 × 7
    }
    
    return Enemy(
      currentValue: value,
      originalValue: value,
      type: EnemyType.special,
      primeFactors: PrimeCalculator.factorize(value),
    );
  }

  /// Get difficulty rating for a generated enemy
  int getEnemyDifficulty(Enemy enemy, List<Prime> playerInventory) {
    int difficulty = 0;
    
    // Base difficulty from enemy size
    switch (enemy.type) {
      case EnemyType.small:
        difficulty += 1;
        break;
      case EnemyType.medium:
        difficulty += 3;
        break;
      case EnemyType.large:
        difficulty += 5;
        break;
      case EnemyType.power:
        difficulty += 2; // Power enemies are easier due to uniform factors
        break;
      case EnemyType.special:
        difficulty += 7;
        break;
    }
    
    // Adjust based on available attacks
    final availableAttacks = playerInventory
        .where((prime) => prime.isAvailable && enemy.canBeAttackedBy(prime.value))
        .length;
    
    if (availableAttacks == 0) {
      difficulty += 10; // Impossible
    } else if (availableAttacks == 1) {
      difficulty += 3; // Very limited
    } else if (availableAttacks >= 4) {
      difficulty -= 1; // Many options
    }
    
    // Factor in number of distinct prime factors
    final distinctFactors = enemy.primeFactors.toSet().length;
    difficulty += distinctFactors;
    
    return difficulty.clamp(1, 15);
  }
}