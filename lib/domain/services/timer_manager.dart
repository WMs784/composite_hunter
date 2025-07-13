import 'dart:async';
import '../entities/timer_state.dart';
import '../entities/penalty_state.dart';
import '../entities/enemy.dart';
import '../../core/constants/timer_constants.dart';
import '../../core/exceptions/timer_exception.dart';
import '../../core/utils/logger.dart';

/// Service for managing battle timers with penalty system
class TimerManager {
  Timer? _timer;
  final StreamController<TimerState> _timerController =
      StreamController<TimerState>.broadcast();
  TimerState _currentState =
      const TimerState(remainingSeconds: 0, originalSeconds: 0);

  /// Stream of timer state updates
  Stream<TimerState> get timerStream => _timerController.stream;

  /// Current timer state
  TimerState get currentState => _currentState;

  /// Check if timer is currently active
  bool get isActive => _currentState.isActive;

  /// Check if timer has expired
  bool get isExpired => _currentState.isExpired;

  /// Start a new timer with specified duration
  void startTimer(int seconds) {
    if (seconds <= 0) {
      throw InvalidTimerDurationException(seconds);
    }

    Logger.logTimer('Starting timer', seconds: seconds);

    // Stop any existing timer
    stopTimer();

    // Create new timer state
    _currentState = TimerState(
      remainingSeconds: seconds,
      originalSeconds: seconds,
      isActive: true,
    );

    // Start the periodic timer
    _timer = Timer.periodic(
      const Duration(milliseconds: TimerConstants.timerUpdateIntervalMs),
      _onTimerTick,
    );

    // Emit initial state
    _timerController.add(_currentState);
  }

  /// Stop the current timer
  void stopTimer() {
    if (_timer != null) {
      Logger.logTimer('Stopping timer');
      _timer!.cancel();
      _timer = null;

      _currentState = _currentState.stop();
      _timerController.add(_currentState);
    }
  }

  /// Pause the timer (keeps state but stops ticking)
  void pauseTimer() {
    if (_timer != null && _currentState.isActive) {
      Logger.logTimer('Pausing timer');
      _timer!.cancel();
      _timer = null;

      _currentState = _currentState.copyWith(isActive: false);
      _timerController.add(_currentState);
    }
  }

  /// Resume a paused timer
  void resumeTimer() {
    if (_timer == null && !_currentState.isExpired) {
      Logger.logTimer('Resuming timer');

      _currentState = _currentState.start();

      _timer = Timer.periodic(
        const Duration(milliseconds: TimerConstants.timerUpdateIntervalMs),
        _onTimerTick,
      );

      _timerController.add(_currentState);
    }
  }

  /// Apply a time penalty to the current timer
  void applyPenalty(TimePenalty penalty) {
    Logger.logTimer('Applying penalty', seconds: penalty.seconds);

    _currentState = _currentState.applyPenalty(penalty);
    _timerController.add(_currentState);

    // If timer expired due to penalty, handle it
    if (_currentState.isExpired && _timer != null) {
      stopTimer();
    }
  }

  /// Add time to the current timer (for bonuses)
  void addTime(int seconds) {
    if (seconds <= 0) return;

    Logger.logTimer('Adding bonus time', seconds: seconds);

    _currentState = _currentState.copyWith(
      remainingSeconds: _currentState.remainingSeconds + seconds,
      isWarning: false, // Reset warning if we're back above threshold
    );

    _timerController.add(_currentState);
  }

  /// Reset timer to original duration
  void resetTimer() {
    Logger.logTimer('Resetting timer');

    if (_currentState.originalSeconds > 0) {
      startTimer(_currentState.originalSeconds);
    }
  }

  /// Get base timer duration for an enemy type
  static int getBaseTimeForEnemy(Enemy enemy) {
    switch (enemy.size) {
      case EnemySize.small:
        return TimerConstants.smallEnemyTimer;
      case EnemySize.medium:
        return TimerConstants.mediumEnemyTimer;
      case EnemySize.large:
        return TimerConstants.largeEnemyTimer;
    }
  }

  /// Calculate adjusted timer duration with penalties applied
  static int getAdjustedTimeForEnemy(Enemy enemy, List<TimePenalty> penalties) {
    final baseTime = getBaseTimeForEnemy(enemy);
    final totalPenalty =
        penalties.fold(0, (sum, penalty) => sum + penalty.seconds);

    final adjustedTime = baseTime - totalPenalty;
    return adjustedTime < TimerConstants.minimumTimerDuration
        ? TimerConstants.minimumTimerDuration
        : adjustedTime;
  }

  /// Handle timer tick
  void _onTimerTick(Timer timer) {
    if (!_currentState.isActive) {
      timer.cancel();
      return;
    }

    _currentState = _currentState.tick();
    _timerController.add(_currentState);

    // Stop timer if expired
    if (_currentState.isExpired) {
      Logger.logTimer('Timer expired');
      stopTimer();
    }
  }

