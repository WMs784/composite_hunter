import 'game_exception.dart';

class DataException extends GameException {
  const DataException(super.message, [super.details]);
}

class DatabaseException extends DataException {
  const DatabaseException(super.message, [super.details]);
}

class DataCorruptionException extends DataException {
  const DataCorruptionException(super.message, [super.details]);
}

class SaveDataNotFoundException extends DataException {
  const SaveDataNotFoundException() : super('Save data not found');
}

class SerializationException extends DataException {
  const SerializationException(super.message, [super.details]);
}
