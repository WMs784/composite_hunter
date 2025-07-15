import 'package:freezed_annotation/freezed_annotation.dart';
import 'prime.dart';
import 'stage.dart';

part 'battle_loadout.freezed.dart';

@freezed
class BattleLoadout with _$BattleLoadout {
  const factory BattleLoadout({
    required List<Item> battleItems,
    required List<Item> originalItems,
    required int maxSlots,
    required Stage targetStage,
    required DateTime createdAt,
  }) = _BattleLoadout;

  const BattleLoadout._();

  /// Check if the loadout is full
  bool get isFull => totalItemCount >= maxSlots;

  /// Check if the loadout is empty
  bool get isEmpty => battleItems.isEmpty;

  /// Check if the battle can continue
  bool get canContinueBattle => battleItems.any((item) => item.isAvailable);

  /// Get remaining slots
  int get remainingSlots => maxSlots - totalItemCount;

  /// Get total item count
  int get totalItemCount =>
      battleItems.fold(0, (sum, item) => sum + item.count);

  /// Use an item and return new loadout
  BattleLoadout useItem(Item item) {
    final updatedItems = battleItems.map((battleItem) {
      if (battleItem.value == item.value) {
        return battleItem.consume(1);
      }
      return battleItem;
    }).toList();

    return copyWith(battleItems: updatedItems);
  }

  /// Check if an item can be used
  bool canUseItem(Item item) {
    final battleItem = battleItems.firstWhere(
      (battleItem) => battleItem.value == item.value,
      orElse: () =>
          Item(value: item.value, count: 0, firstObtained: DateTime.now()),
    );
    return battleItem.isAvailable;
  }

  /// Get remaining count for a specific item
  int getRemainingCount(int itemValue) {
    final battleItem = battleItems.firstWhere(
      (battleItem) => battleItem.value == itemValue,
      orElse: () =>
          Item(value: itemValue, count: 0, firstObtained: DateTime.now()),
    );
    return battleItem.count;
  }
}
