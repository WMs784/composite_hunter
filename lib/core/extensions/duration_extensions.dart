extension DurationExtensions on Duration {
  /// Format duration as MM:SS
  String get formattedTime {
    final minutes = inMinutes;
    final seconds = inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// Format duration as seconds only
  String get formattedSeconds {
    return '${inSeconds}s';
  }
  
  /// Check if duration is in warning range (less than 10 seconds)
  bool get isWarning => inSeconds <= 10 && inSeconds > 5;
  
  /// Check if duration is in critical range (less than 5 seconds)
  bool get isCritical => inSeconds <= 5 && inSeconds > 0;
  
  /// Check if duration is expired
  bool get isExpired => inSeconds <= 0;
}