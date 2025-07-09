import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/stage.dart';
import '../../domain/usecases/stage_progress_usecase.dart';

/// バトルセッション状態
class BattleSessionState {
  final int? stageNumber;
  final bool isPracticeMode;
  final int victories;
  final int escapes;
  final int wrongClaims;
  final DateTime sessionStartTime;
  final List<int> defeatedEnemies;
  
  const BattleSessionState({
    this.stageNumber,
    this.isPracticeMode = false,
    this.victories = 0,
    this.escapes = 0,
    this.wrongClaims = 0,
    required this.sessionStartTime,
    this.defeatedEnemies = const [],
  });
  
  BattleSessionState copyWith({
    int? stageNumber,
    bool? isPracticeMode,
    int? victories,
    int? escapes,
    int? wrongClaims,
    DateTime? sessionStartTime,
    List<int>? defeatedEnemies,
  }) {
    return BattleSessionState(
      stageNumber: stageNumber ?? this.stageNumber,
      isPracticeMode: isPracticeMode ?? this.isPracticeMode,
      victories: victories ?? this.victories,
      escapes: escapes ?? this.escapes,
      wrongClaims: wrongClaims ?? this.wrongClaims,
      sessionStartTime: sessionStartTime ?? this.sessionStartTime,
      defeatedEnemies: defeatedEnemies ?? this.defeatedEnemies,
    );
  }
  
  Duration get totalTime => DateTime.now().difference(sessionStartTime);
}

/// バトルセッションプロバイダー
class BattleSessionNotifier extends StateNotifier<BattleSessionState> {
  BattleSessionNotifier() : super(BattleSessionState(
    sessionStartTime: DateTime.now(),
  ));
  
  /// ステージバトルを開始
  void startStage(int stageNumber) {
    state = BattleSessionState(
      stageNumber: stageNumber,
      isPracticeMode: false,
      sessionStartTime: DateTime.now(),
    );
  }
  
  /// 練習モードを開始
  void startPractice() {
    state = BattleSessionState(
      isPracticeMode: true,
      sessionStartTime: DateTime.now(),
    );
  }
  
  /// 勝利を記録
  void recordVictory(int defeatedEnemy) {
    state = state.copyWith(
      victories: state.victories + 1,
      defeatedEnemies: [...state.defeatedEnemies, defeatedEnemy],
    );
  }
  
  /// 逃走を記録
  void recordEscape() {
    state = state.copyWith(
      escapes: state.escapes + 1,
    );
  }
  
  /// 誤判定を記録
  void recordWrongClaim() {
    state = state.copyWith(
      wrongClaims: state.wrongClaims + 1,
    );
  }
  
  /// セッションリセット
  void resetSession() {
    state = BattleSessionState(
      sessionStartTime: DateTime.now(),
    );
  }
  
  /// クリア判定をチェック
  StageClearResult? checkClearCondition() {
    if (state.stageNumber == null || state.isPracticeMode) {
      return null; // 練習モードはクリア判定なし
    }
    
    return StageProgressUsecase.checkClearCondition(
      stageNumber: state.stageNumber!,
      victories: state.victories,
      escapes: state.escapes,
      wrongClaims: state.wrongClaims,
      totalTime: state.totalTime,
      defeatedEnemies: state.defeatedEnemies,
    );
  }
}

final battleSessionProvider = StateNotifierProvider<BattleSessionNotifier, BattleSessionState>(
  (ref) => BattleSessionNotifier(),
);