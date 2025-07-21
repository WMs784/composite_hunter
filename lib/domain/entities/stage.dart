import 'package:freezed_annotation/freezed_annotation.dart';

part 'stage.freezed.dart';

/// ステージ情報を表すエンティティ
@freezed
class Stage with _$Stage {
  const factory Stage({
    required int stageNumber,
    required String title,
    required String description,
    required int enemyRangeMin,
    required int enemyRangeMax,
    required int timeLimit,
    required StageClearCondition clearCondition,
    required bool isUnlocked,
    required bool isCompleted,
    required int stars,
    required int bestScore,
    required DateTime? completedAt,
  }) = _Stage;
}

/// ステージクリア条件
@freezed
class StageClearCondition with _$StageClearCondition {
  const factory StageClearCondition({
    required int requiredVictories, // 必要勝利数
    required int timeLimit, // 制限時間（秒）
    required int maxEscapes, // 最大逃走回数
    required int maxWrongClaims, // 最大誤判定回数
    required StageClearType clearType, // クリア条件タイプ
  }) = _StageClearCondition;
}

/// ステージクリア条件のタイプ
enum StageClearType {
  /// 指定回数勝利する
  victories,

  /// 連続勝利する
  consecutiveVictories,

  /// 制限時間内に指定回数勝利する
  timedVictories,

  /// パーフェクト（逃走・誤判定なし）で指定回数勝利する
  perfectVictories,
}

/// ステージクリア結果
@freezed
class StageClearResult with _$StageClearResult {
  const factory StageClearResult({
    required int stageNumber,
    required bool isCleared,
    required int stars,
    required int score,
    required int victories,
    required int escapes,
    required int wrongClaims,
    required Duration totalTime,
    required List<int> defeatedEnemies,
    required bool isPerfect,
    required bool isNewRecord,
    @Default([]) List<int> rewardItems, // 獲得した報酬アイテム
  }) = _StageClearResult;
}

/// 星評価の基準
class StarRating {
  /// 星評価を計算する
  static int calculateStars({
    required int victories,
    required int escapes,
    required int wrongClaims,
    required Duration totalTime,
    required Duration timeLimit,
    required bool isPerfect,
  }) {
    int stars = 1; // 基本クリアで1星

    // パーフェクト（逃走・誤判定なし）で+1星
    if (isPerfect) {
      stars++;
    }

    // 制限時間の半分以下でクリアで+1星
    if (totalTime.inSeconds <= timeLimit.inSeconds ~/ 2) {
      stars++;
    }

    return stars.clamp(1, 3);
  }
}

/// ステージ設定
class StageConfig {
  /// ステージ1: 基本の戦闘
  static const stage1 = StageClearCondition(
    requiredVictories: 3,
    timeLimit: 180, // 3分
    maxEscapes: 2,
    maxWrongClaims: 3,
    clearType: StageClearType.victories,
  );

  /// ステージ2: 中級の挑戦
  static const stage2 = StageClearCondition(
    requiredVictories: 5,
    timeLimit: 300, // 5分
    maxEscapes: 2,
    maxWrongClaims: 2,
    clearType: StageClearType.victories,
  );

  /// ステージ3: 上級者への道
  static const stage3 = StageClearCondition(
    requiredVictories: 3,
    timeLimit: 240, // 4分
    maxEscapes: 1,
    maxWrongClaims: 1,
    clearType: StageClearType.consecutiveVictories,
  );

  /// ステージ4: エキスパート
  static const stage4 = StageClearCondition(
    requiredVictories: 5,
    timeLimit: 600, // 10分
    maxEscapes: 0,
    maxWrongClaims: 0,
    clearType: StageClearType.perfectVictories,
  );

  /// ステージクリア条件を取得
  static StageClearCondition getCondition(int stageNumber) {
    switch (stageNumber) {
      case 1:
        return stage1;
      case 2:
        return stage2;
      case 3:
        return stage3;
      case 4:
        return stage4;
      default:
        throw ArgumentError('Invalid stage number: $stageNumber');
    }
  }
}
