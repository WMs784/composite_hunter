import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../providers/achievement_provider.dart';
import '../../../domain/entities/achievement.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';

class AchievementScreen extends ConsumerWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final battleAchievements = ref.watch(battleAchievementsProvider);
    final speedAchievements = ref.watch(speedAchievementsProvider);
    final specialAchievements = ref.watch(specialAchievementsProvider);
    final collectionAchievements = ref.watch(collectionAchievementsProvider);
    final completionPercentage = ref.watch(achievementCompletionProvider);
    final totalCount = ref.watch(totalAchievementsProvider);
    final unlockedCount = ref.watch(unlockedCountProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.achievements),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.paddingM),
        children: [
          _buildProgressSummary(l10n, completionPercentage, unlockedCount, totalCount),
          
          const SizedBox(height: Dimensions.spacingL),
          
          if (battleAchievements.isNotEmpty) ...[
            Text(
              l10n.battleAchievements,
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: Dimensions.spacingM),
            ...battleAchievements.map((achievement) => _buildAchievementItem(achievement)),
            const SizedBox(height: Dimensions.spacingL),
          ],
          
          if (speedAchievements.isNotEmpty) ...[
            Text(
              l10n.speedAchievements,
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: Dimensions.spacingM),
            ...speedAchievements.map((achievement) => _buildAchievementItem(achievement)),
            const SizedBox(height: Dimensions.spacingL),
          ],
          
          if (collectionAchievements.isNotEmpty) ...[
            Text(
              l10n.primeCollector, // 適切な既存のローカライゼーションキーを使用
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: Dimensions.spacingM),
            ...collectionAchievements.map((achievement) => _buildAchievementItem(achievement)),
            const SizedBox(height: Dimensions.spacingL),
          ],
          
          if (specialAchievements.isNotEmpty) ...[
            Text(
              l10n.specialAchievements,
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: Dimensions.spacingM),
            ...specialAchievements.map((achievement) => _buildAchievementItem(achievement)),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressSummary(AppLocalizations l10n, double progress, int unlockedCount, int totalCount) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: AppColors.victoryGreen,
                  size: Dimensions.iconL,
                ),
                const SizedBox(width: Dimensions.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.achievementProgress,
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: Dimensions.spacingXs),
                      Text(
                        l10n.achievementsUnlocked(unlockedCount.toString(), totalCount.toString()),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.victoryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: Dimensions.spacingM),
            
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.victoryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(Achievement achievement) {
    final progressValue = achievement.targetValue > 0 
        ? achievement.currentProgress / achievement.targetValue 
        : 0.0;
    final icon = _getIconForAchievement(achievement);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.spacingXs),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingM),
        child: Row(
          children: [
            // Achievement icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: achievement.isUnlocked 
                    ? AppColors.victoryGreen.withOpacity(0.1)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
                border: achievement.isUnlocked 
                    ? Border.all(color: AppColors.victoryGreen, width: 2)
                    : null,
              ),
              child: Icon(
                icon,
                color: achievement.isUnlocked 
                    ? AppColors.victoryGreen 
                    : AppColors.onSurfaceVariant,
                size: Dimensions.iconL,
              ),
            ),
            
            const SizedBox(width: Dimensions.spacingM),
            
            // Achievement details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: achievement.isUnlocked 
                          ? AppColors.onSurface 
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(height: Dimensions.spacingXs),
                  
                  Text(
                    achievement.description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  
                  if (!achievement.isUnlocked) ...[
                    const SizedBox(height: Dimensions.spacingS),
                    
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progressValue,
                            backgroundColor: AppColors.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.spacingS),
                        Text(
                          '${achievement.currentProgress}/${achievement.targetValue}',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // Status indicator
            if (achievement.isUnlocked)
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingS),
                decoration: BoxDecoration(
                  color: AppColors.victoryGreen,
                  borderRadius: BorderRadius.circular(Dimensions.radiusRound),
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.onPrimary,
                  size: Dimensions.iconS,
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingS),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(Dimensions.radiusRound),
                ),
                child: Icon(
                  Icons.lock,
                  color: AppColors.onSurfaceVariant,
                  size: Dimensions.iconS,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForAchievement(Achievement achievement) {
    switch (achievement.id) {
      case 'first_victory':
        return Icons.emoji_events;
      case 'battle_veteran':
        return Icons.military_tech;
      case 'victory_streak_10':
      case 'victory_streak_25':
        return Icons.trending_up;
      case 'power_hunter':
      case 'power_slayer':
        return Icons.auto_awesome;
      case 'speed_demon':
      case 'lightning_fast':
        return Icons.flash_on;
      case 'efficient_hunter':
      case 'minimalist':
        return Icons.speed;
      case 'collector':
      case 'hoarder':
      case 'large_prime_collector':
        return Icons.collections;
      case 'level_up_10':
      case 'level_up_25':
      case 'level_up_50':
        return Icons.trending_up;
      case 'perfect_battle':
        return Icons.verified;
      case 'giant_slayer':
        return Icons.shield;
      case 'comeback_king':
        return Icons.access_time;
      default:
        return Icons.star;
    }
  }
}