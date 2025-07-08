import 'game_exception.dart';

class VictoryException extends GameException {
  const VictoryException(String message, [String? details])
      : super(message, details);
}

class InvalidVictoryClaimException extends VictoryException {
  const InvalidVictoryClaimException(int claimedValue)
      : super('Invalid victory claim: $claimedValue is not prime');
}

class VictoryClaimNotAllowedException extends VictoryException {
  const VictoryClaimNotAllowedException()
      : super('Victory claim is not allowed at this time');
}

class PrematureVictoryClaimException extends VictoryException {
  const PrematureVictoryClaimException(int currentValue)
      : super('Premature victory claim: $currentValue is still composite');
}