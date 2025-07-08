import '../models/prime_model.dart';
import '../models/enemy_model.dart';
import '../models/battle_result_model.dart';
import '../models/timer_state_model.dart';
import '../models/penalty_record_model.dart';
import '../models/game_data_model.dart';
import '../../domain/entities/prime.dart';
import '../../domain/entities/enemy.dart';
import '../../domain/entities/timer_state.dart';
import '../../domain/entities/penalty_state.dart';
import '../../domain/entities/battle_state.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/services/battle_engine.dart';

/// Mapper between data models and domain entities
class GameMapper {
  
  // Prime mappings
  Prime primeModelToDomain(PrimeModel model) {
    return Prime(
      value: model.value,
      count: model.count,
      firstObtained: model.firstObtained,
      usageCount: model.usageCount,
    );
  }

  PrimeModel primeToModel(Prime prime) {
    return PrimeModel(
      value: prime.value,
      count: prime.count,
      firstObtained: prime.firstObtained,
      usageCount: prime.usageCount,
    );
  }

  // Enemy mappings
  Enemy enemyModelToDomain(EnemyModel model) {
    return Enemy(
      currentValue: model.currentValue,
      originalValue: model.originalValue,
      type: _mapEnemyType(model.type),
      primeFactors: model.primeFactors,
      isPowerEnemy: model.isPowerEnemy,
      powerBase: model.powerBase,
      powerExponent: model.powerExponent,
    );
  }

  EnemyModel enemyToModel(Enemy enemy) {
    return EnemyModel(
      currentValue: enemy.currentValue,
      originalValue: enemy.originalValue,
      type: _mapEnemyTypeToModel(enemy.type),
      primeFactors: enemy.primeFactors,
      isPowerEnemy: enemy.isPowerEnemy,
      powerBase: enemy.powerBase,
      powerExponent: enemy.powerExponent,
    );
  }

  // Timer state mappings
  TimerState timerStateModelToDomain(TimerStateModel model) {
    final penalties = model.penalties
        .map((p) => TimePenalty(
              seconds: p.seconds,
              type: _mapPenaltyType(p.type),
              appliedAt: p.appliedAt,
              reason: p.reason,
            ))
        .toList();

    return TimerState(
      remainingSeconds: model.remainingSeconds,
      originalSeconds: model.originalSeconds,
      isActive: model.isActive,
      isWarning: model.isWarning,
      penalties: penalties,
    );
  }

  TimerStateModel timerStateToModel(TimerState state) {
    final penalties = state.penalties
        .map((p) => PenaltyRecordModel(
              seconds: p.seconds,
              type: _mapPenaltyTypeToModel(p.type),
              appliedAt: p.appliedAt,
              reason: p.reason,
            ))
        .toList();

    return TimerStateModel(
      remainingSeconds: state.remainingSeconds,
      originalSeconds: state.originalSeconds,
      isActive: state.isActive,
      isWarning: state.isWarning,
      penalties: penalties,
    );
  }

  // Battle result mappings
  BattleResult battleResultModelToDomain(BattleResultModel model) {
    return model.when(
      victory: (enemy, reward, completedAt, duration) => BattleResult.victory(
        defeatedEnemy: enemyModelToDomain(enemy),
        rewardPrime: reward,
        victoryClaim: VictoryClaim.correct(claimedValue: reward, claimedAt: completedAt),
      ),
      powerVictory: (enemy, reward, count, completedAt, duration) => BattleResult.powerVictory(
        defeatedEnemy: enemyModelToDomain(enemy),
        rewardPrime: reward,
        rewardCount: count,
        victoryClaim: VictoryClaim.correct(claimedValue: reward, claimedAt: completedAt),
      ),
      continue_: (enemy, prime) => BattleResult.continue_(
        newEnemy: enemyModelToDomain(enemy),
        usedPrime: primeModelToDomain(prime),
      ),
      awaitingVictoryClaim: (enemy, prime) => BattleResult.awaitingVictoryClaim(
        newEnemy: enemyModelToDomain(enemy),
        usedPrime: primeModelToDomain(prime),
      ),
      wrongClaim: (penalty, enemy) => BattleResult.wrongClaim(
        penalty: TimePenalty(
          seconds: penalty.seconds,
          type: _mapPenaltyType(penalty.type),
          appliedAt: penalty.appliedAt,
          reason: penalty.reason,
        ),
        currentEnemy: enemyModelToDomain(enemy),
        victoryClaim: VictoryClaim.incorrect(claimedValue: enemy.currentValue),
      ),
      escape: (penalty, escapedAt) => BattleResult.escape(
        penalty: TimePenalty(
          seconds: penalty.seconds,
          type: _mapPenaltyType(penalty.type),
          appliedAt: penalty.appliedAt,
          reason: penalty.reason,
        ),
      ),
      timeOut: (penalty, timedOutAt) => BattleResult.timeOut(
        penalty: TimePenalty(
          seconds: penalty.seconds,
          type: _mapPenaltyType(penalty.type),
          appliedAt: penalty.appliedAt,
          reason: penalty.reason,
        ),
      ),
      error: (message, details) => BattleResult.error(message),
    );
  }

