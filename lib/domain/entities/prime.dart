import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/math_utils.dart';

part 'prime.freezed.dart';

@freezed
class Item with _$Item {
  const factory Item({
    required int value,
    required int count,
    required DateTime firstObtained,
    @Default(0) int usageCount,
  }) = _Item;

  const Item._();

  /// Check if the value is actually prime
  bool get isPrime => MathUtils.isPrime(value);

  /// Check if this item is available for use
  bool get isAvailable => count > 0;

  /// Check if this item is empty
  bool get isEmpty => count == 0;

  /// Create a copy with updated count
  Item increaseCount([int amount = 1]) {
    return copyWith(count: count + amount);
  }

  /// Create a copy with decreased count
  Item decreaseCount([int amount = 1]) {
    if (count < amount) {
      throw StateError('Cannot decrease count below zero');
    }
    return copyWith(count: count - amount);
  }

  /// Create a copy with increased usage count
  Item increaseUsage([int amount = 1]) {
    return copyWith(usageCount: usageCount + amount);
  }

  /// Consume items and return new item
  Item consume(int amount) {
    final newCount = (count - amount).clamp(0, double.infinity).toInt();
    return copyWith(count: newCount);
  }

  /// Add items and return new item
  Item add(int amount) {
    return copyWith(count: count + amount);
  }

  /// Check if this is a small prime (for inventory limits)
  bool get isSmallPrime => value <= 10;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Item($value x$count)';
}

/// 後方互換性のためのエイリアス
typedef Prime = Item;
