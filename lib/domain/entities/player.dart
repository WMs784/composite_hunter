import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';

/// Entity representing the player data
@freezed
class Player with _$Player {
  const factory Player({
    // Basic player info
    @Default(1) int level,
    @Default(0) int experience,

    // Battle statistics
    @Default(0) int totalBattles,
    @Default(0) int totalVictories,
    @Default(0) int totalEscapes,
    @Default(0) int totalTimeOuts,
    @Default(0) int totalPowerEnemiesDefeated,

    // Performance statistics
    @Default(0) int totalTurnsUsed,
    @Default(0) int totalTimeSpent, // in seconds
    @Default(0) int perfectBattles,
    @Default(0) int fastestBattleTime, // in seconds
    @Default(0) int longestWinStreak,
    @Default(0) int currentWinStreak,

    // Prime collection statistics
    @Default(0) int totalPrimesCollected,
    @Default(0) int uniquePrimesCollected,
    @Default(0) int largestPrimeCollected,
    @Default(0) int smallestEnemyDefeated,
    @Default(0) int largestEnemyDefeated,

    // Special achievements
    @Default(0) int giantEnemiesDefeated, // enemies > 1000
    @Default(0) int speedVictories, // battles won in < 10 seconds
    @Default(0) int efficientVictories, // battles won in <= 3 turns
    @Default(0) int combackVictories, // battles won with < 5 seconds remaining

    // Timestamps
    DateTime? createdAt,
    DateTime? lastPlayedAt,
    DateTime? lastLevelUpAt,
    DateTime? lastAchievementAt,

    // Preferences
    @Default(PlayerPreferences()) PlayerPreferences preferences,
  }) = _Player;
}

/// Player preferences
@freezed
class PlayerPreferences with _$PlayerPreferences {
  const factory PlayerPreferences({
    // Gameplay preferences
    @Default(true) bool showHints,
    @Default(true) bool showAnimations,
    @Default(true) bool autoSave,
    @Default(true) bool vibrateOnAttack,
    @Default(true) bool soundEffects,
    @Default(true) bool backgroundMusic,

    // Display preferences
    @Default(true) bool showStatistics,
    @Default(true) bool showTimer,
    @Default(true) bool showProgress,
    @Default(false) bool darkMode,

    // Notification preferences
    @Default(true) bool achievementNotifications,
    @Default(true) bool levelUpNotifications,
    @Default(false) bool dailyReminders,

    // Tutorial preferences
    @Default(false) bool skipTutorial,
    @Default(true) bool showTips,
    @Default(true) bool showControls,
  }) = _PlayerPreferences;
}

/// Player rank based on level and performance
enum PlayerRank {
  beginner,
  novice,
  intermediate,
  advanced,
  expert,
  master,
  grandmaster,
}

/// Player specialization based on play style
enum PlayerSpecialization {
  speedRunner, // Fast completion times
  strategist, // Efficient turn usage
  collector, // Prime collection focus
  powerHunter, // Power enemy specialist
  perfectionist, // High accuracy and perfect battles
  endurance, // Long play sessions
}

extension PlayerExtensions on Player {
  /// Calculate win rate
  double get winRate {
    if (totalBattles == 0) return 0.0;
    return totalVictories / totalBattles;
  }

  /// Calculate defeat rate
  double get defeatRate {
    if (totalBattles == 0) return 0.0;
    final defeats = totalBattles - totalVictories;
    return defeats / totalBattles;
  }

  /// Calculate escape rate
  double get escapeRate {
    if (totalBattles == 0) return 0.0;
    return totalEscapes / totalBattles;
  }

  /// Calculate timeout rate
  double get timeoutRate {
    if (totalBattles == 0) return 0.0;
    return totalTimeOuts / totalBattles;
  }

  /// Calculate power enemy rate
  double get powerEnemyRate {
    if (totalVictories == 0) return 0.0;
    return totalPowerEnemiesDefeated / totalVictories;
  }