  /// Get time remaining as formatted string
  String get formattedTimeRemaining => _currentState.formattedTime;

  /// Get timer progress as percentage (0.0 to 1.0)
  double get progress => _currentState.progress;

  /// Check if timer is in warning state
  bool get isWarning => _currentState.shouldShowWarning;

  /// Check if timer is in critical state
  bool get isCritical => _currentState.isCritical;

  /// Get timer display state for UI
  TimerDisplayState get displayState => _currentState.displayState;

  /// Create a timer snapshot for saving/loading
  TimerSnapshot createSnapshot() {
    return TimerSnapshot(
      remainingSeconds: _currentState.remainingSeconds,
      originalSeconds: _currentState.originalSeconds,
      isActive: _currentState.isActive,
      penalties: _currentState.penalties,
      snapshotTime: DateTime.now(),
    );
  }

  /// Restore timer from a snapshot
  void restoreFromSnapshot(TimerSnapshot snapshot) {
    Logger.logTimer('Restoring from snapshot');

    // Calculate elapsed time since snapshot
    final elapsedSinceSnapshot =
        DateTime.now().difference(snapshot.snapshotTime).inSeconds;

    int adjustedRemaining = snapshot.remainingSeconds;
    if (snapshot.isActive) {
      adjustedRemaining = (snapshot.remainingSeconds - elapsedSinceSnapshot)
          .clamp(0, snapshot.originalSeconds);
    }

    _currentState = TimerState(
      remainingSeconds: adjustedRemaining,
      originalSeconds: snapshot.originalSeconds,
      isActive: snapshot.isActive && adjustedRemaining > 0,
      penalties: snapshot.penalties,
    );

    if (_currentState.isActive && !_currentState.isExpired) {
      resumeTimer();
    } else {
      _timerController.add(_currentState);
    }
  }

  /// Get statistics about timer usage
  TimerStatistics getStatistics() {
    return TimerStatistics(
      totalTimeUsed:
          _currentState.originalSeconds - _currentState.remainingSeconds,
      totalPenalties: _currentState.penalties.length,
      totalPenaltyTime: _currentState.totalPenaltySeconds,
      currentEfficiency: _calculateEfficiency(),
    );
  }

  /// Calculate timer efficiency (0.0 to 1.0)
  double _calculateEfficiency() {
    if (_currentState.originalSeconds == 0) return 1.0;

    final timeUsed =
        _currentState.originalSeconds - _currentState.remainingSeconds;
    final penaltyTime = _currentState.totalPenaltySeconds;
    final effectiveTime = timeUsed - penaltyTime;

    return (effectiveTime / _currentState.originalSeconds).clamp(0.0, 1.0);
  }

  /// Dispose of resources
  void dispose() {
    Logger.logTimer('Disposing timer manager');

    _timer?.cancel();
    _timer = null;
    _timerController.close();
  }
}

/// Snapshot of timer state for persistence
class TimerSnapshot {
  final int remainingSeconds;
  final int originalSeconds;
  final bool isActive;
  final List<TimePenalty> penalties;
  final DateTime snapshotTime;

  const TimerSnapshot({
    required this.remainingSeconds,
    required this.originalSeconds,
    required this.isActive,
    required this.penalties,
    required this.snapshotTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'remainingSeconds': remainingSeconds,
      'originalSeconds': originalSeconds,
      'isActive': isActive,
      'penalties': penalties
          .map((p) => {
                'seconds': p.seconds,
                'type': p.type.name,
                'appliedAt': p.appliedAt.toIso8601String(),
                'reason': p.reason,
              })
          .toList(),
      'snapshotTime': snapshotTime.toIso8601String(),
    };
  }

  factory TimerSnapshot.fromJson(Map<String, dynamic> json) {
    return TimerSnapshot(
      remainingSeconds: json['remainingSeconds'] as int,
      originalSeconds: json['originalSeconds'] as int,
      isActive: json['isActive'] as bool,
      penalties: (json['penalties'] as List)
          .map((p) => TimePenalty(
                seconds: p['seconds'] as int,
                type: PenaltyType.values.firstWhere((t) => t.name == p['type']),
                appliedAt: DateTime.parse(p['appliedAt'] as String),
                reason: p['reason'] as String?,
              ))
          .toList(),
      snapshotTime: DateTime.parse(json['snapshotTime'] as String),
    );
  }
}

/// Timer usage statistics
class TimerStatistics {
  final int totalTimeUsed;
  final int totalPenalties;
  final int totalPenaltyTime;
  final double currentEfficiency;

  const TimerStatistics({
    required this.totalTimeUsed,
    required this.totalPenalties,
    required this.totalPenaltyTime,
    required this.currentEfficiency,
  });

  @override
  String toString() {
    return 'TimerStatistics(used: ${totalTimeUsed}s, penalties: $totalPenalties, efficiency: ${(currentEfficiency * 100).toStringAsFixed(1)}%)';
  }
}
