import 'package:flutter_test/flutter_test.dart';
import 'package:composite_hunter/core/utils/math_utils.dart';

void main() {
  group('MathUtils Tests', () {
    group('isPrime', () {
      test('should return false for numbers less than 2', () {
        expect(MathUtils.isPrime(-1), false);
        expect(MathUtils.isPrime(0), false);
        expect(MathUtils.isPrime(1), false);
      });

      test('should return true for small prime numbers', () {
        expect(MathUtils.isPrime(2), true);
        expect(MathUtils.isPrime(3), true);
        expect(MathUtils.isPrime(5), true);
        expect(MathUtils.isPrime(7), true);
        expect(MathUtils.isPrime(11), true);
        expect(MathUtils.isPrime(13), true);
      });

      test('should return false for small composite numbers', () {
        expect(MathUtils.isPrime(4), false);
        expect(MathUtils.isPrime(6), false);
        expect(MathUtils.isPrime(8), false);
        expect(MathUtils.isPrime(9), false);
        expect(MathUtils.isPrime(10), false);
        expect(MathUtils.isPrime(12), false);
      });

      test('should handle larger prime numbers', () {
        expect(MathUtils.isPrime(17), true);
        expect(MathUtils.isPrime(19), true);
        expect(MathUtils.isPrime(23), true);
        expect(MathUtils.isPrime(97), true);
      });

      test('should handle larger composite numbers', () {
        expect(MathUtils.isPrime(15), false);
        expect(MathUtils.isPrime(21), false);
        expect(MathUtils.isPrime(25), false);
        expect(MathUtils.isPrime(100), false);
      });
    });

    group('factorize', () {
      test('should return empty list for numbers less than 2', () {
        expect(MathUtils.factorize(0), isEmpty);
        expect(MathUtils.factorize(1), isEmpty);
      });

      test('should return the number itself for prime numbers', () {
        expect(MathUtils.factorize(2), [2]);
        expect(MathUtils.factorize(3), [3]);
        expect(MathUtils.factorize(5), [5]);
        expect(MathUtils.factorize(7), [7]);
        expect(MathUtils.factorize(11), [11]);
      });

      test('should return correct factorization for composite numbers', () {
        expect(MathUtils.factorize(4), [2, 2]);
        expect(MathUtils.factorize(6), [2, 3]);
        expect(MathUtils.factorize(8), [2, 2, 2]);
        expect(MathUtils.factorize(9), [3, 3]);
        expect(MathUtils.factorize(12), [2, 2, 3]);
        expect(MathUtils.factorize(15), [3, 5]);
        expect(MathUtils.factorize(30), [2, 3, 5]);
      });

      test('should handle larger composite numbers', () {
        expect(MathUtils.factorize(60), [2, 2, 3, 5]);
        expect(MathUtils.factorize(100), [2, 2, 5, 5]);
        expect(MathUtils.factorize(147), [3, 7, 7]);
      });
    });

    group('sieveOfEratosthenes', () {
      test('should return empty list for n < 2', () {
        expect(MathUtils.sieveOfEratosthenes(0), isEmpty);
        expect(MathUtils.sieveOfEratosthenes(1), isEmpty);
      });

      test('should return correct primes for small ranges', () {
        expect(MathUtils.sieveOfEratosthenes(2), [2]);
        expect(MathUtils.sieveOfEratosthenes(10), [2, 3, 5, 7]);
        expect(MathUtils.sieveOfEratosthenes(20), [2, 3, 5, 7, 11, 13, 17, 19]);
      });

      test('should return correct primes for larger ranges', () {
        final primes30 = MathUtils.sieveOfEratosthenes(30);
        expect(primes30, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]);
      });
    });

    group('gcd', () {
      test('should calculate greatest common divisor correctly', () {
        expect(MathUtils.gcd(12, 8), 4);
        expect(MathUtils.gcd(15, 25), 5);
        expect(MathUtils.gcd(7, 13), 1);
        expect(MathUtils.gcd(48, 18), 6);
      });

      test('should handle edge cases', () {
        expect(MathUtils.gcd(0, 5), 5);
        expect(MathUtils.gcd(5, 0), 5);
        expect(MathUtils.gcd(1, 1), 1);
      });
    });

    group('lcm', () {
      test('should calculate least common multiple correctly', () {
        expect(MathUtils.lcm(4, 6), 12);
        expect(MathUtils.lcm(3, 7), 21);
        expect(MathUtils.lcm(12, 8), 24);
        expect(MathUtils.lcm(15, 25), 75);
      });
    });

    group('generateComposite', () {
      test('should return 1 for empty factor list', () {
        expect(MathUtils.generateComposite([]), 1);
      });

      test('should multiply prime factors correctly', () {
        expect(MathUtils.generateComposite([2, 3]), 6);
        expect(MathUtils.generateComposite([2, 2, 3]), 12);
        expect(MathUtils.generateComposite([3, 5, 7]), 105);
      });
    });

    group('getDifficulty', () {
      test('should assign correct difficulty based on number size', () {
        // Small numbers (1-20)
        expect(MathUtils.getDifficulty(6), lessThanOrEqualTo(4));
        expect(MathUtils.getDifficulty(12), lessThanOrEqualTo(4));
        
        // Medium numbers (21-100)
        expect(MathUtils.getDifficulty(30), greaterThan(3));
        expect(MathUtils.getDifficulty(60), greaterThan(3));
        
        // Large numbers (101-1000)
        expect(MathUtils.getDifficulty(200), greaterThan(4));
        
        // Very large numbers (>1000)
        expect(MathUtils.getDifficulty(2000), greaterThan(5));
      });

      test('should increase difficulty with more unique factors', () {
        // 6 = 2 × 3 (2 unique factors)
        final difficulty6 = MathUtils.getDifficulty(6);
        
        // 30 = 2 × 3 × 5 (3 unique factors)
        final difficulty30 = MathUtils.getDifficulty(30);
        
        expect(difficulty30, greaterThan(difficulty6));
      });
    });
  });
}