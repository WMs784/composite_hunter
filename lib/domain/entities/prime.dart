import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/math_utils.dart';

part 'prime.freezed.dart';

@freezed
class Prime with _$Prime {
  const factory Prime({
    required int value,
    required int count,
    required DateTime firstObtained,
    @Default(0) int usageCount,
  }) = _Prime;

  const Prime._();

  /// Check if the value is actually prime
  bool get isPrime => MathUtils.isPrime(value);

  /// Create a copy with updated count
  Prime increaseCount([int amount = 1]) {
    return copyWith(count: count + amount);
  }

  /// Create a copy with decreased count
  Prime decreaseCount([int amount = 1]) {
    if (count < amount) {
      throw StateError('Cannot decrease count below zero');
    }
    return copyWith(count: count - amount);
  }

  /// Create a copy with increased usage count
  Prime increaseUsage([int amount = 1]) {
    return copyWith(usageCount: usageCount + amount);
  }

  /// Check if this prime is available for use
  bool get isAvailable => count > 0;

  /// Check if this is a small prime (for inventory limits)
  bool get isSmallPrime => value <= 10;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Prime && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Prime($value x$count)';
}
