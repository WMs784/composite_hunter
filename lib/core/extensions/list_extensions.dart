import 'int_extensions.dart';

extension ListExtensions<T> on List<T> {
  /// Get a random element from the list
  T get randomElement {
    if (isEmpty) throw StateError('Cannot get random element from empty list');
    final random = DateTime.now().millisecondsSinceEpoch % length;
    return this[random];
  }
  
  /// Get multiple random elements from the list without repetition
  List<T> randomElements(int count) {
    if (count > length) {
      throw ArgumentError('Cannot get $count elements from list of length $length');
    }
    
    final shuffled = List<T>.from(this)..shuffle();
    return shuffled.take(count).toList();
  }
  
  /// Split list into chunks of specified size
  List<List<T>> chunked(int chunkSize) {
    if (chunkSize <= 0) throw ArgumentError('Chunk size must be positive');
    
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += chunkSize) {
      final end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }
}

extension IntListExtensions on List<int> {
  /// Get only prime numbers from the list
  List<int> get primes => where((n) => n.isPrime).toList();
  
  /// Get only composite numbers from the list
  List<int> get composites => where((n) => n > 1 && !n.isPrime).toList();
  
  /// Calculate the product of all numbers in the list
  int get product => isEmpty ? 1 : reduce((a, b) => a * b);
}