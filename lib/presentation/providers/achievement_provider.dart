import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/inventory.dart';
import 'game_provider.dart';
import 'inventory_provider.dart';
import '../../core/utils/logger.dart';

/// State notifier for achievement management
class AchievementNotifier extends StateNotifier<List<Achievement>> {
  final Ref _ref;

  AchievementNotifier(this._ref) : super([]) {
    _initializeAchievements();
  }

  /// Initialize all available achievements
  void _initializeAchievements() {
    state = [
      // Battle achievements
      Achievement(
        id: 'first_victory',
        title: 'First Victory',
        description: 'Win your first battle',
        category: AchievementCategory.battle,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(50),
      ),
      Achievement(
        id: 'battle_veteran',
        title: 'Battle Veteran',
        description: 'Complete 100 battles',
        category: AchievementCategory.battle,
        type: AchievementType.cumulative,
        targetValue: 100,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(500),
      ),
      Achievement(
        id: 'victory_streak_10',
        title: 'Winning Streak',
        description: 'Win 10 battles in a row',
        category: AchievementCategory.battle,
        type: AchievementType.streak,
        targetValue: 10,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(11, 1),
      ),
      Achievement(
        id: 'victory_streak_25',
        title: 'Unstoppable',
        description: 'Win 25 battles in a row',
        category: AchievementCategory.battle,
        type: AchievementType.streak,
        targetValue: 25,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(23, 1),
      ),

      // Power enemy achievements
      Achievement(
        id: 'power_hunter',
        title: 'Power Hunter',
        description: 'Defeat your first power enemy',
        category: AchievementCategory.powerEnemy,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(100),
      ),
      Achievement(
        id: 'power_slayer',
        title: 'Power Slayer',
        description: 'Defeat 50 power enemies',
        category: AchievementCategory.powerEnemy,
        type: AchievementType.cumulative,
        targetValue: 50,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(37, 2),
      ),

      // Speed achievements
      Achievement(
        id: 'speed_demon',
        title: 'Speed Demon',
        description: 'Complete a battle in under 10 seconds',
        category: AchievementCategory.speed,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(75),
      ),
      Achievement(
        id: 'lightning_fast',
        title: 'Lightning Fast',
        description: 'Complete 10 battles in under 15 seconds each',
        category: AchievementCategory.speed,
        type: AchievementType.cumulative,
        targetValue: 10,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(13, 2),
      ),

      // Efficiency achievements
      Achievement(
        id: 'efficient_hunter',
        title: 'Efficient Hunter',
        description: 'Complete a battle in 3 turns or less',
        category: AchievementCategory.efficiency,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(60),
      ),
      Achievement(
        id: 'minimalist',
        title: 'Minimalist',
        description: 'Complete 20 battles in 3 turns or less',
        category: AchievementCategory.efficiency,
        type: AchievementType.cumulative,
        targetValue: 20,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(17, 2),
      ),

      // Collection achievements
      Achievement(
        id: 'collector',
        title: 'Prime Collector',
        description: 'Collect 10 different primes',
        category: AchievementCategory.collection,
        type: AchievementType.cumulative,
        targetValue: 10,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(200),
      ),
      Achievement(
        id: 'hoarder',
        title: 'Prime Hoarder',
        description: 'Have 100 total primes in inventory',
        category: AchievementCategory.collection,
        type: AchievementType.milestone,
        targetValue: 100,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(19, 3),
      ),
      Achievement(
        id: 'large_prime_collector',
        title: 'Large Prime Collector',
        description: 'Collect 5 primes larger than 100',
        category: AchievementCategory.collection,
        type: AchievementType.cumulative,
        targetValue: 5,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(101, 1),
      ),

      // Progression achievements
      Achievement(
        id: 'level_up_10',
        title: 'Rising Star',
        description: 'Reach level 10',
        category: AchievementCategory.progression,
        type: AchievementType.milestone,
        targetValue: 10,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(300),
      ),
      Achievement(
        id: 'level_up_25',
        title: 'Expert Hunter',
        description: 'Reach level 25',
        category: AchievementCategory.progression,
        type: AchievementType.milestone,
        targetValue: 25,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(29, 2),
      ),
      Achievement(
        id: 'level_up_50',
        title: 'Prime Master',
        description: 'Reach level 50',
        category: AchievementCategory.progression,
        type: AchievementType.milestone,
        targetValue: 50,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(47, 3),
      ),

      // Special achievements
      Achievement(
        id: 'perfect_battle',
        title: 'Perfect Battle',
        description: 'Complete a battle with perfect score',
        category: AchievementCategory.special,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(150),
      ),
      Achievement(
        id: 'giant_slayer',
        title: 'Giant Slayer',
        description: 'Defeat an enemy with value over 1000',
        category: AchievementCategory.special,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.prime(31, 2),
      ),
      Achievement(
        id: 'comeback_king',
        title: 'Comeback King',
        description: 'Win a battle with less than 5 seconds remaining',
        category: AchievementCategory.special,
        type: AchievementType.milestone,
        targetValue: 1,
        currentProgress: 0,
        isUnlocked: false,
        reward: AchievementReward.experience(100),
      ),
    ];
    
    // Update progress based on current game state
    _updateAllProgress();
  }

