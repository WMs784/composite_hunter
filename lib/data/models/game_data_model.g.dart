// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameDataModelImpl _$$GameDataModelImplFromJson(Map<String, dynamic> json) =>
    _$GameDataModelImpl(
      playerLevel: (json['playerLevel'] as num?)?.toInt() ?? 1,
      experience: (json['experience'] as num?)?.toInt() ?? 0,
      totalBattles: (json['totalBattles'] as num?)?.toInt() ?? 0,
      totalVictories: (json['totalVictories'] as num?)?.toInt() ?? 0,
      totalEscapes: (json['totalEscapes'] as num?)?.toInt() ?? 0,
      totalTimeOuts: (json['totalTimeOuts'] as num?)?.toInt() ?? 0,
      totalPowerEnemiesDefeated:
          (json['totalPowerEnemiesDefeated'] as num?)?.toInt() ?? 0,
      inventory: (json['inventory'] as List<dynamic>?)
              ?.map((e) => PrimeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      battleHistory: (json['battleHistory'] as List<dynamic>?)
              ?.map(
                  (e) => BattleResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tutorialCompleted: json['tutorialCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastPlayedAt: DateTime.parse(json['lastPlayedAt'] as String),
    );

Map<String, dynamic> _$$GameDataModelImplToJson(_$GameDataModelImpl instance) =>
    <String, dynamic>{
      'playerLevel': instance.playerLevel,
      'experience': instance.experience,
      'totalBattles': instance.totalBattles,
      'totalVictories': instance.totalVictories,
      'totalEscapes': instance.totalEscapes,
      'totalTimeOuts': instance.totalTimeOuts,
      'totalPowerEnemiesDefeated': instance.totalPowerEnemiesDefeated,
      'inventory': instance.inventory,
      'battleHistory': instance.battleHistory,
      'tutorialCompleted': instance.tutorialCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastPlayedAt': instance.lastPlayedAt.toIso8601String(),
    };
