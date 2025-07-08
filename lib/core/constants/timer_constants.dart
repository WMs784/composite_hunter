class TimerConstants {
  // Base timer durations (seconds)
  static const int smallEnemyTimer = 30;
  static const int mediumEnemyTimer = 60;
  static const int largeEnemyTimer = 90;
  
  // Warning thresholds
  static const int warningThreshold = 10; // seconds
  static const int criticalThreshold = 5; // seconds
  
  // Penalty durations
  static const int escapePenalty = 10; // seconds
  static const int wrongVictoryClaimPenalty = 10; // seconds
  static const int timeOutPenalty = 10; // seconds
  
  // Minimum timer duration
  static const int minimumTimerDuration = 10; // seconds
  
  // Timer update interval
  static const int timerUpdateIntervalMs = 1000; // 1 second
}