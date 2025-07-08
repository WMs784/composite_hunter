import '../entities/enemy.dart';
import '../entities/prime.dart';
import '../entities/victory_claim.dart';
import '../entities/penalty_state.dart';
import '../../core/constants/timer_constants.dart';
import '../../core/exceptions/game_exception.dart';
import '../../core/utils/logger.dart';

/// Core battle logic engine
class BattleEngine {
  /// Execute an attack on an enemy with a prime
  static BattleResult executeAttack(Enemy enemy, Prime prime) {
    try {
      Logger.logBattle('Execute attack', data: {
        'enemy': enemy.currentValue,
        'prime': prime.value,
      });

      // Validate attack
      if (!enemy.canBeAttackedBy(prime.value)) {
        return BattleResult.error(
          'Cannot attack ${enemy.currentValue} with prime ${prime.value}',
        );
      }

      // Perform attack
      final newEnemy = enemy.attack(prime.value);

      // Check if enemy is defeated (reduced to prime)
      if (newEnemy.isDefeated) {
        Logger.logBattle('Enemy defeated, awaiting victory claim');
        return BattleResult.awaitingVictoryClaim(
          newEnemy: newEnemy,
          usedPrime: prime,
        );
      }

      // Battle continues
      Logger.logBattle('Attack successful, battle continues');
      return BattleResult.continue_(
        newEnemy: newEnemy,
        usedPrime: prime,
      );
    } catch (e, stackTrace) {
      Logger.error('Attack execution failed', e, stackTrace);
      return BattleResult.error('Attack failed: $e');
    }
  }

