import 'game_exception.dart';

class DataException extends GameException {
  const DataException(String message, [String? details])
      : super(message, details);
}

class DatabaseException extends DataException {
  const DatabaseException(String message, [String? details])
      : super(message, details);
}

class DataCorruptionException extends DataException {
  const DataCorruptionException(String message, [String? details])
      : super(message, details);
}

class SaveDataNotFoundException extends DataException {
  const SaveDataNotFoundException()
      : super('Save data not found');
}

class SerializationException extends DataException {
  const SerializationException(String message, [String? details])
      : super(message, details);
}