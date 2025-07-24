// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VictoryImpl _$$VictoryImplFromJson(Map<String, dynamic> json) =>
    _$VictoryImpl(
      defeatedEnemy: EnemyModel.fromJson(
        json['defeatedEnemy'] as Map<String, dynamic>,
      ),
      rewardPrime: (json['rewardPrime'] as num).toInt(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      battleDuration: (json['battleDuration'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$VictoryImplToJson(_$VictoryImpl instance) =>
    <String, dynamic>{
      'defeatedEnemy': instance.defeatedEnemy,
      'rewardPrime': instance.rewardPrime,
      'completedAt': instance.completedAt.toIso8601String(),
      'battleDuration': instance.battleDuration,
      'runtimeType': instance.$type,
    };

_$PowerVictoryImpl _$$PowerVictoryImplFromJson(Map<String, dynamic> json) =>
    _$PowerVictoryImpl(
      defeatedEnemy: EnemyModel.fromJson(
        json['defeatedEnemy'] as Map<String, dynamic>,
      ),
      rewardPrime: (json['rewardPrime'] as num).toInt(),
      rewardCount: (json['rewardCount'] as num).toInt(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      battleDuration: (json['battleDuration'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PowerVictoryImplToJson(_$PowerVictoryImpl instance) =>
    <String, dynamic>{
      'defeatedEnemy': instance.defeatedEnemy,
      'rewardPrime': instance.rewardPrime,
      'rewardCount': instance.rewardCount,
      'completedAt': instance.completedAt.toIso8601String(),
      'battleDuration': instance.battleDuration,
      'runtimeType': instance.$type,
    };

_$ContinueImpl _$$ContinueImplFromJson(Map<String, dynamic> json) =>
    _$ContinueImpl(
      newEnemy: EnemyModel.fromJson(json['newEnemy'] as Map<String, dynamic>),
      usedPrime: PrimeModel.fromJson(json['usedPrime'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ContinueImplToJson(_$ContinueImpl instance) =>
    <String, dynamic>{
      'newEnemy': instance.newEnemy,
      'usedPrime': instance.usedPrime,
      'runtimeType': instance.$type,
    };

_$AwaitingVictoryClaimImpl _$$AwaitingVictoryClaimImplFromJson(
  Map<String, dynamic> json,
) => _$AwaitingVictoryClaimImpl(
  newEnemy: EnemyModel.fromJson(json['newEnemy'] as Map<String, dynamic>),
  usedPrime: PrimeModel.fromJson(json['usedPrime'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$AwaitingVictoryClaimImplToJson(
  _$AwaitingVictoryClaimImpl instance,
) => <String, dynamic>{
  'newEnemy': instance.newEnemy,
  'usedPrime': instance.usedPrime,
  'runtimeType': instance.$type,
};

_$WrongClaimImpl _$$WrongClaimImplFromJson(Map<String, dynamic> json) =>
    _$WrongClaimImpl(
      penalty: PenaltyRecordModel.fromJson(
        json['penalty'] as Map<String, dynamic>,
      ),
      currentEnemy: EnemyModel.fromJson(
        json['currentEnemy'] as Map<String, dynamic>,
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WrongClaimImplToJson(_$WrongClaimImpl instance) =>
    <String, dynamic>{
      'penalty': instance.penalty,
      'currentEnemy': instance.currentEnemy,
      'runtimeType': instance.$type,
    };

_$EscapeImpl _$$EscapeImplFromJson(Map<String, dynamic> json) => _$EscapeImpl(
  penalty: PenaltyRecordModel.fromJson(json['penalty'] as Map<String, dynamic>),
  escapedAt: DateTime.parse(json['escapedAt'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$EscapeImplToJson(_$EscapeImpl instance) =>
    <String, dynamic>{
      'penalty': instance.penalty,
      'escapedAt': instance.escapedAt.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$TimeOutImpl _$$TimeOutImplFromJson(Map<String, dynamic> json) =>
    _$TimeOutImpl(
      penalty: PenaltyRecordModel.fromJson(
        json['penalty'] as Map<String, dynamic>,
      ),
      timedOutAt: DateTime.parse(json['timedOutAt'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TimeOutImplToJson(_$TimeOutImpl instance) =>
    <String, dynamic>{
      'penalty': instance.penalty,
      'timedOutAt': instance.timedOutAt.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
  message: json['message'] as String,
  details: json['details'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'details': instance.details,
      'runtimeType': instance.$type,
    };
