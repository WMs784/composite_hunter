import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/stage_progress_provider.dart';
import '../../providers/inventory_provider.dart';

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
      ref.read(battleSessionProvider.notifier).resetSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stages = ref.watch(stageProgressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stage Select'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory),
            onPressed: () => AppRouter.goToInventory(context),
            tooltip: 'Inventory',
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () => AppRouter.goToAchievements(context),
            tooltip: 'Achievements',
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
                  gradient: LinearGradient(
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
                      'Composite Hunter',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spacingS),
                    Text(
                      'Choose your challenge stage',
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
                      padding: const EdgeInsets.only(bottom: Dimensions.spacingM),
                      child: _StageCard(
                        stage: stage,
                        onTap: stage.isUnlocked
                            ? () => _startStage(stage)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              
              // 練習モードボタン
              const SizedBox(height: Dimensions.spacingM),
              Container(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _startPracticeMode(),
                  icon: const Icon(Icons.school),
                  label: const Text('Practice Mode'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingM),
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
    print('Starting stage ${stage.stageNumber}: ${stage.title}');
    // 現在のアイテム状態を取得
    final currentInventory = ref.read(inventoryProvider);
    // バトルセッションを開始（アイテム状態を保存）
    ref.read(battleSessionProvider.notifier).startStage(stage.stageNumber, currentInventory);
    // バトル画面に遷移
    AppRouter.goToBattle(context);
  }

  void _startPracticeMode() {
    print('Starting practice mode');
    // 現在のアイテム状態を取得
    final currentInventory = ref.read(inventoryProvider);
    // 練習モードでバトルセッションを開始（アイテム状態を保存）
    ref.read(battleSessionProvider.notifier).startPractice(currentInventory);
    // バトル画面に遷移
    AppRouter.goToBattle(context);
  }
}

class _StageCard extends StatelessWidget {
  final StageInfo stage;
  final VoidCallback? onTap;

  const _StageCard({
    required this.stage,
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
            color: isLocked 
                ? AppColors.surfaceVariant.withOpacity(0.5)
                : null,
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
                            stage.title,
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
                      stage.description,
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
                  stage.isCompleted 
                      ? Icons.check_circle
                      : Icons.play_arrow,
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