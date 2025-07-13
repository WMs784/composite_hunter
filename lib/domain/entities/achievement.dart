import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';

/// Entity representing an achievement
@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required AchievementCategory category,
    required AchievementType type,
    required int targetValue,
    required int currentProgress,
    required bool isUnlocked,
    required AchievementReward reward,
    DateTime? unlockedAt,
    @Default(AchievementRarity.common) AchievementRarity rarity,
    @Default(false) bool isHidden,
    @Default(false) bool isSecret,
    String? iconPath,
    String? hint,
    List<String>? prerequisites,
  }) = _Achievement;
}

/// Achievement categories
enum AchievementCategory {
  battle,
  powerEnemy,
  speed,
  efficiency,
  collection,
  progression,
  special,
  social,
  tutorial,
  milestone,
}

/// Achievement types
enum AchievementType {
  milestone,    // One-time achievements
  cumulative,   // Count-based achievements
  streak,       // Consecutive achievements
  percentage,   // Percentage-based achievements
  time,         // Time-based achievements
  secret,       // Hidden achievements
}

/// Achievement rarity levels
enum AchievementRarity {
  common,
  uncommon,
  rare,
  epic,
  legendary,
}

/// Achievement reward types
@freezed
class AchievementReward with _$AchievementReward {
  const factory AchievementReward.experience(int amount) = ExperienceReward;
  const factory AchievementReward.prime(int value, int count) = PrimeReward;
  const factory AchievementReward.combo(List<AchievementReward> rewards) = ComboReward;
}

/// Achievement progress tracker
@freezed
class AchievementProgress with _$AchievementProgress {
  const factory AchievementProgress({
    required String achievementId,
    required int currentValue,
    required int targetValue,
    required DateTime lastUpdated,
    @Default([]) List<AchievementProgressSnapshot> snapshots,
  }) = _AchievementProgress;
}

/// Achievement progress snapshot
@freezed
class AchievementProgressSnapshot with _$AchievementProgressSnapshot {
  const factory AchievementProgressSnapshot({
    required int value,
    required DateTime timestamp,
    String? trigger,
    Map<String, dynamic>? metadata,
  }) = _AchievementProgressSnapshot;
}

/// Achievement notification data
@freezed
class AchievementNotification with _$AchievementNotification {
  const factory AchievementNotification({
    required Achievement achievement,
    required DateTime timestamp,
    @Default(false) bool isRead,
    String? customMessage,
  }) = _AchievementNotification;
}

extension AchievementExtensions on Achievement {
  /// Get completion percentage
  double get completionPercentage {
    if (targetValue == 0) return 0.0;
    return (currentProgress / targetValue).clamp(0.0, 1.0);
  }
  
  /// Check if achievement is completed
  bool get isCompleted {
    return currentProgress >= targetValue;
  }
  
  /// Check if achievement is in progress
  bool get isInProgress {
    return currentProgress > 0 && !isCompleted;
  }
  
  /// Get progress display text
  String get progressText {
    if (type == AchievementType.percentage) {
      return '${(completionPercentage * 100).toStringAsFixed(1)}%';
    }
    return '$currentProgress/$targetValue';
  }
  
  /// Get time since unlock
  Duration? get timeSinceUnlock {
    if (unlockedAt == null) return null;
    return DateTime.now().difference(unlockedAt!);
  }
  
  /// Check if recently unlocked (within last hour)
  bool get isRecentlyUnlocked {
    final timeSince = timeSinceUnlock;
    if (timeSince == null) return false;
    return timeSince.inHours < 1;
  }
  
  /// Get rarity display color
  String get rarityColor {
    switch (rarity) {
      case AchievementRarity.common:
        return '#9E9E9E';
      case AchievementRarity.uncommon:
        return '#4CAF50';
      case AchievementRarity.rare:
        return '#2196F3';
      case AchievementRarity.epic:
        return '#9C27B0';
      case AchievementRarity.legendary:
        return '#FF9800';
    }
  }
  
  /// Get category display name
  String get categoryDisplayName {
    switch (category) {
      case AchievementCategory.battle:
        return 'Battle';
      case AchievementCategory.powerEnemy:
        return 'Power Enemy';
      case AchievementCategory.speed:
        return 'Speed';
      case AchievementCategory.efficiency:
        return 'Efficiency';
      case AchievementCategory.collection:
        return 'Collection';
      case AchievementCategory.progression:
        return 'Progression';
      case AchievementCategory.special:
        return 'Special';
      case AchievementCategory.social:
        return 'Social';
      case AchievementCategory.tutorial:
        return 'Tutorial';
      case AchievementCategory.milestone:
        return 'Milestone';
    }
  }
  
  /// Get type display name
  String get typeDisplayName {
    switch (type) {
      case AchievementType.milestone:
        return 'Milestone';
      case AchievementType.cumulative:
        return 'Cumulative';
      case AchievementType.streak:
        return 'Streak';
      case AchievementType.percentage:
        return 'Percentage';
      case AchievementType.time:
        return 'Time';
      case AchievementType.secret:
        return 'Secret';
    }
  }
  
  /// Get reward display text
  String get rewardDisplayText {
    return reward.when(
      experience: (amount) => '$amount EXP',
      prime: (value, count) => '$count × Prime $value',
      combo: (rewards) => '${rewards.length} Rewards',
    );
  }
  
  /// Check if achievement should be displayed
  bool get shouldDisplay {
    return !isHidden || isUnlocked;
  }
  
  /// Check if achievement has prerequisites
  bool get hasPrerequisites {
    return prerequisites != null && prerequisites!.isNotEmpty;
  }
  
  /// Get difficulty level based on target value and rarity
  int get difficultyLevel {
    var difficulty = 1;
    
    // Base difficulty from target value
    if (targetValue >= 1000) {
      difficulty += 4;
    } else if (targetValue >= 100) {
      difficulty += 3;
    } else if (targetValue >= 50) {
      difficulty += 2;
    } else if (targetValue >= 10) {
      difficulty += 1;
    }
    
    // Additional difficulty from rarity
    switch (rarity) {
      case AchievementRarity.common:
        break;
      case AchievementRarity.uncommon:
        difficulty += 1;
        break;
      case AchievementRarity.rare:
        difficulty += 2;
        break;
      case AchievementRarity.epic:
        difficulty += 3;
        break;
      case AchievementRarity.legendary:
        difficulty += 4;
        break;
    }
    
    return difficulty.clamp(1, 10);
  }
  
  /// Get estimated time to complete
  Duration get estimatedTimeToComplete {
    switch (category) {
      case AchievementCategory.battle:
        // Assume 2 minutes per battle
        return Duration(minutes: (targetValue - currentProgress) * 2);
      case AchievementCategory.speed:
        // Speed achievements are quick
        return const Duration(minutes: 30);
      case AchievementCategory.collection:
        // Collection takes time
        return Duration(hours: (targetValue - currentProgress) * 2);
      case AchievementCategory.progression:
        // Level-based progression
        return Duration(hours: (targetValue - currentProgress) * 10);
      default:
        return const Duration(hours: 1);
    }
  }
}