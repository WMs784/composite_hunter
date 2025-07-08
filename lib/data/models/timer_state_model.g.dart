// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimerStateModelImpl _$$TimerStateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TimerStateModelImpl(
      remainingSeconds: (json['remainingSeconds'] as num).toInt(),
      originalSeconds: (json['originalSeconds'] as num).toInt(),
      isActive: json['isActive'] as bool? ?? false,
      isWarning: json['isWarning'] as bool? ?? false,
      penalties: (json['penalties'] as List<dynamic>?)
              ?.map(
                  (e) => PenaltyRecordModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TimerStateModelImplToJson(
        _$TimerStateModelImpl instance) =>
    <String, dynamic>{
      'remainingSeconds': instance.remainingSeconds,
      'originalSeconds': instance.originalSeconds,
      'isActive': instance.isActive,
      'isWarning': instance.isWarning,
      'penalties': instance.penalties,
    };
