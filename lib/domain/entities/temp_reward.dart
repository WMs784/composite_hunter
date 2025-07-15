import 'package:freezed_annotation/freezed_annotation.dart';
import 'prime.dart';

part 'temp_reward.freezed.dart';

@freezed
class TempReward with _$TempReward {
  const factory TempReward({
    required List<Item> tempItems,
    required DateTime battleStartTime,
    @Default(false) bool isFinalized,
  }) = _TempReward;

  const TempReward._();

  /// Add a temporary item
  TempReward addTempItem(Item item) {
    final existingIndex =
        tempItems.indexWhere((tempItem) => tempItem.value == item.value);

    if (existingIndex >= 0) {
      // Update existing item
      final updatedItems = tempItems.map((tempItem) {
        if (tempItem.value == item.value) {
          return tempItem.add(item.count);
        }
        return tempItem;
      }).toList();
      return copyWith(tempItems: updatedItems);
    } else {
      // Add new item
      return copyWith(tempItems: [...tempItems, item]);
    }
  }

  /// Finalize the temporary rewards
  TempReward finalize() {
    return copyWith(isFinalized: true);
  }

  /// Discard the temporary rewards
  TempReward discard() {
    return copyWith(
      tempItems: [],
      isFinalized: false,
    );
  }

  /// Get total count of temporary items
  int get totalTempItems => tempItems.fold(0, (sum, item) => sum + item.count);

  /// Check if there are temporary rewards
  bool get hasTempRewards => tempItems.isNotEmpty;
}
