import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math' as math;
import 'penalty_state.dart';
import '../../core/constants/timer_constants.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    required int remainingSeconds,
    required int originalSeconds,
    @Default(false) bool isActive,
    @Default(false) bool isWarning,
    @Default([]) List<TimePenalty> penalties,
  }) = _TimerState;

  const TimerState._();

  /// Check if the timer has expired
  bool get isExpired => remainingSeconds <= 0;

  /// Check if the timer should show warning
  bool get shouldShowWarning =>
      remainingSeconds <= TimerConstants.warningThreshold &&
      remainingSeconds > TimerConstants.criticalThreshold &&
      isActive;

  /// Check if the timer is in critical state
  bool get isCritical =>
      remainingSeconds <= TimerConstants.criticalThreshold &&
      remainingSeconds > 0 &&
      isActive;

  /// Get total penalty seconds applied
  int get totalPenaltySeconds {
    return penalties.fold(0, (sum, penalty) => sum + penalty.seconds);
  }

  /// Get remaining time as a percentage
  double get progress {
    if (originalSeconds == 0) return 0.0;
    return remainingSeconds / originalSeconds;
  }

  /// Apply a penalty to the timer
  TimerState applyPenalty(TimePenalty penalty) {
    final newRemainingSeconds = math.max(0, remainingSeconds - penalty.seconds);
    return copyWith(
      remainingSeconds: newRemainingSeconds,
      penalties: [...penalties, penalty],
      isWarning: newRemainingSeconds <= TimerConstants.warningThreshold,
    );
  }

  /// Tick the timer (reduce by 1 second)
  TimerState tick() {
    if (!isActive || remainingSeconds <= 0) return this;

    final newRemainingSeconds = remainingSeconds - 1;
    return copyWith(
      remainingSeconds: newRemainingSeconds,
      isWarning:
          newRemainingSeconds <= TimerConstants.warningThreshold &&
          newRemainingSeconds > TimerConstants.criticalThreshold,
    );
  }

  /// Start the timer
  TimerState start() {
    return copyWith(isActive: true);
  }

  /// Stop the timer
  TimerState stop() {
    return copyWith(isActive: false);
  }

  /// Reset the timer to original duration
  TimerState reset() {
    return copyWith(
      remainingSeconds: originalSeconds,
      isActive: false,
      isWarning: false,
      penalties: [],
    );
  }

  /// Format the remaining time as MM:SS
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get the current timer state for UI styling
  TimerDisplayState get displayState {
    if (isExpired) return TimerDisplayState.expired;
    if (isCritical) return TimerDisplayState.critical;
    if (shouldShowWarning) return TimerDisplayState.warning;
    return TimerDisplayState.normal;
  }

  @override
  String toString() {
    return 'TimerState(remaining: $remainingSeconds, active: $isActive, expired: $isExpired)';
  }
}

enum TimerDisplayState { normal, warning, critical, expired }
