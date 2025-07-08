import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.paddingM),
        children: [
          _buildProgressSummary(),
          
          const SizedBox(height: Dimensions.spacingL),
          
          Text(
            'Battle Achievements',
            style: AppTextStyles.titleLarge,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          _buildAchievementItem(
            title: 'First Victory',
            description: 'Win your first battle',
            icon: Icons.emoji_events,
            isUnlocked: true,
            progress: 1,
            target: 1,
          ),
          
          _buildAchievementItem(
            title: 'Prime Hunter',
            description: 'Win 10 battles',
            icon: Icons.gps_fixed,
            isUnlocked: true,
            progress: 10,
            target: 10,
          ),
          
          _buildAchievementItem(
            title: 'Composite Crusher',
            description: 'Win 50 battles',
            icon: Icons.military_tech,
            isUnlocked: false,
            progress: 23,
            target: 50,
          ),
          
          const SizedBox(height: Dimensions.spacingL),
          
          Text(
            'Speed Achievements',
            style: AppTextStyles.titleLarge,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          _buildAchievementItem(
            title: 'Lightning Fast',
            description: 'Win a battle in under 10 seconds',
            icon: Icons.flash_on,
            isUnlocked: false,
            progress: 0,
            target: 1,
          ),
          
          _buildAchievementItem(
            title: 'Speed Demon',
            description: 'Win 5 battles in under 15 seconds each',
            icon: Icons.rocket_launch,
            isUnlocked: false,
            progress: 2,
            target: 5,
          ),
          
          const SizedBox(height: Dimensions.spacingL),
          
          Text(
            'Special Achievements',
            style: AppTextStyles.titleLarge,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          _buildAchievementItem(
            title: 'Power Hunter',
            description: 'Defeat 10 power enemies',
            icon: Icons.auto_awesome,
            isUnlocked: false,
            progress: 3,
            target: 10,
          ),
          
          _buildAchievementItem(
            title: 'Perfect Victory',
            description: 'Win without any wrong claims or escapes',
            icon: Icons.verified,
            isUnlocked: true,
            progress: 1,
            target: 1,
          ),
          
          _buildAchievementItem(
            title: 'Prime Collector',
            description: 'Collect 25 different prime numbers',
            icon: Icons.collections,
            isUnlocked: false,
            progress: 8,
            target: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSummary() {
    const totalAchievements = 8;
    const unlockedAchievements = 3;
    const progress = unlockedAchievements / totalAchievements;
    
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
                        'Achievement Progress',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: Dimensions.spacingXs),
                      Text(
                        '$unlockedAchievements of $totalAchievements unlocked',
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

  Widget _buildAchievementItem({
    required String title,
    required String description,
    required IconData icon,
    required bool isUnlocked,
    required int progress,
    required int target,
  }) {
    final progressValue = target > 0 ? progress / target : 0.0;
    
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
                color: isUnlocked 
                    ? AppColors.victoryGreen.withOpacity(0.1)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
                border: isUnlocked 
                    ? Border.all(color: AppColors.victoryGreen, width: 2)
                    : null,
              ),
              child: Icon(
                icon,
                color: isUnlocked 
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
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: isUnlocked 
                          ? AppColors.onSurface 
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(height: Dimensions.spacingXs),
                  
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  
                  if (!isUnlocked) ...[
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
                          '$progress/$target',
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
            if (isUnlocked)
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
}