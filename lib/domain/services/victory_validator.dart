import '../entities/enemy.dart';
import '../entities/timer_state.dart';
import '../entities/penalty_state.dart';
import 'prime_calculator.dart';
import 'timer_manager.dart';
import '../../core/constants/timer_constants.dart';
import '../../core/utils/logger.dart';

/// Service for validating victory claims and managing victory conditions
class VictoryValidator {
  /// Validate a victory claim against the actual enemy value
  static VictoryValidationResult validateVictoryClaim(int claimedValue) {
    Logger.debug('Validating victory claim for value: $claimedValue');

    final isPrime = PrimeCalculator.isPrime(claimedValue);
    
    if (isPrime) {
      Logger.debug('Victory claim valid');
      return VictoryValidationResult(
        isValid: true,
        claimedValue: claimedValue,
        rewardPrime: claimedValue,
        penalty: null,
        message: 'Correct! You found the prime $claimedValue!',
      );
    } else {
      Logger.debug('Victory claim invalid - not prime');
      final penalty = TimePenalty(
        seconds: TimerConstants.wrongVictoryClaimPenalty,
        type: PenaltyType.wrongVictoryClaim,
        appliedAt: DateTime.now(),
        reason: 'Claimed non-prime value $claimedValue',
      );

      return VictoryValidationResult(
        isValid: false,
        claimedValue: claimedValue,
        rewardPrime: null,
        penalty: penalty,
        message: 'The value $claimedValue is still composite. Continue attacking!',
      );
    }
  }

  /// Check if victory can be claimed based on current game state
  static bool canClaimVictory(Enemy enemy, TimerState timerState) {
    // Must have an active enemy
    if (enemy == null) return false;
    
    // Enemy must be defeated (reduced to prime)
    if (!enemy.isDefeated) return false;
    
    // Timer must be active and not expired
    if (!timerState.isActive || timerState.isExpired) return false;
    
    Logger.debug('Victory can be claimed for enemy ${enemy.currentValue} with ${timerState.remainingSeconds}s remaining');
    
    return true;
  }

  /// Validate that the claimed value matches the actual enemy value
  static VictoryValidationResult validateExactClaim(int claimedValue, int actualValue) {
    if (claimedValue != actualValue) {
      Logger.debug('Victory claim mismatch: claimed $claimedValue but actual is $actualValue');

      final penalty = TimePenalty(
        seconds: TimerConstants.wrongVictoryClaimPenalty,
        type: PenaltyType.wrongVictoryClaim,
        appliedAt: DateTime.now(),
        reason: 'Claimed value $claimedValue does not match enemy value $actualValue',
      );

      return VictoryValidationResult(
        isValid: false,
        claimedValue: claimedValue,
        rewardPrime: null,
        penalty: penalty,
        message: 'The value $claimedValue does not match the enemy\'s current value $actualValue.',
      );
    }

    // If values match, validate that it's prime
    return validateVictoryClaim(claimedValue);
  }

  /// Calculate victory score based on performance
  static VictoryScore calculateVictoryScore({
    required Enemy originalEnemy,
    required int turnsUsed,
    required int timeUsed,
    required List<TimePenalty> penalties,
    required bool isPowerEnemy,
  }) {
    int baseScore = 100;
    
    // Bonus for enemy difficulty
    switch (originalEnemy.type) {
      case EnemyType.small:
        baseScore += 10;
        break;
      case EnemyType.medium:
        baseScore += 25;
        break;
      case EnemyType.large:
        baseScore += 50;
        break;
      case EnemyType.power:
        baseScore += 75;
        break;
      case EnemyType.special:
        baseScore += 100;
        break;
    }
    
    // Efficiency bonus (fewer turns = higher score)
    final optimalTurns = _calculateOptimalTurns(originalEnemy);
    if (turnsUsed <= optimalTurns) {
      baseScore += (optimalTurns - turnsUsed + 1) * 10;
    } else {
      baseScore -= (turnsUsed - optimalTurns) * 5;
    }
    
    // Speed bonus (faster completion = higher score)
    final baseTime = TimerManager.getBaseTimeForEnemy(originalEnemy);
    final timeBonus = ((baseTime - timeUsed) / baseTime * 50).round();
    baseScore = (baseScore + timeBonus).clamp(0, baseScore + 50);
    
    // Penalty deductions
    for (final penalty in penalties) {
      baseScore -= penalty.seconds;
    }
    
    // Power enemy bonus
    if (isPowerEnemy) {
      baseScore = (baseScore * 1.5).round();
    }
    
    final finalScore = baseScore.clamp(0, 1000);
    
    return VictoryScore(
      totalScore: finalScore,
      baseScore: 100,
      difficultyBonus: baseScore - 100,
      efficiencyBonus: timeBonus,
      penaltyDeduction: penalties.fold(0, (sum, p) => sum + p.seconds),
      rank: _calculateRank(finalScore),
    );
  }

