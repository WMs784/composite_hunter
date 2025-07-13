extension IntExtensions on int {
  /// Check if the number is prime
  bool get isPrime {
    if (this < 2) return false;
    if (this == 2) return true;
    if (this % 2 == 0) return false;

    for (int i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }

  /// Get prime factors of the number
  List<int> get primeFactors {
    final factors = <int>[];
    int n = this;

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

  /// Check if the number is a power of a prime
  bool get isPowerOfPrime {
    final factors = primeFactors;
    if (factors.isEmpty) return false;

    final firstFactor = factors.first;
    return factors.every((factor) => factor == firstFactor) &&
        factors.length > 1;
  }

  /// Get the base and exponent if this is a power of prime
  ({int base, int exponent})? get powerInfo {
    if (!isPowerOfPrime) return null;

    final factors = primeFactors;
    return (base: factors.first, exponent: factors.length);
  }
}
