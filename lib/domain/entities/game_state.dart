import 'package:freezed_annotation/freezed_annotation.dart';
import 'player.dart';

part 'game_state.freezed.dart';

/// Entity representing the overall game state
@freezed
class GameState with _$GameState {
  const factory GameState({
    // Player data
    @Default(Player()) Player player,

    // Game initialization state
    @Default(false) bool isInitialized,

    // Tutorial state
    @Default(false) bool tutorialCompleted,

    // Game session state
    @Default(false) bool isFirstLaunch,
    @Default(false) bool isPaused,
    @Default(false) bool isOfflineMode,

    // Game settings
    @Default(GameDifficulty.normal) GameDifficulty difficulty,
    @Default(GameLanguage.japanese) GameLanguage language,

    // Achievement system state
    @Default(false) bool achievementSystemEnabled,
    @Default([]) List<String> completedAchievements,
    @Default([]) List<String> newAchievements,

    // Statistics tracking
    @Default(0) int dailyBattlesCompleted,
    @Default(0) int weeklyBattlesCompleted,
    @Default(0) int monthlyBattlesCompleted,

    // Current session stats
    @Default(0) int sessionBattles,
    @Default(0) int sessionVictories,
    @Default(0) int sessionExperienceGained,

    // Game events
    @Default([]) List<GameEvent> recentEvents,

    // Save data info
    DateTime? lastSavedAt,
    @Default(false) bool hasUnsavedChanges,
  }) = _GameState;
}

/// Game difficulty levels
enum GameDifficulty { easy, normal, hard, expert }

/// Game language options
enum GameLanguage { japanese, english }

/// Game event types
@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent({
    required String id,
    required GameEventType type,
    required DateTime timestamp,
    required String description,
    Map<String, dynamic>? data,
  }) = _GameEvent;
}

/// Game event types
enum GameEventType {
  levelUp,
  achievementUnlocked,
  powerEnemyDefeated,
  tutorialCompleted,
  firstVictory,
  milestone,
  error,
}

extension GameStateExtensions on GameState {
  /// Get current win rate
  double get winRate {
    if (player.totalBattles == 0) return 0.0;
    return player.totalVictories / player.totalBattles;
  }

  /// Get session win rate
  double get sessionWinRate {
    if (sessionBattles == 0) return 0.0;
    return sessionVictories / sessionBattles;
  }

  /// Check if player is experienced
  bool get isExperiencedPlayer {
    return player.totalBattles >= 50 && player.level >= 10;
  }

  /// Check if player is new
  bool get isNewPlayer {
    return player.totalBattles < 5 && player.level < 3;
  }

  /// Get total play time estimation (based on battles)
  Duration get estimatedPlayTime {
    // Assume average battle time is 2 minutes
    return Duration(minutes: player.totalBattles * 2);
  }

  /// Check if achievements are available
  bool get hasNewAchievements {
    return newAchievements.isNotEmpty;
  }

  /// Get daily progress percentage
  double get dailyProgressPercentage {
    const dailyGoal = 10; // 10 battles per day
    return (dailyBattlesCompleted / dailyGoal).clamp(0.0, 1.0);
  }

  /// Check if daily goal is reached
  bool get isDailyGoalReached {
    return dailyBattlesCompleted >= 10;
  }

  /// Get difficulty multiplier
  double get difficultyMultiplier {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 0.8;
      case GameDifficulty.normal:
        return 1.0;
      case GameDifficulty.hard:
        return 1.3;
      case GameDifficulty.expert:
        return 1.6;
    }
  }

  /// Check if tutorial should be shown
  bool get shouldShowTutorial {
    return !tutorialCompleted && isNewPlayer;
  }

  /// Get recent achievement events
  List<GameEvent> get recentAchievementEvents {
    return recentEvents
        .where((event) => event.type == GameEventType.achievementUnlocked)
        .toList();
  }

  /// Get recent level up events
  List<GameEvent> get recentLevelUpEvents {
    return recentEvents
        .where((event) => event.type == GameEventType.levelUp)
        .toList();
  }
}