  BattleResultModel battleResultToModel(BattleResult result) {
    return result.when(
      victory: (enemy, reward, claim) => BattleResultModel.victory(
        defeatedEnemy: enemyToModel(enemy),
        rewardPrime: reward,
        completedAt: claim.claimedAt,
        battleDuration: 0, // Duration would need to be tracked separately
      ),
      powerVictory: (enemy, reward, count, claim) => BattleResultModel.powerVictory(
        defeatedEnemy: enemyToModel(enemy),
        rewardPrime: reward,
        rewardCount: count,
        completedAt: claim.claimedAt,
        battleDuration: 0,
      ),
      continue_: (enemy, prime) => BattleResultModel.continue_(
        newEnemy: enemyToModel(enemy),
        usedPrime: primeToModel(prime),
      ),
      awaitingVictoryClaim: (enemy, prime) => BattleResultModel.awaitingVictoryClaim(
        newEnemy: enemyToModel(enemy),
        usedPrime: primeToModel(prime),
      ),
      wrongClaim: (penalty, enemy, claim) => BattleResultModel.wrongClaim(
        penalty: PenaltyRecordModel(
          seconds: penalty.seconds,
          type: _mapPenaltyTypeToModel(penalty.type),
          appliedAt: penalty.appliedAt,
          reason: penalty.reason,
        ),
        currentEnemy: enemyToModel(enemy),
      ),
      escape: (penalty) => BattleResultModel.escape(
        penalty: PenaltyRecordModel(
          seconds: penalty.seconds,
          type: _mapPenaltyTypeToModel(penalty.type),
          appliedAt: penalty.appliedAt,
          reason: penalty.reason,
        ),
        escapedAt: penalty.appliedAt,
      ),
      timeOut: (penalty) => BattleResultModel.timeOut(
        penalty: PenaltyRecordModel(
          seconds: penalty.seconds,
          type: _mapPenaltyTypeToModel(penalty.type),
          appliedAt: penalty.appliedAt,
          reason: penalty.reason,
        ),
        timedOutAt: penalty.appliedAt,
      ),
      error: (message) => BattleResultModel.error(
        message: message,
        details: null,
      ),
    );
  }

  // Inventory mappings
  Inventory inventoryFromModels(List<PrimeModel> primeModels) {
    final primes = primeModels.map(primeModelToDomain).toList();
    return Inventory(primes: primes);
  }

  List<PrimeModel> inventoryToModels(Inventory inventory) {
    return inventory.primes.map(primeToModel).toList();
  }

  // Game data mappings
  GameDataModel gameDataToModel({
    required int playerLevel,
    required int experience,
    required int totalBattles,
    required int totalVictories,
    required int totalEscapes,
    required int totalTimeOuts,
    required int totalPowerEnemiesDefeated,
    required List<Prime> inventory,
    required List<BattleResult> battleHistory,
    required bool tutorialCompleted,
    required DateTime createdAt,
    required DateTime lastPlayedAt,
  }) {
    return GameDataModel(
      playerLevel: playerLevel,
      experience: experience,
      totalBattles: totalBattles,
      totalVictories: totalVictories,
      totalEscapes: totalEscapes,
      totalTimeOuts: totalTimeOuts,
      totalPowerEnemiesDefeated: totalPowerEnemiesDefeated,
      inventory: inventory.map(primeToModel).toList(),
      battleHistory: battleHistory.map(battleResultToModel).toList(),
      tutorialCompleted: tutorialCompleted,
      createdAt: createdAt,
      lastPlayedAt: lastPlayedAt,
    );
  }

