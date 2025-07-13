import '../../core/utils/math_utils.dart';

/// Prime calculation service implementing efficient algorithms
class PrimeCalculator {
  /// Check if a number is prime using optimized algorithm
  static bool isPrime(int number) {
    return MathUtils.isPrime(number);
  }

  /// Get prime factorization of a number
  static List<int> factorize(int number) {
    return MathUtils.factorize(number);
  }

  /// Generate primes up to n using Sieve of Eratosthenes
  static List<int> sieveOfEratosthenes(int limit) {
    return MathUtils.sieveOfEratosthenes(limit);
  }

  /// Check if a number is a power of a prime (e.g., 8 = 2^3, 9 = 3^2)
  static bool isPowerOfPrime(int number) {
    if (number < 2) return false;

    final factors = factorize(number);
    if (factors.isEmpty || factors.length == 1) return false;

    // Check if all factors are the same
    final firstFactor = factors.first;
    return factors.every((factor) => factor == firstFactor);
  }

  /// Get the base and exponent if number is a power of prime
  static ({int base, int exponent})? getPowerInfo(int number) {
    if (!isPowerOfPrime(number)) return null;

    final factors = factorize(number);
    return (base: factors.first, exponent: factors.length);
  }

  /// Get the next prime number after the given number
  static int getNextPrime(int number) {
    int candidate = number + 1;
    while (!isPrime(candidate)) {
      candidate++;
    }
    return candidate;
  }

  /// Get the previous prime number before the given number
  static int? getPreviousPrime(int number) {
    if (number <= 2) return null;

    int candidate = number - 1;
    while (candidate >= 2) {
      if (isPrime(candidate)) {
        return candidate;
      }
      candidate--;
    }
    return null;
  }

  /// Check if two numbers are coprime (gcd = 1)
  static bool areCoprime(int a, int b) {
    return MathUtils.gcd(a, b) == 1;
  }

  /// Get all prime numbers in a range
  static List<int> getPrimesInRange(int start, int end) {
    if (start > end) return [];

    final primes = <int>[];
    for (int i = start; i <= end; i++) {
      if (isPrime(i)) {
        primes.add(i);
      }
    }
    return primes;
  }

  /// Count the number of prime factors (with repetition)
  static int countPrimeFactors(int number) {
    return factorize(number).length;
  }

  /// Count the number of distinct prime factors
  static int countDistinctPrimeFactors(int number) {
    return factorize(number).toSet().length;
  }

  /// Check if a number is a semiprime (product of exactly two primes)
  static bool isSemiprime(int number) {
    final factors = factorize(number);
    return factors.length == 2;
  }

  /// Get the largest prime factor of a number
  static int? getLargestPrimeFactor(int number) {
    final factors = factorize(number);
    return factors.isEmpty ? null : factors.last;
  }

  /// Get the smallest prime factor of a number
  static int? getSmallestPrimeFactor(int number) {
    final factors = factorize(number);
    return factors.isEmpty ? null : factors.first;
  }

  /// Calculate the sum of prime factors (with repetition)
  static int sumOfPrimeFactors(int number) {
    return factorize(number).fold(0, (sum, factor) => sum + factor);
  }

  /// Calculate the product of distinct prime factors
  static int productOfDistinctPrimeFactors(int number) {
    final distinctFactors = factorize(number).toSet();
    return distinctFactors.fold(1, (product, factor) => product * factor);
  }
}
