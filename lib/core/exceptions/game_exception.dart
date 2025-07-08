abstract class GameException implements Exception {
  final String message;
  final String? details;
  
  const GameException(this.message, [this.details]);
  
  @override
  String toString() {
    if (details != null) {
      return '$runtimeType: $message\nDetails: $details';
    }
    return '$runtimeType: $message';
  }
}

class InvalidAttackException extends GameException {
  const InvalidAttackException(String message, [String? details])
      : super(message, details);
}

class InvalidPrimeException extends GameException {
  const InvalidPrimeException(String message, [String? details])
      : super(message, details);
}

class InsufficientInventoryException extends GameException {
  const InsufficientInventoryException(String message, [String? details])
      : super(message, details);
}

class BattleStateException extends GameException {
  const BattleStateException(String message, [String? details])
      : super(message, details);
}