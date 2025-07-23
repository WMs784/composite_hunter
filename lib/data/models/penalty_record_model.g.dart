// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penalty_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PenaltyRecordModelImpl _$$PenaltyRecordModelImplFromJson(
  Map<String, dynamic> json,
) => _$PenaltyRecordModelImpl(
  seconds: (json['seconds'] as num).toInt(),
  type: $enumDecode(_$PenaltyTypeEnumMap, json['type']),
  appliedAt: DateTime.parse(json['appliedAt'] as String),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$$PenaltyRecordModelImplToJson(
  _$PenaltyRecordModelImpl instance,
) => <String, dynamic>{
  'seconds': instance.seconds,
  'type': _$PenaltyTypeEnumMap[instance.type]!,
  'appliedAt': instance.appliedAt.toIso8601String(),
  'reason': instance.reason,
};

const _$PenaltyTypeEnumMap = {
  PenaltyType.escape: 'escape',
  PenaltyType.wrongVictoryClaim: 'wrong_victory_claim',
  PenaltyType.timeOut: 'time_out',
};