  /// Calculate optimal number of turns for an enemy
  static int _calculateOptimalTurns(Enemy enemy) {
    final factors = enemy.primeFactors.toSet();
    
    // Optimal turns is roughly the number of distinct prime factors
    // Plus some buffer for larger numbers
    int optimal = factors.length;
    
    if (enemy.originalValue > 100) optimal += 1;
    if (enemy.originalValue > 1000) optimal += 2;
    
    return optimal.clamp(1, 10);
  }

  /// Calculate victory rank based on score
  static VictoryRank _calculateRank(int score) {
    if (score >= 800) return VictoryRank.perfect;
    if (score >= 600) return VictoryRank.excellent;
    if (score >= 400) return VictoryRank.good;
    if (score >= 200) return VictoryRank.average;
    return VictoryRank.poor;
  }

  /// Check for special victory conditions
  static List<SpecialVictoryCondition> checkSpecialConditions({
    required Enemy originalEnemy,
    required List<int> primesUsed,
    required int turnsUsed,
    required int timeUsed,
    required bool firstTry,
  }) {
    final conditions = <SpecialVictoryCondition>[];
    
    // Perfect victory (no mistakes, optimal time)
    if (firstTry && timeUsed <= 30) {
      conditions.add(SpecialVictoryCondition.perfect);
    }
    
    // Speed demon (very fast completion)
    if (timeUsed <= 10) {
      conditions.add(SpecialVictoryCondition.speedDemon);
    }
    
    // Efficient victory (minimal turns)
    if (turnsUsed <= 3) {
      conditions.add(SpecialVictoryCondition.efficient);
    }
    
    // Large number slayer
    if (originalEnemy.originalValue >= 1000) {
      conditions.add(SpecialVictoryCondition.giantSlayer);
    }
    
    // Power hunter (defeated power enemy)
    if (originalEnemy.isPowerEnemy) {
      conditions.add(SpecialVictoryCondition.powerHunter);
    }
    
    // Prime collector (used many different primes)
    if (primesUsed.toSet().length >= 5) {
      conditions.add(SpecialVictoryCondition.primeCollector);
    }
    
    // Minimalist (used very few different primes)
    if (primesUsed.toSet().length <= 2 && turnsUsed >= 3) {
      conditions.add(SpecialVictoryCondition.minimalist);
    }
    
    return conditions;
  }

  /// Generate victory message based on performance
  static String generateVictoryMessage(VictoryScore score, List<SpecialVictoryCondition> conditions) {
    String message = 'Victory! ';
    
    // Base message from rank
    switch (score.rank) {
      case VictoryRank.perfect:
        message += 'Absolutely perfect execution!';
        break;
      case VictoryRank.excellent:
        message += 'Excellent work!';
        break;
      case VictoryRank.good:
        message += 'Well done!';
        break;
      case VictoryRank.average:
        message += 'Victory achieved!';
        break;
      case VictoryRank.poor:
        message += 'Victory, but could be better.';
        break;
    }
    
    // Add special condition messages
    if (conditions.contains(SpecialVictoryCondition.perfect)) {
      message += ' FLAWLESS VICTORY!';
    }
    if (conditions.contains(SpecialVictoryCondition.speedDemon)) {
      message += ' Lightning fast!';
    }
    if (conditions.contains(SpecialVictoryCondition.powerHunter)) {
      message += ' Power enemy defeated!';
    }
    
    return message;
  }
}

/// Result of victory validation
class VictoryValidationResult {
  final bool isValid;
  final int claimedValue;
  final int? rewardPrime;
  final TimePenalty? penalty;
  final String message;

  const VictoryValidationResult({
    required this.isValid,
    required this.claimedValue,
    this.rewardPrime,
    this.penalty,
    required this.message,
  });

  @override
  String toString() {
    return 'VictoryValidationResult(valid: $isValid, claimed: $claimedValue, message: $message)';
  }
}

/// Victory performance score
class VictoryScore {
  final int totalScore;
  final int baseScore;
  final int difficultyBonus;
  final int efficiencyBonus;
  final int penaltyDeduction;
  final VictoryRank rank;

  const VictoryScore({
    required this.totalScore,
    required this.baseScore,
    required this.difficultyBonus,
    required this.efficiencyBonus,
    required this.penaltyDeduction,
    required this.rank,
  });

  @override
  String toString() {
    return 'VictoryScore(total: $totalScore, rank: ${rank.name})';
  }
}

/// Victory performance ranks
enum VictoryRank {
  perfect,
  excellent,
  good,
  average,
  poor,
}

/// Special victory conditions
enum SpecialVictoryCondition {
  perfect,        // No mistakes, fast completion
  speedDemon,     // Very fast completion
  efficient,      // Minimal turns used
  giantSlayer,    // Defeated very large enemy
  powerHunter,    // Defeated power enemy
  primeCollector, // Used many different primes
  minimalist,     // Used few different primes but many turns
}