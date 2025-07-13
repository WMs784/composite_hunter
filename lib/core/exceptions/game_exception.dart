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
  const InvalidAttackException(super.message, [super.details]);
}

class InvalidPrimeException extends GameException {
  const InvalidPrimeException(super.message, [super.details]);
}

class InsufficientInventoryException extends GameException {
  const InsufficientInventoryException(super.message, [super.details]);
}

class BattleStateException extends GameException {
  const BattleStateException(super.message, [super.details]);
}