import '../constants/timer_constants.dart';

class TimerUtils {
  /// Get base timer duration based on enemy value
  static int getBaseDuration(int enemyValue) {
    if (enemyValue <= 20) return TimerConstants.smallEnemyTimer;
    if (enemyValue <= 100) return TimerConstants.mediumEnemyTimer;
    return TimerConstants.largeEnemyTimer;
  }
  
  /// Calculate adjusted timer duration with penalties
  static int getAdjustedDuration(int baseDuration, int totalPenaltySeconds) {
    final adjusted = baseDuration - totalPenaltySeconds;
    return adjusted < TimerConstants.minimumTimerDuration 
        ? TimerConstants.minimumTimerDuration 
        : adjusted;
  }
  
  /// Format timer display (MM:SS)
  static String formatTimer(int seconds) {
    if (seconds < 0) seconds = 0;
    
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  
  /// Check if timer is in warning state
  static bool isWarning(int seconds) {
    return seconds <= TimerConstants.warningThreshold && seconds > TimerConstants.criticalThreshold;
  }
  
  /// Check if timer is in critical state
  static bool isCritical(int seconds) {
    return seconds <= TimerConstants.criticalThreshold && seconds > 0;
  }
  
  /// Check if timer is expired
  static bool isExpired(int seconds) {
    return seconds <= 0;
  }
  
  /// Get timer color based on remaining time
  static TimerState getTimerState(int seconds) {
    if (isExpired(seconds)) return TimerState.expired;
    if (isCritical(seconds)) return TimerState.critical;
    if (isWarning(seconds)) return TimerState.warning;
    return TimerState.normal;
  }
}

enum TimerState {
  normal,
  warning,
  critical,
  expired,
}