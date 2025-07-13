import 'package:freezed_annotation/freezed_annotation.dart';

part 'penalty_state.freezed.dart';

@freezed
class TimePenalty with _$TimePenalty {
  const factory TimePenalty({
    required int seconds,
    required PenaltyType type,
    required DateTime appliedAt,
    String? reason,
  }) = _TimePenalty;

  const TimePenalty._();

  /// Get a human-readable description of the penalty
  String get description {
    switch (type) {
      case PenaltyType.escape:
        return 'Escaped from battle (-${seconds}s)';
      case PenaltyType.wrongVictoryClaim:
        return 'Wrong victory claim (-${seconds}s)';
      case PenaltyType.timeOut:
        return 'Time ran out (-${seconds}s)';
    }
  }

  /// Get a short description for UI
  String get shortDescription {
    switch (type) {
      case PenaltyType.escape:
        return 'Escape';
      case PenaltyType.wrongVictoryClaim:
        return 'Wrong claim';
      case PenaltyType.timeOut:
        return 'Timeout';
    }
  }

  /// Check if this penalty is severe (affects future battles)
  bool get isSevere => seconds >= 10;

  @override
  String toString() {
    return 'TimePenalty(${type.name}: ${seconds}s at ${appliedAt.toIso8601String()})';
  }
}

enum PenaltyType {
  escape,
  wrongVictoryClaim,
  timeOut,
}

@freezed
class PenaltyState with _$PenaltyState {
  const factory PenaltyState({
    @Default([]) List<TimePenalty> activePenalties,
    @Default(0) int totalPenaltySeconds,
    @Default(0) int consecutiveEscapes,
    @Default(0) int consecutiveWrongClaims,
  }) = _PenaltyState;

  const PenaltyState._();

  /// Add a new penalty
  PenaltyState addPenalty(TimePenalty penalty) {
    final newPenalties = [...activePenalties, penalty];
    final newTotal = totalPenaltySeconds + penalty.seconds;

    int newConsecutiveEscapes = consecutiveEscapes;
    int newConsecutiveWrongClaims = consecutiveWrongClaims;

    switch (penalty.type) {
      case PenaltyType.escape:
        newConsecutiveEscapes++;
        newConsecutiveWrongClaims = 0; // Reset wrong claims streak
        break;
      case PenaltyType.wrongVictoryClaim:
        newConsecutiveWrongClaims++;
        newConsecutiveEscapes = 0; // Reset escape streak
        break;
      case PenaltyType.timeOut:
        // Timeout doesn't affect streaks
        break;
    }

    return copyWith(
      activePenalties: newPenalties,
      totalPenaltySeconds: newTotal,
      consecutiveEscapes: newConsecutiveEscapes,
      consecutiveWrongClaims: newConsecutiveWrongClaims,
    );
  }

  /// Clear penalties after a successful battle
  PenaltyState clearPenalties() {
    return copyWith(
      activePenalties: [],
      totalPenaltySeconds: 0,
      consecutiveEscapes: 0,
      consecutiveWrongClaims: 0,
    );
  }

  /// Get penalties by type
  List<TimePenalty> getPenaltiesByType(PenaltyType type) {
    return activePenalties.where((penalty) => penalty.type == type).toList();
  }

  /// Check if player is in a penalty streak
  bool get hasEscapeStreak => consecutiveEscapes >= 3;
  bool get hasWrongClaimStreak => consecutiveWrongClaims >= 3;
  bool get hasAnyStreak => hasEscapeStreak || hasWrongClaimStreak;

  /// Get warning message for streaks
  String? get streakWarning {
    if (hasEscapeStreak) {
      return 'Too many escapes! Time penalties are accumulating.';
    }
    if (hasWrongClaimStreak) {
      return 'Multiple wrong claims! Be more careful with victory declarations.';
    }
    return null;
  }

  @override
  String toString() {
    return 'PenaltyState(total: ${totalPenaltySeconds}s, escapes: $consecutiveEscapes, claims: $consecutiveWrongClaims)';
  }
}
