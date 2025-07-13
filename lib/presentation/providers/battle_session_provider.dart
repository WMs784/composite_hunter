import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/stage.dart';
import '../../domain/entities/prime.dart';
import '../../domain/usecases/stage_progress_usecase.dart';
import '../../core/utils/logger.dart';

/// バトルセッション状態
class BattleSessionState {
  final int? stageNumber;
  final bool isPracticeMode;
  final int victories;
  final int escapes;
  final int wrongClaims;
  final DateTime sessionStartTime;
  final List<int> defeatedEnemies;
  final List<int> usedPrimesInCurrentBattle; // 現在のバトルで使用した素数
  final List<Prime>? stageStartInventory; // ステージ開始時のアイテム状態

  const BattleSessionState({
    this.stageNumber,
    this.isPracticeMode = false,
    this.victories = 0,
    this.escapes = 0,
    this.wrongClaims = 0,
    required this.sessionStartTime,
    this.defeatedEnemies = const [],
    this.usedPrimesInCurrentBattle = const [],
    this.stageStartInventory,
  });

  BattleSessionState copyWith({
    int? stageNumber,
    bool? isPracticeMode,
    int? victories,
    int? escapes,
    int? wrongClaims,
    DateTime? sessionStartTime,
    List<int>? defeatedEnemies,
    List<int>? usedPrimesInCurrentBattle,
    List<Prime>? stageStartInventory,
  }) {
    return BattleSessionState(
      stageNumber: stageNumber ?? this.stageNumber,
      isPracticeMode: isPracticeMode ?? this.isPracticeMode,
      victories: victories ?? this.victories,
      escapes: escapes ?? this.escapes,
      wrongClaims: wrongClaims ?? this.wrongClaims,
      sessionStartTime: sessionStartTime ?? this.sessionStartTime,
      defeatedEnemies: defeatedEnemies ?? this.defeatedEnemies,
      usedPrimesInCurrentBattle:
          usedPrimesInCurrentBattle ?? this.usedPrimesInCurrentBattle,
      stageStartInventory: stageStartInventory ?? this.stageStartInventory,
    );
  }

  Duration get totalTime => DateTime.now().difference(sessionStartTime);
}

/// バトルセッションプロバイダー
class BattleSessionNotifier extends StateNotifier<BattleSessionState> {
  BattleSessionNotifier()
      : super(BattleSessionState(
          sessionStartTime: DateTime.now(),
        ));

  /// ステージバトルを開始
  void startStage(int stageNumber, List<Prime> currentInventory) {
    state = BattleSessionState(
      stageNumber: stageNumber,
      isPracticeMode: false,
      sessionStartTime: DateTime.now(),
      stageStartInventory: List.from(currentInventory), // アイテム状態をコピーして保存
    );
  }

  /// 選択されたアイテムでステージバトルを開始
  void startStageWithSelectedItems(
      int stageNumber, List<Prime> selectedInventory) {
    state = BattleSessionState(
      stageNumber: stageNumber,
      isPracticeMode: false,
      sessionStartTime: DateTime.now(),
      stageStartInventory: List.from(selectedInventory), // 選択されたアイテム状態をコピーして保存
    );

    Logger.logBattle('Started stage', data: {
      'stage': stageNumber,
      'selected_items': selectedInventory.length
    });
    for (final prime in selectedInventory) {
      Logger.logInventory('Prime available',
          prime: prime.value, count: prime.count);
    }
  }

  /// 練習モードを開始
  void startPractice(List<Prime> currentInventory) {
    state = BattleSessionState(
      isPracticeMode: true,
      sessionStartTime: DateTime.now(),
      stageStartInventory: List.from(currentInventory), // アイテム状態をコピーして保存
    );
  }

  /// 勝利を記録
  void recordVictory(int defeatedEnemy) {
    state = state.copyWith(
      victories: state.victories + 1,
      defeatedEnemies: [...state.defeatedEnemies, defeatedEnemy],
      usedPrimesInCurrentBattle: [], // 勝利時にリセット
    );
  }

  /// 現在のバトルで使用した素数を記録
  void recordUsedPrime(int prime) {
    state = state.copyWith(
      usedPrimesInCurrentBattle: [...state.usedPrimesInCurrentBattle, prime],
    );
  }

  /// 現在のバトルで使用した素数をリセット
  void resetUsedPrimes() {
    state = state.copyWith(
      usedPrimesInCurrentBattle: [],
    );
  }

  /// 逃走を記録
  void recordEscape() {
    state = state.copyWith(
      escapes: state.escapes + 1,
      usedPrimesInCurrentBattle: [], // 逃走時にリセット
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

final battleSessionProvider =
    StateNotifierProvider<BattleSessionNotifier, BattleSessionState>(
  (ref) => BattleSessionNotifier(),
);
