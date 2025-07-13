import 'game_exception.dart';

class TimerException extends GameException {
  const TimerException(super.message, [super.details]);
}

class TimerAlreadyRunningException extends TimerException {
  const TimerAlreadyRunningException()
      : super('Timer is already running');
}

class TimerNotActiveException extends TimerException {
  const TimerNotActiveException()
      : super('Timer is not currently active');
}

class InvalidTimerDurationException extends TimerException {
  const InvalidTimerDurationException(int duration)
      : super('Invalid timer duration: $duration seconds');
}