  // Helper methods for enum mapping
  EnemyType _mapEnemyType(EnemyTypeModel type) {
    switch (type) {
      case EnemyTypeModel.small:
        return EnemyType.small;
      case EnemyTypeModel.medium:
        return EnemyType.medium;
      case EnemyTypeModel.large:
        return EnemyType.large;
      case EnemyTypeModel.power:
        return EnemyType.power;
      case EnemyTypeModel.special:
        return EnemyType.special;
    }
  }

  EnemyTypeModel _mapEnemyTypeToModel(EnemyType type) {
    switch (type) {
      case EnemyType.small:
        return EnemyTypeModel.small;
      case EnemyType.medium:
        return EnemyTypeModel.medium;
      case EnemyType.large:
        return EnemyTypeModel.large;
      case EnemyType.power:
        return EnemyTypeModel.power;
      case EnemyType.special:
        return EnemyTypeModel.special;
    }
  }

  PenaltyType _mapPenaltyType(PenaltyTypeModel type) {
    switch (type) {
      case PenaltyTypeModel.escape:
        return PenaltyType.escape;
      case PenaltyTypeModel.wrongVictoryClaim:
        return PenaltyType.wrongVictoryClaim;
      case PenaltyTypeModel.timeOut:
        return PenaltyType.timeOut;
    }
  }

  PenaltyTypeModel _mapPenaltyTypeToModel(PenaltyType type) {
    switch (type) {
      case PenaltyType.escape:
        return PenaltyTypeModel.escape;
      case PenaltyType.wrongVictoryClaim:
        return PenaltyTypeModel.wrongVictoryClaim;
      case PenaltyType.timeOut:
        return PenaltyTypeModel.timeOut;
    }
  }

  // Battle state mappings (for complex state persistence)
  Map<String, dynamic> battleStateToJson(BattleState state) {
    return {
      'currentEnemy': state.currentEnemy != null ? enemyToModel(state.currentEnemy!).toJson() : null,
      'usedPrimes': state.usedPrimes.map((p) => primeToModel(p).toJson()).toList(),
      'status': state.status.name,
      'turnCount': state.turnCount,
      'battleStartTime': state.battleStartTime?.toIso8601String(),
      'timerState': state.timerState != null ? timerStateToModel(state.timerState!).toJson() : null,
      'victoryClaim': state.victoryClaim != null ? {
        'claimedValue': state.victoryClaim!.claimedValue,
        'claimedAt': state.victoryClaim!.claimedAt.toIso8601String(),
        'isCorrect': state.victoryClaim!.isCorrect,
        'rewardPrime': state.victoryClaim!.rewardPrime,
        'errorMessage': state.victoryClaim!.errorMessage,
      } : null,
      'battlePenalties': state.battlePenalties.map((p) => {
        'seconds': p.seconds,
        'type': p.type.name,
        'appliedAt': p.appliedAt.toIso8601String(),
        'reason': p.reason,
      }).toList(),
    };
  }

  BattleState battleStateFromJson(Map<String, dynamic> json) {
    return BattleState(
      currentEnemy: json['currentEnemy'] != null 
          ? enemyModelToDomain(EnemyModel.fromJson(json['currentEnemy']))
          : null,
      usedPrimes: (json['usedPrimes'] as List)
          .map((p) => primeModelToDomain(PrimeModel.fromJson(p)))
          .toList(),
      status: BattleStatus.values.firstWhere((s) => s.name == json['status']),
      turnCount: json['turnCount'] ?? 0,
      battleStartTime: json['battleStartTime'] != null 
          ? DateTime.parse(json['battleStartTime'])
          : null,
      timerState: json['timerState'] != null 
          ? timerStateModelToDomain(TimerStateModel.fromJson(json['timerState']))
          : null,
      victoryClaim: json['victoryClaim'] != null 
          ? VictoryClaim(
              claimedValue: json['victoryClaim']['claimedValue'],
              claimedAt: DateTime.parse(json['victoryClaim']['claimedAt']),
              isCorrect: json['victoryClaim']['isCorrect'],
              rewardPrime: json['victoryClaim']['rewardPrime'],
              errorMessage: json['victoryClaim']['errorMessage'],
            )
          : null,
      battlePenalties: (json['battlePenalties'] as List)
          .map((p) => TimePenalty(
                seconds: p['seconds'],
                type: PenaltyType.values.firstWhere((t) => t.name == p['type']),
                appliedAt: DateTime.parse(p['appliedAt']),
                reason: p['reason'],
              ))
          .toList(),
    );
  }
}

// Add type alias for model enums to avoid confusion
typedef EnemyTypeModel = EnemyType;
typedef PenaltyTypeModel = PenaltyType;