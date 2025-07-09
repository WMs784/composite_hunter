import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/stage.dart';
import '../screens/stage/stage_select_screen.dart';

/// ステージ進行状況の永続化
class StageProgressNotifier extends StateNotifier<List<StageInfo>> {
  StageProgressNotifier() : super([
    const StageInfo(
      stageNumber: 1,
      title: 'Basic Battle',
      description: 'Fight small composite numbers and learn prime factorization',
      enemyRangeMin: 6,
      enemyRangeMax: 20,
      timeLimit: 30,
      isUnlocked: true,
      isCompleted: false,
      stars: 0,
    ),
    const StageInfo(
      stageNumber: 2,
      title: 'Intermediate Challenge',
      description: 'Face medium composite numbers with strategic attacks',
      enemyRangeMin: 21,
      enemyRangeMax: 100,
      timeLimit: 60,
      isUnlocked: false,
      isCompleted: false,
      stars: 0,
    ),
    const StageInfo(
      stageNumber: 3,
      title: 'Advanced Path',
      description: 'Engage in serious battles with large composite numbers',
      enemyRangeMin: 101,
      enemyRangeMax: 1000,
      timeLimit: 90,
      isUnlocked: false,
      isCompleted: false,
      stars: 0,
    ),
    const StageInfo(
      stageNumber: 4,
      title: 'Expert Mode',
      description: 'Ultimate challenge for advanced players',
      enemyRangeMin: 1001,
      enemyRangeMax: 10000,
      timeLimit: 120,
      isUnlocked: false,
      isCompleted: false,
      stars: 0,
    ),
  ]) {
    _loadProgress();
  }

  /// 進行状況を読み込み
  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    final updatedStages = state.map((stage) {
      final key = 'stage_${stage.stageNumber}';
      final isCompleted = prefs.getBool('${key}_completed') ?? false;
      final stars = prefs.getInt('${key}_stars') ?? 0;
      final isUnlocked = _shouldBeUnlocked(stage.stageNumber, isCompleted);
      
      return StageInfo(
        stageNumber: stage.stageNumber,
        title: stage.title,
        description: stage.description,
        enemyRangeMin: stage.enemyRangeMin,
        enemyRangeMax: stage.enemyRangeMax,
        timeLimit: stage.timeLimit,
        isUnlocked: isUnlocked,
        isCompleted: isCompleted,
        stars: stars,
      );
    }).toList();
    
    state = updatedStages;
  }

  /// ステージクリア時の処理
  Future<void> completeStage(StageClearResult clearResult) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'stage_${clearResult.stageNumber}';
    
    // 現在の記録を取得
    final currentStars = prefs.getInt('${key}_stars') ?? 0;
    final bestScore = prefs.getInt('${key}_best_score') ?? 0;
    
    // より良い記録の場合のみ更新
    final newStars = clearResult.stars > currentStars ? clearResult.stars : currentStars;
    final newBestScore = clearResult.score > bestScore ? clearResult.score : bestScore;
    
    // 保存
    await prefs.setBool('${key}_completed', true);
    await prefs.setInt('${key}_stars', newStars);
    await prefs.setInt('${key}_best_score', newBestScore);
    await prefs.setString('${key}_completed_at', DateTime.now().toIso8601String());
    
    // 状態を更新
    final updatedStages = state.map((stage) {
      if (stage.stageNumber == clearResult.stageNumber) {
        return StageInfo(
          stageNumber: stage.stageNumber,
          title: stage.title,
          description: stage.description,
          enemyRangeMin: stage.enemyRangeMin,
          enemyRangeMax: stage.enemyRangeMax,
          timeLimit: stage.timeLimit,
          isUnlocked: stage.isUnlocked,
          isCompleted: true,
          stars: newStars,
        );
      } else if (stage.stageNumber == clearResult.stageNumber + 1) {
        // 次のステージをアンロック
        return StageInfo(
          stageNumber: stage.stageNumber,
          title: stage.title,
          description: stage.description,
          enemyRangeMin: stage.enemyRangeMin,
          enemyRangeMax: stage.enemyRangeMax,
          timeLimit: stage.timeLimit,
          isUnlocked: true,
          isCompleted: stage.isCompleted,
          stars: stage.stars,
        );
      }
      return stage;
    }).toList();
    
    state = updatedStages;
  }

  /// ステージのアンロック判定
  bool _shouldBeUnlocked(int stageNumber, bool isCompleted) {
    if (stageNumber == 1) return true; // ステージ1は常にアンロック
    
    // 前のステージがクリア済みかチェック
    final previousStageIndex = stageNumber - 2;
    if (previousStageIndex >= 0 && previousStageIndex < state.length) {
      return state[previousStageIndex].isCompleted;
    }
    
    return false;
  }

  /// ステージをリセット（デバッグ用）
  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    for (int i = 1; i <= 4; i++) {
      await prefs.remove('stage_${i}_completed');
      await prefs.remove('stage_${i}_stars');
      await prefs.remove('stage_${i}_best_score');
      await prefs.remove('stage_${i}_completed_at');
    }
    
    await _loadProgress();
  }
}

final stageProgressProvider = StateNotifierProvider<StageProgressNotifier, List<StageInfo>>(
  (ref) => StageProgressNotifier(),
);