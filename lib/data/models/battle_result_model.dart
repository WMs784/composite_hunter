import 'package:freezed_annotation/freezed_annotation.dart';
import 'enemy_model.dart';
import 'prime_model.dart';
import 'penalty_record_model.dart';

part 'battle_result_model.freezed.dart';
part 'battle_result_model.g.dart';

@freezed
class BattleResultModel with _$BattleResultModel {
  const factory BattleResultModel.victory({
    required EnemyModel defeatedEnemy,
    required int rewardPrime,
    required DateTime completedAt,
    required int battleDuration,
  }) = _Victory;

  const factory BattleResultModel.powerVictory({
    required EnemyModel defeatedEnemy,
    required int rewardPrime,
    required int rewardCount,
    required DateTime completedAt,
    required int battleDuration,
  }) = _PowerVictory;

  const factory BattleResultModel.continue_({
    required EnemyModel newEnemy,
    required PrimeModel usedPrime,
  }) = _Continue;

  const factory BattleResultModel.awaitingVictoryClaim({
    required EnemyModel newEnemy,
    required PrimeModel usedPrime,
  }) = _AwaitingVictoryClaim;

  const factory BattleResultModel.wrongClaim({
    required PenaltyRecordModel penalty,
    required EnemyModel currentEnemy,
  }) = _WrongClaim;

  const factory BattleResultModel.escape({
    required PenaltyRecordModel penalty,
    required DateTime escapedAt,
  }) = _Escape;

  const factory BattleResultModel.timeOut({
    required PenaltyRecordModel penalty,
    required DateTime timedOutAt,
  }) = _TimeOut;

  const factory BattleResultModel.error({
    required String message,
    String? details,
  }) = _Error;

  factory BattleResultModel.fromJson(Map<String, dynamic> json) =>
      _$BattleResultModelFromJson(json);
}