  /// Update all achievement progress based on current game state
  void _updateAllProgress() {
    final player = _ref.read(playerProvider);
    final inventoryList = _ref.read(inventoryProvider);
    final inventory = Inventory(primes: inventoryList);
    
    state = state.map((achievement) {
      final updatedProgress = _calculateProgress(achievement, player, inventory);
      return achievement.copyWith(
        currentProgress: updatedProgress,
        isUnlocked: updatedProgress >= achievement.targetValue,
      );
    }).toList();
  }

  /// Calculate progress for a specific achievement
  int _calculateProgress(Achievement achievement, Player player, Inventory inventory) {
    switch (achievement.id) {
      // Battle achievements
      case 'first_victory':
      case 'victory_streak_10':
      case 'victory_streak_25':
        return player.totalVictories;
      case 'battle_veteran':
        return player.totalBattles;

      // Power enemy achievements
      case 'power_hunter':
      case 'power_slayer':
        return player.totalPowerEnemiesDefeated;

      // Collection achievements
      case 'collector':
        return inventory.uniqueCount;
      case 'hoarder':
        return inventory.totalCount;
      case 'large_prime_collector':
        return inventory.primes.where((p) => p.value > 100).length;

      // Progression achievements
      case 'level_up_10':
      case 'level_up_25':
      case 'level_up_50':
        return player.level;

      // Speed, efficiency, and special achievements require real-time tracking
      default:
        return achievement.currentProgress;
    }
  }

  /// Check and unlock achievements after a battle
  Future<List<Achievement>> checkBattleAchievements({
    required bool isVictory,
    required bool isPowerEnemy,
    required int battleTimeSeconds,
    required int turnCount,
    required int enemyValue,
    required bool isPerfectScore,
  }) async {
    final newlyUnlocked = <Achievement>[];

    state = state.map((achievement) {
      if (achievement.isUnlocked) return achievement;

      bool shouldUnlock = false;
      int newProgress = achievement.currentProgress;

      switch (achievement.id) {
        // Speed achievements
        case 'speed_demon':
          if (isVictory && battleTimeSeconds <= 10) {
            newProgress = 1;
            shouldUnlock = true;
          }
          break;
        case 'lightning_fast':
          if (isVictory && battleTimeSeconds <= 15) {
            newProgress = achievement.currentProgress + 1;
            shouldUnlock = newProgress >= achievement.targetValue;
          }
          break;

        // Efficiency achievements
        case 'efficient_hunter':
          if (isVictory && turnCount <= 3) {
            newProgress = 1;
            shouldUnlock = true;
          }
          break;
        case 'minimalist':
          if (isVictory && turnCount <= 3) {
            newProgress = achievement.currentProgress + 1;
            shouldUnlock = newProgress >= achievement.targetValue;
          }
          break;

        // Special achievements
        case 'perfect_battle':
          if (isVictory && isPerfectScore) {
            newProgress = 1;
            shouldUnlock = true;
          }
          break;
        case 'giant_slayer':
          if (isVictory && enemyValue > 1000) {
            newProgress = 1;
            shouldUnlock = true;
          }
          break;
        case 'comeback_king':
          if (isVictory && battleTimeSeconds >= 0) { // This would need timer state
            // Logic would check if victory happened with < 5 seconds remaining
            // For now, just placeholder
          }
          break;
      }

      final updated = achievement.copyWith(
        currentProgress: newProgress,
        isUnlocked: shouldUnlock,
        unlockedAt: shouldUnlock ? DateTime.now() : achievement.unlockedAt,
      );

      if (shouldUnlock && !achievement.isUnlocked) {
        newlyUnlocked.add(updated);
        Logger.debug('Achievement unlocked: ${achievement.id}');
      }

      return updated;
    }).toList();

    // Award rewards for newly unlocked achievements
    for (final achievement in newlyUnlocked) {
      await _awardReward(achievement);
    }

    return newlyUnlocked;
  }

