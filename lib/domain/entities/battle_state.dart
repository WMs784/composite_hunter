import 'package:freezed_annotation/freezed_annotation.dart';
import 'enemy.dart';
import 'prime.dart';
import 'timer_state.dart';
import 'victory_claim.dart';
import 'penalty_state.dart';

part 'battle_state.freezed.dart';

@freezed
class BattleState with _$BattleState {
  const factory BattleState({
    Enemy? currentEnemy,
    @Default([]) List<Prime> usedPrimes,
    @Default(BattleStatus.waiting) BattleStatus status,
    @Default(0) int turnCount,
    DateTime? battleStartTime,
    TimerState? timerState,
    VictoryClaim? victoryClaim,
    @Default([]) List<TimePenalty> battlePenalties,
  }) = _BattleState;

  const BattleState._();

  /// Check if the player can fight (has valid state and time)
  bool canFight(List<Prime> inventory) {
    return currentEnemy != null &&
        timerState?.isExpired != true &&
        status == BattleStatus.fighting;
  }

  /// Check if the player can claim victory
  bool get canClaimVictory {
    return currentEnemy != null &&
        currentEnemy!.isDefeated &&
        timerState?.isActive == true &&
        !timerState!.isExpired &&
        status == BattleStatus.fighting;
  }

  /// Check if the battle is in progress
  bool get isInProgress => status == BattleStatus.fighting;

  /// Check if the battle is completed
  bool get isCompleted => [
    BattleStatus.victory,
    BattleStatus.escape,
    BattleStatus.defeat,
    BattleStatus.timeOut,
  ].contains(status);

  /// Get the current battle duration
  Duration? get battleDuration {
    if (battleStartTime == null) return null;
    return DateTime.now().difference(battleStartTime!);
  }

  /// Get the progress percentage of the battle
  double get battleProgress {
    if (currentEnemy == null) return 0.0;

    final originalValue = currentEnemy!.originalValue;
    final currentValue = currentEnemy!.currentValue;

    // Progress is based on how much the enemy value has been reduced
    if (originalValue == currentValue) return 0.0;

    // For composite numbers, we estimate progress based on value reduction
    return 1.0 - (currentValue / originalValue);
  }

  /// Advance to next turn
  BattleState nextTurn(Prime usedPrime) {
    return copyWith(
      usedPrimes: [...usedPrimes, usedPrime],
      turnCount: turnCount + 1,
    );
  }

  /// Apply a time penalty
  BattleState applyTimePenalty(TimePenalty penalty) {
    return copyWith(
      timerState: timerState?.applyPenalty(penalty),
      battlePenalties: [...battlePenalties, penalty],
    );
  }

  /// Start a new battle
  BattleState startBattle(Enemy enemy, TimerState timer) {
    return copyWith(
      currentEnemy: enemy,
      status: BattleStatus.fighting,
      battleStartTime: DateTime.now(),
      timerState: timer.start(),
      usedPrimes: [],
      turnCount: 0,
      victoryClaim: null,
      battlePenalties: [],
    );
  }

  /// End the battle with a specific status
  BattleState endBattle(BattleStatus endStatus, {VictoryClaim? claim}) {
    return copyWith(
      status: endStatus,
      timerState: timerState?.stop(),
      victoryClaim: claim,
    );
  }

  /// Get battle summary for statistics
  BattleSummary get summary {
    return BattleSummary(
      enemy: currentEnemy,
      turnsUsed: turnCount,
      primesUsed: usedPrimes.length,
      duration: battleDuration,
      penalties: battlePenalties.length,
      result: status,
      victoryClaim: victoryClaim,
    );
  }

  /// Get available primes that can attack current enemy
  List<Prime> getAvailableAttacks(List<Prime> inventory) {
    if (currentEnemy == null) return [];

    return inventory
        .where(
          (prime) =>
              prime.isAvailable && currentEnemy!.canBeAttackedBy(prime.value),
        )
        .toList();
  }

  @override
  String toString() {
    return 'BattleState(status: $status, enemy: ${currentEnemy?.currentValue}, turn: $turnCount)';
  }
}

enum BattleStatus { waiting, fighting, victory, escape, defeat, timeOut }

@freezed
class BattleSummary with _$BattleSummary {
  const factory BattleSummary({
    Enemy? enemy,
    required int turnsUsed,
    required int primesUsed,
    Duration? duration,
    required int penalties,
    required BattleStatus result,
    VictoryClaim? victoryClaim,
  }) = _BattleSummary;

  const BattleSummary._();

  /// Check if this was a successful battle
  bool get wasSuccessful => result == BattleStatus.victory;

  /// Get efficiency score (0-100)
  int get efficiencyScore {
    if (!wasSuccessful) return 0;

    int score = 100;

    // Deduct points for excessive turns
    if (turnsUsed > 5) score -= (turnsUsed - 5) * 5;

    // Deduct points for penalties
    score -= penalties * 10;

    // Bonus for quick completion
    if (duration != null && duration!.inSeconds < 30) {
      score += 10;
    }

    return score.clamp(0, 100);
  }

  /// Get difficulty rating
  String get difficultyRating {
    if (enemy == null) return 'Unknown';

    final difficulty = enemy!.difficulty;
    if (difficulty <= 2) return 'Easy';
    if (difficulty <= 4) return 'Medium';
    if (difficulty <= 6) return 'Hard';
    return 'Expert';
  }
}
