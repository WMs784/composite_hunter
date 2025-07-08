import 'package:flutter_test/flutter_test.dart';
import 'package:composite_hunter/domain/entities/inventory.dart';
import 'package:composite_hunter/domain/entities/prime.dart';

void main() {
  group('Inventory Tests', () {
    late Inventory emptyInventory;
    late Inventory sampleInventory;
    
    setUp(() {
      emptyInventory = const Inventory();
      
      sampleInventory = Inventory(primes: [
        Prime(
          value: 2,
          count: 3,
          firstObtained: DateTime(2024, 1, 1),
          usageCount: 5,
        ),
        Prime(
          value: 3,
          count: 2,
          firstObtained: DateTime(2024, 1, 2),
          usageCount: 3,
        ),
        Prime(
          value: 5,
          count: 0,
          firstObtained: DateTime(2024, 1, 3),
          usageCount: 1,
        ),
        Prime(
          value: 7,
          count: 1,
          firstObtained: DateTime(2024, 1, 4),
          usageCount: 0,
        ),
      ]);
    });

    group('Basic Properties', () {
      test('should calculate total count correctly', () {
        expect(emptyInventory.totalCount, 0);
        expect(sampleInventory.totalCount, 6); // 3 + 2 + 0 + 1
      });

      test('should calculate unique count correctly', () {
        expect(emptyInventory.uniqueCount, 0);
        expect(sampleInventory.uniqueCount, 4);
      });

      test('should identify available primes', () {
        expect(emptyInventory.availablePrimes, isEmpty);
        
        final available = sampleInventory.availablePrimes;
        expect(available.length, 3);
        expect(available.map((p) => p.value), containsAll([2, 3, 7]));
        expect(available.map((p) => p.value), isNot(contains(5)));
      });

      test('should check if inventory is empty', () {
        expect(emptyInventory.isEmpty, true);
        expect(sampleInventory.isEmpty, false);
      });

      test('should check if has available primes', () {
        expect(emptyInventory.hasAvailablePrimes, false);
        expect(sampleInventory.hasAvailablePrimes, true);
      });
    });

    group('Prime Operations', () {
      test('should find primes by value', () {
        expect(emptyInventory.getPrime(2), isNull);
        
        final prime2 = sampleInventory.getPrime(2);
        expect(prime2, isNotNull);
        expect(prime2!.value, 2);
        expect(prime2.count, 3);
        
        expect(sampleInventory.getPrime(11), isNull);
      });

      test('should check prime availability', () {
        expect(sampleInventory.hasPrime(2), true);
        expect(sampleInventory.hasPrime(5), true);
        expect(sampleInventory.hasPrime(11), false);
        
        expect(sampleInventory.isPrimeAvailable(2), true);
        expect(sampleInventory.isPrimeAvailable(5), false); // Count is 0
        expect(sampleInventory.isPrimeAvailable(11), false);
      });

      test('should get primes for specific attacks', () {
        final attacksFor12 = sampleInventory.getPrimesForAttack(12);
        expect(attacksFor12.map((p) => p.value), containsAll([2, 3]));
        expect(attacksFor12.map((p) => p.value), isNot(contains(7)));
        
        final attacksFor35 = sampleInventory.getPrimesForAttack(35);
        expect(attacksFor35.map((p) => p.value), contains(7));
        expect(attacksFor35.length, 1);
      });
    });

    group('addPrime', () {
      test('should add new prime to empty inventory', () {
        final newPrime = Prime(
          value: 11,
          count: 2,
          firstObtained: DateTime.now(),
        );
        
        final updated = emptyInventory.addPrime(newPrime);
        
        expect(updated.uniqueCount, 1);
        expect(updated.totalCount, 2);
        expect(updated.getPrime(11), isNotNull);
      });

      test('should increase count for existing prime', () {
        final additionalPrime2 = Prime(
          value: 2,
          count: 2,
          firstObtained: DateTime.now(),
        );
        
        final updated = sampleInventory.addPrime(additionalPrime2);
        
        final prime2 = updated.getPrime(2);
        expect(prime2!.count, 5); // 3 + 2
        expect(updated.uniqueCount, 4); // Same number of unique primes
      });

      test('should respect count limits for small primes', () {
        // Small prime (2) should be limited to 5
        final tooManyPrime2 = Prime(
          value: 2,
          count: 10,
          firstObtained: DateTime.now(),
        );
        
        final updated = sampleInventory.addPrime(tooManyPrime2);
        final prime2 = updated.getPrime(2);
        
        expect(prime2!.count, 5); // Should be clamped to max
      });

      test('should respect count limits for large primes', () {
        // Large prime (13) should be limited to 1
        final largePrime = Prime(
          value: 13,
          count: 3,
          firstObtained: DateTime.now(),
        );
        
        final updated = sampleInventory.addPrime(largePrime);
        final prime13 = updated.getPrime(13);
        
        expect(prime13!.count, 1); // Should be clamped to max for large primes
      });
    });

    group('usePrime', () {
      test('should decrease count and increase usage', () {
        final primeToUse = sampleInventory.getPrime(2)!;
        final updated = sampleInventory.usePrime(primeToUse);
        
        final updatedPrime2 = updated.getPrime(2);
        expect(updatedPrime2!.count, 2); // 3 - 1
        expect(updatedPrime2.usageCount, 6); // 5 + 1
      });

      test('should remove prime when count reaches zero', () {
        final primeToUse = sampleInventory.getPrime(7)!;
        final updated = sampleInventory.usePrime(primeToUse);
        
        expect(updated.getPrime(7), isNull);
        expect(updated.uniqueCount, 3);
      });

      test('should throw error when using unavailable prime', () {
        final unavailablePrime = sampleInventory.getPrime(5)!;
        
        expect(
          () => sampleInventory.usePrime(unavailablePrime),
          throwsStateError,
        );
      });

      test('should throw error when using non-existent prime', () {
        final nonExistentPrime = Prime(
          value: 11,
          count: 1,
          firstObtained: DateTime.now(),
        );
        
        expect(
          () => sampleInventory.usePrime(nonExistentPrime),
          throwsStateError,
        );
      });
    });

    group('removePrime', () {
      test('should remove prime completely', () {
        final updated = sampleInventory.removePrime(2);
        
        expect(updated.getPrime(2), isNull);
        expect(updated.uniqueCount, 3);
        expect(updated.totalCount, 3); // 2 + 0 + 1
      });

      test('should handle removal of non-existent prime', () {
        final updated = sampleInventory.removePrime(11);
        
        expect(updated.uniqueCount, 4);
        expect(updated.totalCount, 6);
      });
    });

    group('Sorting', () {
      test('should sort by value', () {
        final sorted = sampleInventory.sortedByValue;
        final values = sorted.map((p) => p.value).toList();
        
        expect(values, [2, 3, 5, 7]);
      });

      test('should sort by count (highest first)', () {
        final sorted = sampleInventory.sortedByCount;
        final counts = sorted.map((p) => p.count).toList();
        
        expect(counts, [3, 2, 1, 0]);
      });

      test('should sort by usage (highest first)', () {
        final sorted = sampleInventory.sortedByUsage;
        final usages = sorted.map((p) => p.usageCount).toList();
        
        expect(usages, [5, 3, 1, 0]);
      });
    });

    group('Statistics', () {
      test('should generate correct stats', () {
        final stats = sampleInventory.stats;
        
        expect(stats.totalPrimes, 6);
        expect(stats.uniquePrimes, 4);
        expect(stats.smallPrimes, 3); // 2, 3, 5, 7 (all <= 10)
        expect(stats.largePrimes, 1); // None in this sample
        expect(stats.mostUsedPrime?.value, 2);
        expect(stats.averageUsage, 2.25); // (5 + 3 + 1 + 0) / 4
      });

      test('should handle empty inventory stats', () {
        final stats = emptyInventory.stats;
        
        expect(stats.totalPrimes, 0);
        expect(stats.uniquePrimes, 0);
        expect(stats.smallPrimes, 0);
        expect(stats.largePrimes, 0);
        expect(stats.mostUsedPrime, isNull);
        expect(stats.averageUsage, 0.0);
      });
    });
  });
}