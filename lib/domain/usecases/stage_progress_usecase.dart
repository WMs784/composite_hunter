import 'dart:math' as math;
import '../entities/stage.dart';

/// ステージ進行状況を管理するユースケース
class StageProgressUsecase {
  /// 現在のバトル状況からクリア判定を行う
  static StageClearResult? checkClearCondition({
    required int stageNumber,
    required int victories,
    required int escapes,
    required int wrongClaims,
    required Duration totalTime,
    required List<int> defeatedEnemies,
  }) {
    final condition = StageConfig.getCondition(stageNumber);
    
    // 失敗条件チェック
    if (escapes > condition.maxEscapes || wrongClaims > condition.maxWrongClaims) {
      return null; // ステージ失敗
    }
    
    // 制限時間チェック
    if (totalTime.inSeconds > condition.timeLimit) {
      return null; // 時間切れ
    }
    
    // クリア条件チェック
    bool isCleared = false;
    
    switch (condition.clearType) {
      case StageClearType.victories:
        isCleared = victories >= condition.requiredVictories;
        break;
        
      case StageClearType.consecutiveVictories:
        // 連続勝利の場合、逃走や誤判定があると失敗
        isCleared = victories >= condition.requiredVictories && 
                   escapes == 0 && wrongClaims == 0;
        break;
        
      case StageClearType.timedVictories:
        isCleared = victories >= condition.requiredVictories &&
                   totalTime.inSeconds <= condition.timeLimit;
        break;
        
      case StageClearType.perfectVictories:
        isCleared = victories >= condition.requiredVictories &&
                   escapes == 0 && wrongClaims == 0;
        break;
    }
    
    if (!isCleared) {
      return null;
    }
    
    // クリア結果を作成
    final isPerfect = escapes == 0 && wrongClaims == 0;
    final stars = StarRating.calculateStars(
      victories: victories,
      escapes: escapes,
      wrongClaims: wrongClaims,
      totalTime: totalTime,
      timeLimit: Duration(seconds: condition.timeLimit),
      isPerfect: isPerfect,
    );
    
    final score = _calculateScore(
      victories: victories,
      escapes: escapes,
      wrongClaims: wrongClaims,
      totalTime: totalTime,
      stars: stars,
      defeatedEnemies: defeatedEnemies,
    );
    
    return StageClearResult(
      stageNumber: stageNumber,
      isCleared: true,
      stars: stars,
      score: score,
      victories: victories,
      escapes: escapes,
      wrongClaims: wrongClaims,
      totalTime: totalTime,
      defeatedEnemies: defeatedEnemies,
      isPerfect: isPerfect,
      isNewRecord: false, // TODO: 過去のスコアと比較
    );
  }
  
  /// スコア計算
  static int _calculateScore({
    required int victories,
    required int escapes,
    required int wrongClaims,
    required Duration totalTime,
    required int stars,
    required List<int> defeatedEnemies,
  }) {
    int baseScore = victories * 100;
    
    // 時間ボーナス（早くクリアするほど高得点）
    int timeBonus = math.max(0, 300 - totalTime.inSeconds) * 2;
    
    // 星ボーナス
    int starBonus = stars * 200;
    
    // パーフェクトボーナス
    int perfectBonus = (escapes == 0 && wrongClaims == 0) ? 500 : 0;
    
    // 敵の難易度ボーナス
    int enemyBonus = defeatedEnemies.fold(0, (sum, enemy) {
      if (enemy > 1000) return sum + 50;
      if (enemy > 100) return sum + 30;
      if (enemy > 20) return sum + 20;
      return sum + 10;
    });
    
    // ペナルティ
    int penalty = (escapes * 50) + (wrongClaims * 30);
    
    return math.max(0, baseScore + timeBonus + starBonus + perfectBonus + enemyBonus - penalty);
  }
}