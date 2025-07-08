// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnemyModelImpl _$$EnemyModelImplFromJson(Map<String, dynamic> json) =>
    _$EnemyModelImpl(
      currentValue: (json['currentValue'] as num).toInt(),
      originalValue: (json['originalValue'] as num).toInt(),
      type: $enumDecode(_$EnemyTypeEnumMap, json['type']),
      primeFactors: (json['primeFactors'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      isPowerEnemy: json['isPowerEnemy'] as bool? ?? false,
      powerBase: (json['powerBase'] as num?)?.toInt(),
      powerExponent: (json['powerExponent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EnemyModelImplToJson(_$EnemyModelImpl instance) =>
    <String, dynamic>{
      'currentValue': instance.currentValue,
      'originalValue': instance.originalValue,
      'type': _$EnemyTypeEnumMap[instance.type]!,
      'primeFactors': instance.primeFactors,
      'isPowerEnemy': instance.isPowerEnemy,
      'powerBase': instance.powerBase,
      'powerExponent': instance.powerExponent,
    };

const _$EnemyTypeEnumMap = {
  EnemyType.small: 'small',
  EnemyType.medium: 'medium',
  EnemyType.large: 'large',
  EnemyType.power: 'power',
  EnemyType.special: 'special',
};