  /// Process a victory claim
  static BattleResult processVictoryClaim(Enemy enemy, int claimedValue) {
    try {
      Logger.logBattle('Process victory claim', data: {
        'enemy': enemy.currentValue,
        'claimed': claimedValue,
      });

      // Validate the claim
      final claim = VictoryClaim.validate(claimedValue, DateTime.now());

      if (claim.isCorrect) {
        // Correct victory claim
        if (enemy.isPowerEnemy) {
          Logger.logBattle('Power enemy victory');
          return BattleResult.powerVictory(
            defeatedEnemy: enemy,
            rewardPrime: enemy.powerRewardPrime,
            rewardCount: enemy.powerRewardCount,
            victoryClaim: claim,
          );
        } else {
          Logger.logBattle('Normal victory');
          return BattleResult.victory(
            defeatedEnemy: enemy,
            rewardPrime: claim.rewardPrime!,
            victoryClaim: claim,
          );
        }
      } else {
        // Wrong victory claim - apply penalty
        Logger.logBattle('Wrong victory claim, applying penalty');
        final penalty = TimePenalty(
          seconds: TimerConstants.wrongVictoryClaimPenalty,
          type: PenaltyType.wrongVictoryClaim,
          appliedAt: DateTime.now(),
          reason: claim.errorMessage,
        );

        return BattleResult.wrongClaim(
          penalty: penalty,
          currentEnemy: enemy,
          victoryClaim: claim,
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Victory claim processing failed', e, stackTrace);
      return BattleResult.error('Victory claim failed: $e');
    }
  }

  /// Process battle escape
  static BattleResult processEscape() {
    Logger.logBattle('Process escape');
    
    final penalty = TimePenalty(
      seconds: TimerConstants.escapePenalty,
      type: PenaltyType.escape,
      appliedAt: DateTime.now(),
      reason: 'Player escaped from battle',
    );

    return BattleResult.escape(penalty: penalty);
  }

  /// Process battle timeout
  static BattleResult processTimeOut() {
    Logger.logBattle('Process timeout');
    
    final penalty = TimePenalty(
      seconds: TimerConstants.timeOutPenalty,
      type: PenaltyType.timeOut,
      appliedAt: DateTime.now(),
      reason: 'Battle timer expired',
    );

    return BattleResult.timeOut(penalty: penalty);
  }

  /// Validate if an attack is possible
  static bool canAttack(Enemy enemy, Prime prime, List<Prime> inventory) {
    // Check if prime is available in inventory
    final availablePrime = inventory
        .where((p) => p.value == prime.value && p.isAvailable)
        .firstOrNull;
    
    if (availablePrime == null) return false;

    // Check if prime can attack enemy
    return enemy.canBeAttackedBy(prime.value);
  }

  /// Calculate battle difficulty
  static int calculateBattleDifficulty(Enemy enemy, List<Prime> inventory) {
    int difficulty = enemy.difficulty;
    
    // Adjust based on available attacks
    final availableAttacks = inventory
        .where((prime) => 
            prime.isAvailable && 
            enemy.canBeAttackedBy(prime.value))
        .length;
    
    if (availableAttacks == 0) {
      difficulty += 10; // Impossible battle
    } else if (availableAttacks == 1) {
      difficulty += 3; // Limited options
    } else if (availableAttacks >= 5) {
      difficulty -= 1; // Many options available
    }
    
    return difficulty.clamp(1, 10);
  }

  /// Get optimal attack strategy suggestion
  static List<Prime> suggestOptimalAttacks(Enemy enemy, List<Prime> inventory) {
    final availableAttacks = inventory
        .where((prime) => 
            prime.isAvailable && 
            enemy.canBeAttackedBy(prime.value))
        .toList();

    // Sort by strategic value (larger primes first for efficiency)
    availableAttacks.sort((a, b) => b.value.compareTo(a.value));
    
    return availableAttacks.take(3).toList(); // Return top 3 suggestions
  }
}

/// Battle result union type
sealed class BattleResult {
  const BattleResult();

  factory BattleResult.victory({
    required Enemy defeatedEnemy,
    required int rewardPrime,
    required VictoryClaim victoryClaim,
  }) = BattleVictory;

  factory BattleResult.powerVictory({
    required Enemy defeatedEnemy,
    required int rewardPrime,
    required int rewardCount,
    required VictoryClaim victoryClaim,
  }) = BattlePowerVictory;

  factory BattleResult.continue_({
    required Enemy newEnemy,
    required Prime usedPrime,
  }) = BattleContinue;

  factory BattleResult.awaitingVictoryClaim({
    required Enemy newEnemy,
    required Prime usedPrime,
  }) = BattleAwaitingVictoryClaim;

  factory BattleResult.wrongClaim({
    required TimePenalty penalty,
    required Enemy currentEnemy,
    required VictoryClaim victoryClaim,
  }) = BattleWrongClaim;

  factory BattleResult.escape({
    required TimePenalty penalty,
  }) = BattleEscape;

  factory BattleResult.timeOut({
    required TimePenalty penalty,
  }) = BattleTimeOut;

  factory BattleResult.error(String message) = BattleError;

  /// Pattern matching method
  T when<T>({
    required T Function(Enemy defeatedEnemy, int rewardPrime, VictoryClaim victoryClaim) victory,
    required T Function(Enemy defeatedEnemy, int rewardPrime, int rewardCount, VictoryClaim victoryClaim) powerVictory,
    required T Function(Enemy newEnemy, Prime usedPrime) continue_,
    required T Function(Enemy newEnemy, Prime usedPrime) awaitingVictoryClaim,
    required T Function(TimePenalty penalty, Enemy currentEnemy, VictoryClaim victoryClaim) wrongClaim,
    required T Function(TimePenalty penalty) escape,
    required T Function(TimePenalty penalty) timeOut,
    required T Function(String message) error,
  }) {
    return switch (this) {
      BattleVictory(defeatedEnemy: final e, rewardPrime: final r, victoryClaim: final v) => 
        victory(e, r, v),
      BattlePowerVictory(defeatedEnemy: final e, rewardPrime: final r, rewardCount: final c, victoryClaim: final v) => 
        powerVictory(e, r, c, v),
      BattleContinue(newEnemy: final e, usedPrime: final p) => 
        continue_(e, p),
      BattleAwaitingVictoryClaim(newEnemy: final e, usedPrime: final p) => 
        awaitingVictoryClaim(e, p),
      BattleWrongClaim(penalty: final pen, currentEnemy: final e, victoryClaim: final v) => 
        wrongClaim(pen, e, v),
      BattleEscape(penalty: final p) => 
        escape(p),
      BattleTimeOut(penalty: final p) => 
        timeOut(p),
      BattleError(message: final m) => 
        error(m),
    };
  }
}

// Battle result implementations
final class BattleVictory extends BattleResult {
  final Enemy defeatedEnemy;
  final int rewardPrime;
  final VictoryClaim victoryClaim;

  const BattleVictory({
    required this.defeatedEnemy,
    required this.rewardPrime,
    required this.victoryClaim,
  });
}

final class BattlePowerVictory extends BattleResult {
  final Enemy defeatedEnemy;
  final int rewardPrime;
  final int rewardCount;
  final VictoryClaim victoryClaim;

  const BattlePowerVictory({
    required this.defeatedEnemy,
    required this.rewardPrime,
    required this.rewardCount,
    required this.victoryClaim,
  });
}

final class BattleContinue extends BattleResult {
  final Enemy newEnemy;
  final Prime usedPrime;

  const BattleContinue({
    required this.newEnemy,
    required this.usedPrime,
  });
}

final class BattleAwaitingVictoryClaim extends BattleResult {
  final Enemy newEnemy;
  final Prime usedPrime;

  const BattleAwaitingVictoryClaim({
    required this.newEnemy,
    required this.usedPrime,
  });
}

final class BattleWrongClaim extends BattleResult {
  final TimePenalty penalty;
  final Enemy currentEnemy;
  final VictoryClaim victoryClaim;

  const BattleWrongClaim({
    required this.penalty,
    required this.currentEnemy,
    required this.victoryClaim,
  });
}

final class BattleEscape extends BattleResult {
  final TimePenalty penalty;

  const BattleEscape({required this.penalty});
}

final class BattleTimeOut extends BattleResult {
  final TimePenalty penalty;

  const BattleTimeOut({required this.penalty});
}

final class BattleError extends BattleResult {
  final String message;

  const BattleError(this.message);
}