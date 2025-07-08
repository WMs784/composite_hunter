import 'dart:math' as math;
import '../entities/enemy.dart';
import 'prime_calculator.dart';
import '../../core/utils/logger.dart';

/// Service for detecting and creating power enemies (prime^exponent)
class PowerEnemyDetector {
  /// Check if a value is a power enemy (single prime raised to a power)
  static bool isPowerEnemy(int value) {
    if (value < 4) return false; // Minimum power enemy is 2^2 = 4
    
    final factors = PrimeCalculator.factorize(value);
    
    // Must have at least 2 factors
    if (factors.length < 2) return false;
    
    // All factors must be the same prime
    final firstFactor = factors.first;
    return factors.every((factor) => factor == firstFactor);
  }

  /// Analyze a value and return power enemy information if applicable
  static PowerEnemyInfo? analyzePowerEnemy(int value) {
    if (!isPowerEnemy(value)) return null;
    
    final factors = PrimeCalculator.factorize(value);
    final base = factors.first;
    final exponent = factors.length;
    
    Logger.logEnemy('Analyzed power enemy', data: {
      'value': value,
      'base': base,
      'exponent': exponent,
    });
    
    return PowerEnemyInfo(
      base: base,
      exponent: exponent,
      value: value,
    );
  }

  /// Create a power enemy with specified base and exponent
  static Enemy createPowerEnemy(int base, int exponent) {
    if (!PrimeCalculator.isPrime(base)) {
      throw ArgumentError('Base must be prime: $base');
    }
    
    if (exponent < 2) {
      throw ArgumentError('Exponent must be at least 2: $exponent');
    }
    
    final value = math.pow(base, exponent).toInt();
    
    // Verify the result is reasonable
    if (value > 10000) {
      throw ArgumentError('Power enemy value too large: $value');
    }
    
    Logger.logEnemy('Created power enemy', data: {
      'base': base,
      'exponent': exponent,
      'value': value,
    });
    
    return Enemy(
      currentValue: value,
      originalValue: value,
      type: EnemyType.power,
      primeFactors: List.filled(exponent, base),
      isPowerEnemy: true,
      powerBase: base,
      powerExponent: exponent,
    );
  }

  /// Generate a random power enemy within constraints
  static Enemy generateRandomPowerEnemy({
    List<int>? availableBases,
    int minExponent = 2,
    int maxExponent = 4,
    int maxValue = 1000,
  }) {
    final random = math.Random();
    
    // Default available bases (small primes)
    availableBases ??= [2, 3, 5, 7];
    
    // Filter bases to ensure result doesn't exceed maxValue
    final validBases = availableBases.where((base) {
      return math.pow(base, minExponent) <= maxValue;
    }).toList();
    
    if (validBases.isEmpty) {
      throw ArgumentError('No valid bases for power enemy generation');
    }
    
    // Select random base
    final base = validBases[random.nextInt(validBases.length)];
    
    // Determine maximum valid exponent for this base
    int actualMaxExponent = maxExponent;
    while (actualMaxExponent >= minExponent && 
           math.pow(base, actualMaxExponent) > maxValue) {
      actualMaxExponent--;
    }
    
    if (actualMaxExponent < minExponent) {
      throw ArgumentError('Cannot generate power enemy with base $base within constraints');
    }
    
    // Select random exponent
    final exponent = minExponent + random.nextInt(actualMaxExponent - minExponent + 1);
    
    return createPowerEnemy(base, exponent);
  }

  /// Check if a power enemy can be created with given constraints
  static bool canCreatePowerEnemy(int base, int exponent, {int maxValue = 10000}) {
    if (!PrimeCalculator.isPrime(base)) return false;
    if (exponent < 2) return false;
    if (math.pow(base, exponent) > maxValue) return false;
    
    return true;
  }

  /// Get all possible power enemies within a value range
  static List<PowerEnemyInfo> getAllPowerEnemiesInRange(int minValue, int maxValue) {
    final powerEnemies = <PowerEnemyInfo>[];
    
    // Check small primes as bases
    final primes = PrimeCalculator.getPrimesInRange(2, 20);
    
    for (final base in primes) {
      int exponent = 2;
      while (true) {
        final value = math.pow(base, exponent).toInt();
        
        if (value > maxValue) break;
        
        if (value >= minValue) {
          powerEnemies.add(PowerEnemyInfo(
            base: base,
            exponent: exponent,
            value: value,
          ));
        }
        
        exponent++;
      }
    }
    
    // Sort by value
    powerEnemies.sort((a, b) => a.value.compareTo(b.value));
    
    return powerEnemies;
  }

  /// Calculate the difficulty of a power enemy
  static int calculatePowerEnemyDifficulty(PowerEnemyInfo info) {
    int difficulty = 0;
    
    // Base difficulty from exponent
    difficulty += info.exponent;
    
    // Larger bases are slightly harder
    if (info.base > 5) difficulty += 1;
    if (info.base > 10) difficulty += 1;
    
    // Larger values are harder
    if (info.value > 100) difficulty += 1;
    if (info.value > 1000) difficulty += 2;
    
    return difficulty.clamp(1, 10);
  }

  /// Get the reward multiplier for defeating a power enemy
  static double getPowerEnemyRewardMultiplier(PowerEnemyInfo info) {
    // Base multiplier from exponent
    double multiplier = 1.0 + (info.exponent - 2) * 0.5;
    
    // Bonus for larger bases
    if (info.base > 5) multiplier += 0.2;
    if (info.base > 10) multiplier += 0.3;
    
    return multiplier.clamp(1.0, 3.0);
  }

  /// Check if defeating this power enemy unlocks special rewards
  static bool hasSpecialReward(PowerEnemyInfo info) {
    // Special rewards for perfect cubes (exponent 3)
    if (info.exponent == 3) return true;
    
    // Special rewards for fourth powers (exponent 4)
    if (info.exponent == 4) return true;
    
    // Special rewards for large prime bases
    if (info.base > 10) return true;
    
    return false;
  }

  /// Get the visual effect type for a power enemy
  static PowerEnemyVisualEffect getVisualEffect(PowerEnemyInfo info) {
    switch (info.exponent) {
      case 2:
        return PowerEnemyVisualEffect.square;
      case 3:
        return PowerEnemyVisualEffect.cube;
      case 4:
        return PowerEnemyVisualEffect.fourth;
      default:
        return PowerEnemyVisualEffect.higher;
    }
  }
}

/// Information about a power enemy
class PowerEnemyInfo {
  final int base;
  final int exponent;
  final int value;

  const PowerEnemyInfo({
    required this.base,
    required this.exponent,
    required this.value,
  });

  /// Get the mathematical notation (e.g., "2³")
  String get notation {
    return '$base^$exponent';
  }

  /// Get the full expression (e.g., "2³ = 8")
  String get fullExpression {
    return '$notation = $value';
  }

  /// Check if this is a perfect square
  bool get isSquare => exponent == 2;

  /// Check if this is a perfect cube
  bool get isCube => exponent == 3;

  /// Check if this is a fourth power
  bool get isFourthPower => exponent == 4;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PowerEnemyInfo &&
           other.base == base &&
           other.exponent == exponent &&
           other.value == value;
  }

  @override
  int get hashCode => Object.hash(base, exponent, value);

  @override
  String toString() => 'PowerEnemyInfo($fullExpression)';
}

/// Visual effect types for power enemies
enum PowerEnemyVisualEffect {
  square,   // For x²
  cube,     // For x³
  fourth,   // For x⁴
  higher,   // For x⁵ and above
}