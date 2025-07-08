import 'dart:developer' as developer;

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  static const String _name = 'CompositeHunter';
  static bool _isDebugMode = true;
  
  static void setDebugMode(bool debug) {
    _isDebugMode = debug;
  }
  
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }
  
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }
  
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }
  
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }
  
  static void _log(
    LogLevel level,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    if (!_isDebugMode && level == LogLevel.debug) return;
    
    final timestamp = DateTime.now().toIso8601String();
    final levelName = level.name.toUpperCase();
    final logMessage = '[$timestamp] [$levelName] $message';
    
    developer.log(
      logMessage,
      name: _name,
      error: error,
      stackTrace: stackTrace,
      level: _getLoggerLevel(level),
    );
  }
  
  static int _getLoggerLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
  
  // Specific loggers for different components
  static void logBattle(String action, {Map<String, dynamic>? data}) {
    final message = 'BATTLE: $action';
    if (data != null) {
      info('$message - Data: $data');
    } else {
      info(message);
    }
  }
  
  static void logTimer(String action, {int? seconds}) {
    final message = 'TIMER: $action';
    if (seconds != null) {
      info('$message - Seconds: $seconds');
    } else {
      info(message);
    }
  }
  
  static void logInventory(String action, {int? prime, int? count}) {
    final message = 'INVENTORY: $action';
    if (prime != null && count != null) {
      info('$message - Prime: $prime, Count: $count');
    } else {
      info(message);
    }
  }
  
  static void logEnemy(String action, {int? value, String? type}) {
    final message = 'ENEMY: $action';
    if (value != null && type != null) {
      info('$message - Value: $value, Type: $type');
    } else {
      info(message);
    }
  }
}