  /// Calculate average battle time
  double get averageBattleTime {
    if (totalBattles == 0) return 0.0;
    return totalTimeSpent / totalBattles;
  }

  /// Calculate average turns per battle
  double get averageTurnsPerBattle {
    if (totalBattles == 0) return 0.0;
    return totalTurnsUsed / totalBattles;
  }

  /// Calculate perfect battle rate
  double get perfectBattleRate {
    if (totalBattles == 0) return 0.0;
    return perfectBattles / totalBattles;
  }

  /// Get player rank based on level and performance
  PlayerRank get rank {
    if (level >= 100) return PlayerRank.grandmaster;
    if (level >= 75) return PlayerRank.master;
    if (level >= 50) return PlayerRank.expert;
    if (level >= 30) return PlayerRank.advanced;
    if (level >= 15) return PlayerRank.intermediate;
    if (level >= 5) return PlayerRank.novice;
    return PlayerRank.beginner;
  }

  /// Get player specialization based on stats
  PlayerSpecialization get primarySpecialization {
    if (speedVictories > totalVictories * 0.3) {
      return PlayerSpecialization.speedRunner;
    }
    if (efficientVictories > totalVictories * 0.4) {
      return PlayerSpecialization.strategist;
    }
    if (uniquePrimesCollected > 50) {
      return PlayerSpecialization.collector;
    }
    if (totalPowerEnemiesDefeated > totalVictories * 0.2) {
      return PlayerSpecialization.powerHunter;
    }
    if (perfectBattles > totalVictories * 0.5) {
      return PlayerSpecialization.perfectionist;
    }
    return PlayerSpecialization.endurance;
  }

  /// Check if player is experienced
  bool get isExperienced {
    return totalBattles >= 50 && level >= 10;
  }

  /// Check if player is new
  bool get isNew {
    return totalBattles < 5 && level < 3;
  }

  /// Check if player is active (played recently)
  bool get isActive {
    if (lastPlayedAt == null) return false;
    final daysSinceLastPlay = DateTime.now().difference(lastPlayedAt!).inDays;
    return daysSinceLastPlay <= 7;
  }

  /// Check if player is veteran (high stats)
  bool get isVeteran {
    return level >= 25 && totalBattles >= 100 && winRate >= 0.7;
  }

  /// Get experience needed for next level
  int get experienceForNextLevel {
    return (level * 100) - experience;
  }

  /// Get experience progress to next level (0.0 to 1.0)
  double get experienceProgress {
    final currentLevelExp = (level - 1) * 100;
    final nextLevelExp = level * 100;
    final currentExp = experience;

    if (currentExp >= nextLevelExp) return 1.0;

    final levelExp = currentExp - currentLevelExp;
    final levelRange = nextLevelExp - currentLevelExp;

    return (levelExp / levelRange).clamp(0.0, 1.0);
  }

  /// Get total play time estimation
  Duration get estimatedPlayTime {
    return Duration(seconds: totalTimeSpent);
  }

  /// Get days since account creation
  int get daysSinceCreation {
    if (createdAt == null) return 0;
    return DateTime.now().difference(createdAt!).inDays;
  }

  /// Get days since last played
  int get daysSinceLastPlay {
    if (lastPlayedAt == null) return 0;
    return DateTime.now().difference(lastPlayedAt!).inDays;
  }

  /// Check if player has specific achievement requirements
  bool hasAchievementRequirement(String achievementId) {
    switch (achievementId) {
      case 'first_victory':
        return totalVictories >= 1;
      case 'battle_veteran':
        return totalBattles >= 100;
      case 'power_hunter':
        return totalPowerEnemiesDefeated >= 1;
      case 'speed_demon':
        return speedVictories >= 1;
      case 'efficient_hunter':
        return efficientVictories >= 1;
      case 'giant_slayer':
        return giantEnemiesDefeated >= 1;
      case 'level_up_10':
        return level >= 10;
      case 'level_up_25':
        return level >= 25;
      case 'level_up_50':
        return level >= 50;
      default:
        return false;
    }
  }
}
