import 'package:freezed_annotation/freezed_annotation.dart';

part 'enemy_model.freezed.dart';
part 'enemy_model.g.dart';

@freezed
class EnemyModel with _$EnemyModel {
  const factory EnemyModel({
    required int currentValue,
    required int originalValue,
    required EnemyType type,
    required List<int> primeFactors,
    @Default(false) bool isPowerEnemy,
    int? powerBase,
    int? powerExponent,
  }) = _EnemyModel;

  factory EnemyModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyModelFromJson(json);
}

enum EnemyType {
  @JsonValue('small')
  small,
  @JsonValue('medium')
  medium,
  @JsonValue('large')
  large,
  @JsonValue('power')
  power,
  @JsonValue('special')
  special,
}
