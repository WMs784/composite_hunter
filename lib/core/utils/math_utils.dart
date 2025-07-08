import 'dart:math' as math;

class MathUtils {
  /// Generate primes up to n using Sieve of Eratosthenes
  static List<int> sieveOfEratosthenes(int n) {
    if (n < 2) return [];
    
    final isPrime = List.filled(n + 1, true);
    isPrime[0] = isPrime[1] = false;
    
    for (int i = 2; i * i <= n; i++) {
      if (isPrime[i]) {
        for (int j = i * i; j <= n; j += i) {
          isPrime[j] = false;
        }
      }
    }
    
    return [
      for (int i = 2; i <= n; i++)
        if (isPrime[i]) i
    ];
  }
  
  /// Check if a number is prime (optimized for large numbers)
  static bool isPrime(int n) {
    if (n < 2) return false;
    if (n == 2 || n == 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    
    for (int i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    return true;
  }
  
  /// Get prime factorization of a number
  static List<int> factorize(int n) {
    final factors = <int>[];
    
    // Handle 2 separately
    while (n % 2 == 0) {
      factors.add(2);
      n ~/= 2;
    }
    
    // Handle odd factors
    for (int i = 3; i * i <= n; i += 2) {
      while (n % i == 0) {
        factors.add(i);
        n ~/= i;
      }
    }
    
    // If n is still greater than 2, it's a prime
    if (n > 2) {
      factors.add(n);
    }
    
    return factors;
  }
  
  /// Calculate greatest common divisor
  static int gcd(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }
  
  /// Calculate least common multiple
  static int lcm(int a, int b) {
    return (a * b) ~/ gcd(a, b);
  }
  
  /// Generate a composite number with specified prime factors
  static int generateComposite(List<int> primeFactors) {
    if (primeFactors.isEmpty) return 1;
    return primeFactors.reduce((a, b) => a * b);
  }
  
  /// Check if a number is a perfect power
  static bool isPerfectPower(int n) {
    if (n < 2) return false;
    
    for (int exp = 2; exp <= (math.log(n) / math.log(2)).floor(); exp++) {
      final base = math.pow(n, 1.0 / exp).round();
      if (math.pow(base, exp).round() == n) {
        return true;
      }
    }
    return false;
  }
  
  /// Get the difficulty rating for a number based on its size and complexity
  static int getDifficulty(int n) {
    final factors = factorize(n);
    final uniqueFactors = factors.toSet().length;
    
    // Base difficulty from number size
    int difficulty = 0;
    if (n <= 20) difficulty = 1;
    else if (n <= 100) difficulty = 2;
    else if (n <= 1000) difficulty = 3;
    else difficulty = 4;
    
    // Increase difficulty based on number of unique factors
    difficulty += uniqueFactors;
    
    return difficulty;
  }
}