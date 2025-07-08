import 'package:freezed_annotation/freezed_annotation.dart';
import 'prime.dart';
import '../../core/constants/game_constants.dart';

part 'inventory.freezed.dart';

@freezed
class Inventory with _$Inventory {
  const factory Inventory({
    @Default([]) List<Prime> primes,
  }) = _Inventory;

  const Inventory._();

  /// Get total count of all primes
  int get totalCount => primes.fold(0, (sum, prime) => sum + prime.count);

  /// Get number of unique primes
  int get uniqueCount => primes.length;

  /// Get only available primes (count > 0)
  List<Prime> get availablePrimes => 
      primes.where((prime) => prime.isAvailable).toList();

  /// Get primes sorted by value
  List<Prime> get sortedByValue => 
      [...primes]..sort((a, b) => a.value.compareTo(b.value));

  /// Get primes sorted by count (highest first)
  List<Prime> get sortedByCount => 
      [...primes]..sort((a, b) => b.count.compareTo(a.count));

  /// Get primes sorted by usage frequency
  List<Prime> get sortedByUsage => 
      [...primes]..sort((a, b) => b.usageCount.compareTo(a.usageCount));

  /// Get a specific prime by value
  Prime? getPrime(int value) {
    try {
      return primes.firstWhere((prime) => prime.value == value);
    } catch (e) {
      return null;
    }
  }

  /// Check if inventory contains a specific prime
  bool hasPrime(int value) => getPrime(value) != null;

  /// Check if a prime is available for use
  bool isPrimeAvailable(int value) {
    final prime = getPrime(value);
    return prime?.isAvailable ?? false;
  }

  /// Add a prime to the inventory
  Inventory addPrime(Prime newPrime) {
    final existingPrime = getPrime(newPrime.value);
    
    if (existingPrime != null) {
      // Prime already exists, increase count
      final maxCount = newPrime.isSmallPrime 
          ? GameConstants.maxSmallPrimeCount 
          : GameConstants.maxLargePrimeCount;
      
      final newCount = (existingPrime.count + newPrime.count).clamp(0, maxCount);
      final updatedPrime = existingPrime.copyWith(count: newCount);
      
      final updatedPrimes = primes
          .map((prime) => prime.value == newPrime.value ? updatedPrime : prime)
          .toList();
      
      return copyWith(primes: updatedPrimes);
    } else {
      // New prime, add to inventory
      return copyWith(primes: [...primes, newPrime]);
    }
  }

  /// Use a prime (decrease count by 1)
  Inventory usePrime(Prime primeToUse) {
    final existingPrime = getPrime(primeToUse.value);
    
    if (existingPrime == null || !existingPrime.isAvailable) {
      throw StateError('Prime ${primeToUse.value} is not available');
    }
    
    final updatedPrime = existingPrime.decreaseCount().increaseUsage();
    List<Prime> updatedPrimes;
    
    if (updatedPrime.count == 0) {
      // Remove prime if count reaches 0
      updatedPrimes = primes
          .where((prime) => prime.value != primeToUse.value)
          .toList();
    } else {
      // Update the prime
      updatedPrimes = primes
          .map((prime) => prime.value == primeToUse.value ? updatedPrime : prime)
          .toList();
    }
    
    return copyWith(primes: updatedPrimes);
  }

  /// Remove a prime completely from inventory
  Inventory removePrime(int value) {
    final updatedPrimes = primes
        .where((prime) => prime.value != value)
        .toList();
    
    return copyWith(primes: updatedPrimes);
  }

  /// Get primes that can attack a specific enemy value
  List<Prime> getPrimesForAttack(int enemyValue) {
    return availablePrimes
        .where((prime) => enemyValue % prime.value == 0)
        .toList();
  }

  /// Get inventory statistics
  InventoryStats get stats {
    return InventoryStats(
      totalPrimes: totalCount,
      uniquePrimes: uniqueCount,
      smallPrimes: primes.where((p) => p.isSmallPrime).length,
      largePrimes: primes.where((p) => !p.isSmallPrime).length,
      mostUsedPrime: primes.isEmpty 
          ? null 
          : primes.reduce((a, b) => a.usageCount > b.usageCount ? a : b),
      averageUsage: primes.isEmpty 
          ? 0.0 
          : primes.fold(0, (sum, p) => sum + p.usageCount) / primes.length,
    );
  }

  /// Check if inventory is empty
  bool get isEmpty => primes.isEmpty || totalCount == 0;

  /// Check if inventory has any available primes
  bool get hasAvailablePrimes => availablePrimes.isNotEmpty;

  @override
  String toString() {
    return 'Inventory(${uniqueCount} unique primes, ${totalCount} total)';
  }
}

@freezed
class InventoryStats with _$InventoryStats {
  const factory InventoryStats({
    required int totalPrimes,
    required int uniquePrimes,
    required int smallPrimes,
    required int largePrimes,
    Prime? mostUsedPrime,
    required double averageUsage,
  }) = _InventoryStats;
}