  /// Award reward for completed achievement
  Future<void> _awardReward(Achievement achievement) async {
    final reward = achievement.reward;
    
    reward.when(
      experience: (exp) async {
        await _ref.read(gameProvider.notifier).addExperience(exp);
        Logger.debug('Experience reward awarded: $exp');
      },
      prime: (value, count) async {
        for (int i = 0; i < count; i++) {
          _ref.read(inventoryProvider.notifier).addPrime(value);
        }
        Logger.debug('Prime reward awarded: $value x$count');
      },
      combo: (rewards) async {
        for (final reward in rewards) {
          // Create a minimal achievement for recursive reward processing
          final tempAchievement = Achievement(
            id: 'temp_combo_${DateTime.now().millisecondsSinceEpoch}',
            title: 'Combo Reward',
            description: 'Temporary achievement for combo reward processing',
            category: AchievementCategory.battle,
            type: AchievementType.progressive,
            targetValue: 1,
            currentProgress: 1,
            isUnlocked: true,
            reward: reward,
          );
          await _awardReward(tempAchievement);
        }
        Logger.debug('Combo reward awarded with ${rewards.length} rewards');
      },
    );
  }

  /// Update achievement progress manually (for specific cases)
  void updateProgress(String achievementId, int progress) {
    state = state.map((achievement) {
      if (achievement.id == achievementId) {
        final shouldUnlock = progress >= achievement.targetValue;
        return achievement.copyWith(
          currentProgress: progress,
          isUnlocked: shouldUnlock,
          unlockedAt: shouldUnlock ? DateTime.now() : achievement.unlockedAt,
        );
      }
      return achievement;
    }).toList();
  }

  /// Get achievements by category
  List<Achievement> getAchievementsByCategory(AchievementCategory category) {
    return state.where((a) => a.category == category).toList();
  }

  /// Get unlocked achievements
  List<Achievement> getUnlockedAchievements() {
    return state.where((a) => a.isUnlocked).toList();
  }

  /// Get locked achievements
  List<Achievement> getLockedAchievements() {
    return state.where((a) => !a.isUnlocked).toList();
  }

  /// Get achievements by type
  List<Achievement> getAchievementsByType(AchievementType type) {
    return state.where((a) => a.type == type).toList();
  }

  /// Get completion percentage
  double getCompletionPercentage() {
    if (state.isEmpty) return 0.0;
    final unlockedCount = state.where((a) => a.isUnlocked).length;
    return unlockedCount / state.length;
  }

  /// Get recently unlocked achievements (last 7 days)
  List<Achievement> getRecentlyUnlocked() {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return state
        .where((a) => a.isUnlocked && 
                     a.unlockedAt != null && 
                     a.unlockedAt!.isAfter(sevenDaysAgo))
        .toList();
  }

  /// Reset all achievements (for testing)
  void resetAllAchievements() {
    state = state.map((achievement) => achievement.copyWith(
      currentProgress: 0,
      isUnlocked: false,
      unlockedAt: null,
    )).toList();
  }
}

/// Achievement provider
final achievementProvider = StateNotifierProvider<AchievementNotifier, List<Achievement>>((ref) {
  return AchievementNotifier(ref);
});

/// Computed providers for achievements
final unlockedAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.watch(achievementProvider).where((a) => a.isUnlocked).toList();
});

final lockedAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.watch(achievementProvider).where((a) => !a.isUnlocked).toList();
});

final achievementCompletionProvider = Provider<double>((ref) {
  final achievements = ref.watch(achievementProvider);
  if (achievements.isEmpty) return 0.0;
  final unlocked = achievements.where((a) => a.isUnlocked).length;
  return unlocked / achievements.length;
});

final recentAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getRecentlyUnlocked();
});

/// Category-specific providers
final battleAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.battle);
});

final powerEnemyAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.powerEnemy);
});

final speedAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.speed);
});

final efficiencyAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.efficiency);
});

final collectionAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.collection);
});

final progressionAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.progression);
});

final specialAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByCategory(AchievementCategory.special);
});

/// Type-specific providers
final milestoneAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByType(AchievementType.milestone);
});

final cumulativeAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByType(AchievementType.cumulative);
});

final streakAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getAchievementsByType(AchievementType.streak);
});

/// Achievement statistics providers
final totalAchievementsProvider = Provider<int>((ref) {
  return ref.watch(achievementProvider).length;
});

final unlockedCountProvider = Provider<int>((ref) {
  return ref.watch(unlockedAchievementsProvider).length;
});

final lockedCountProvider = Provider<int>((ref) {
  return ref.watch(lockedAchievementsProvider).length;
});