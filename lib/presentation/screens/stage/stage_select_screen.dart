import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/stage_progress_provider.dart';
import '../../providers/inventory_provider.dart';
import '../battle/battle_screen.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/utils/logger.dart';

// ステージ情報
class StageInfo {
  final int stageNumber;
  final String title;
  final String description;
  final int enemyRangeMin;
  final int enemyRangeMax;
  final int timeLimit;
  final bool isUnlocked;
  final bool isCompleted;
  final int stars;

  const StageInfo({
    required this.stageNumber,
    required this.title,
    required this.description,
    required this.enemyRangeMin,
    required this.enemyRangeMax,
    required this.timeLimit,
    required this.isUnlocked,
    required this.isCompleted,
    required this.stars,
  });

  // 国際化対応のためのローカライズされたタイトルを取得
  String getLocalizedTitle(AppLocalizations l10n) {
    switch (stageNumber) {
      case 1:
        return l10n.stage1Title;
      case 2:
        return l10n.stage2Title;
      case 3:
        return l10n.stage3Title;
      case 4:
        return l10n.stage4Title;
      default:
        return title;
    }
  }

  // 国際化対応のためのローカライズされた説明を取得
  String getLocalizedDescription(AppLocalizations l10n) {
    switch (stageNumber) {
      case 1:
        return l10n.stage1Description;
      case 2:
        return l10n.stage2Description;
      case 3:
        return l10n.stage3Description;
      case 4:
        return l10n.stage4Description;
      default:
        return description;
    }
  }
}

class StageSelectScreen extends ConsumerStatefulWidget {
  const StageSelectScreen({super.key});

  @override
  ConsumerState<StageSelectScreen> createState() => _StageSelectScreenState();
}

class _StageSelectScreenState extends ConsumerState<StageSelectScreen> {
  @override
  void initState() {
    super.initState();
    // ステージ選択画面に入った時点でバトルセッションをリセット
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(battleSessionProvider.notifier).resetSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stages = ref.watch(stageProgressProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stageSelect),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory),
            onPressed: () => AppRouter.goToInventory(context),
            tooltip: l10n.inventory,
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () => AppRouter.goToAchievements(context),
            tooltip: l10n.achievements,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetInventory(),
            tooltip: l10n.resetInventory,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ヘッダー
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Dimensions.paddingL),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radiusL),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appTitle,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spacingS),
                    Text(
                      l10n.chooseChallenge,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Dimensions.spacingL),

              // ステージリスト
              Expanded(
                child: ListView.builder(
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stage = stages[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: Dimensions.spacingM),
                      child: _StageCard(
                        stage: stage,
                        l10n: l10n,
                        onTap:
                            stage.isUnlocked ? () => _startStage(stage) : null,
                      ),
                    );
                  },
                ),
              ),

              // 練習モードボタン
              const SizedBox(height: Dimensions.spacingM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _startPracticeMode(),
                  icon: const Icon(Icons.school),
                  label: Text(l10n.practiceMode),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingM),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startStage(StageInfo stage) {
    Logger.info('Starting stage ${stage.stageNumber}: ${stage.title}');
    // アイテム選択画面に遷移
    AppRouter.goToStageItemSelection(context, stage);
  }

  void _startPracticeMode() {
    Logger.info('Starting practice mode');
    // 現在のアイテム状態を取得
    final currentInventory = ref.read(inventoryProvider);
    // 練習モードでバトルセッションを開始（アイテム状態を保存）
    ref.read(battleSessionProvider.notifier).startPractice(currentInventory);
    // バトル画面に遷移
    AppRouter.goToBattle(context);
  }

  void _resetInventory() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.resetGameData),
        content: Text(l10n.resetConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                // Reset battle session first
                ref.read(battleSessionProvider.notifier).resetSession();

                // Reset battle screen providers
                ref.read(battleEnemyProvider.notifier).state = 12;
                ref.read(battleTimerProvider.notifier).state = 90;

                // Reset inventory
                await ref.read(inventoryProvider.notifier).resetInventory();

                // Reset stage progress
                await ref.read(stageProgressProvider.notifier).resetProgress();

                // Wait a bit for providers to update
                await Future.delayed(const Duration(milliseconds: 100));

                // Force UI refresh by triggering a rebuild
                if (mounted) {
                  setState(() {});
                }

                // Additional delay before showing message
                await Future.delayed(const Duration(milliseconds: 100));

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.gameDataResetSuccess),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                Logger.error('Error during reset: $e');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.errorDuringReset(e.toString())),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final StageInfo stage;
  final AppLocalizations l10n;
  final VoidCallback? onTap;

  const _StageCard({
    required this.stage,
    required this.l10n,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = !stage.isUnlocked;

    return Card(
      elevation: isLocked ? 1 : 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
            color: isLocked ? AppColors.surfaceVariant.withOpacity(0.5) : null,
          ),
          child: Row(
            children: [
              // ステージ番号とアイコン
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isLocked
                      ? AppColors.outline
                      : (stage.isCompleted
                          ? AppColors.victoryGreen
                          : AppColors.primary),
                  borderRadius: BorderRadius.circular(Dimensions.radiusM),
                ),
                child: Center(
                  child: isLocked
                      ? const Icon(
                          Icons.lock,
                          color: AppColors.onSurfaceVariant,
                          size: 24,
                        )
                      : Text(
                          stage.stageNumber.toString(),
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(width: Dimensions.spacingM),

              // ステージ情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            stage.getLocalizedTitle(l10n),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: isLocked
                                  ? AppColors.onSurfaceVariant
                                  : AppColors.onSurface,
                            ),
                          ),
                        ),
                        if (stage.isCompleted) _buildStars(stage.stars),
                      ],
                    ),
                    const SizedBox(height: Dimensions.spacingXs),
                    Text(
                      stage.getLocalizedDescription(l10n),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isLocked
                            ? AppColors.onSurfaceVariant.withOpacity(0.7)
                            : AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spacingS),
                    if (!isLocked) ...[
                      Row(
                        children: [
                          _buildInfoChip(
                            Icons.numbers,
                            '${stage.enemyRangeMin}-${stage.enemyRangeMax}',
                          ),
                          const SizedBox(width: Dimensions.spacingS),
                          _buildInfoChip(
                            Icons.timer,
                            '${stage.timeLimit}s',
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // 進行状況インジケーター
              if (!isLocked)
                Icon(
                  stage.isCompleted ? Icons.check_circle : Icons.play_arrow,
                  color: stage.isCompleted
                      ? AppColors.victoryGreen
                      : AppColors.primary,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStars(int stars) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: index < stars ? Colors.amber : AppColors.outline,
          size: 16,
        );
      }),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingS,
        vertical: Dimensions.paddingXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.onPrimaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
