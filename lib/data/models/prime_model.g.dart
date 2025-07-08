// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrimeModelImpl _$$PrimeModelImplFromJson(Map<String, dynamic> json) =>
    _$PrimeModelImpl(
      value: (json['value'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      firstObtained: DateTime.parse(json['firstObtained'] as String),
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PrimeModelImplToJson(_$PrimeModelImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'count': instance.count,
      'firstObtained': instance.firstObtained.toIso8601String(),
      'usageCount': instance.usageCount,
    };
