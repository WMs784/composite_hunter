import 'package:freezed_annotation/freezed_annotation.dart';
import 'prime_model.dart';
import 'battle_result_model.dart';

part 'game_data_model.freezed.dart';
part 'game_data_model.g.dart';

@freezed
class GameDataModel with _$GameDataModel {
  const factory GameDataModel({
    @Default(1) int playerLevel,
    @Default(0) int experience,
    @Default(0) int totalBattles,
    @Default(0) int totalVictories,
    @Default(0) int totalEscapes,
    @Default(0) int totalTimeOuts,
    @Default(0) int totalPowerEnemiesDefeated,
    @Default([]) List<PrimeModel> inventory,
    @Default([]) List<BattleResultModel> battleHistory,
    @Default(false) bool tutorialCompleted,
    required DateTime createdAt,
    required DateTime lastPlayedAt,
  }) = _GameDataModel;

  factory GameDataModel.fromJson(Map<String, dynamic> json) =>
      _$GameDataModelFromJson(json);
}