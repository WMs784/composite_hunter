import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../providers/battle_session_provider.dart';
import '../common/result_screen_base.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';

enum GameOverReason { timeUp, noItems }

class GameOverScreen extends ConsumerStatefulWidget with ResultScreenMixin {
  final GameOverReason reason;
  final int? stageNumber;
  final bool isPracticeMode;

  const GameOverScreen({
    super.key,
    required this.reason,
    this.stageNumber,
    this.isPracticeMode = false,
  });

  @override
  ConsumerState<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends ConsumerState<GameOverScreen>
    with TickerProviderStateMixin, ResultScreenMixin {
  late AnimationController _mainController;
  late AnimationController _iconController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _iconController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _iconRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );

    // アニメーションを開始
    _mainController.forward();
    _iconController.repeat();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _mainController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildContent(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final session = ref.watch(battleSessionProvider);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.error.withValues(alpha: 0.1),
            AppColors.surface,
            AppColors.errorContainer.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingM),
          child: Column(
            children: [
              // Top spacing
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // ゲームオーバーアイコン
              AnimatedBuilder(
                animation: _iconController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _iconRotationAnimation.value * 0.1,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.error.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.reason == GameOverReason.timeUp
                            ? Icons.access_time
                            : Icons.inventory_2,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: Dimensions.spacingL),

              // ゲームオーバーテキスト
              Text(
                l10n.gameOver,
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: Dimensions.spacingM),

              // 理由の説明
              Text(
                _getReasonText(l10n),
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: Dimensions.spacingL),

              // セッション結果
              if (!session.isPracticeMode) _buildSessionResults(session, l10n),

              if (!session.isPracticeMode)
                const SizedBox(height: Dimensions.spacingL),

              // アドバイス
              _buildAdvice(l10n),

              const SizedBox(height: Dimensions.spacingL),

              // ボタン
              LocalizedResultScreenButtons(
                stageNumber: widget.stageNumber,
                isPracticeMode: widget.isPracticeMode,
                isSuccess: false,
                onStageSelect: () => goToStageSelect(context, ref),
                onRetry: () => _handleRetry(context),
                onPractice: () => goToPractice(context, ref),
              ),

              // Bottom spacing for scroll
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  String _getReasonText(AppLocalizations l10n) {
    switch (widget.reason) {
      case GameOverReason.timeUp:
        return l10n.timeRanOut;
      case GameOverReason.noItems:
        return l10n.noAvailableItems;
    }
  }

  Widget _buildSessionResults(
    BattleSessionState session,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(Dimensions.radiusL),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            widget.isPracticeMode
                ? l10n.practiceResults
                : l10n.stageResults(widget.stageNumber?.toString() ?? '?'),
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimensions.spacingM),
          _buildResultRow(
            icon: Icons.emoji_events,
            label: l10n.victories,
            value: '${session.victories}',
            color: AppColors.victoryGreen,
          ),
          const SizedBox(height: Dimensions.spacingS),
          _buildResultRow(
            icon: Icons.timer,
            label: l10n.timePlayed,
            value: _formatDuration(session.totalTime),
            color: AppColors.primary,
          ),
          if (session.escapes > 0) ...[
            const SizedBox(height: Dimensions.spacingS),
            _buildResultRow(
              icon: Icons.directions_run,
              label: l10n.escapes,
              value: '${session.escapes}',
              color: AppColors.timerWarning,
            ),
          ],
          if (session.wrongClaims > 0) ...[
            const SizedBox(height: Dimensions.spacingS),
            _buildResultRow(
              icon: Icons.error,
              label: l10n.wrongClaims,
              value: '${session.wrongClaims}',
              color: AppColors.error,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.radiusS),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: Dimensions.spacingM),
        Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAdvice(AppLocalizations l10n) {
    String advice;
    IconData icon;

    switch (widget.reason) {
      case GameOverReason.timeUp:
        advice = l10n.attackFasterTip;
        icon = Icons.speed;
        break;
      case GameOverReason.noItems:
        advice = l10n.collectMorePrimesTip;
        icon = Icons.inventory;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 32),
          const SizedBox(height: Dimensions.spacingS),
          Text(
            l10n.tip,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimensions.spacingS),
          Text(
            advice,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onPrimaryContainer,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleRetry(BuildContext context) {
    if (widget.isPracticeMode) {
      goToPractice(context, ref);
    } else if (widget.stageNumber != null) {
      retryStage(context, ref, widget.stageNumber!);
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

/// Localized version of ResultScreenButtons
class LocalizedResultScreenButtons extends StatelessWidget {
  final int? stageNumber;
  final bool isPracticeMode;
  final bool isSuccess;
  final VoidCallback? onNextStage;
  final VoidCallback onStageSelect;
  final VoidCallback onRetry;
  final VoidCallback onPractice;

  const LocalizedResultScreenButtons({
    super.key,
    this.stageNumber,
    this.isPracticeMode = false,
    this.isSuccess = false,
    this.onNextStage,
    required this.onStageSelect,
    required this.onRetry,
    required this.onPractice,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // 次のステージボタン（成功時かつ最終ステージでない場合のみ）
        if (isSuccess &&
            !isPracticeMode &&
            stageNumber != null &&
            stageNumber! < 4 &&
            onNextStage != null)
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onNextStage,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(l10n.nextStage),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingM,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.spacingM),
            ],
          ),

        // ステージ選択に戻るボタン
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onStageSelect,
            icon: const Icon(Icons.list),
            label: Text(l10n.stageSelect),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingM,
              ),
            ),
          ),
        ),

        const SizedBox(height: Dimensions.spacingM),

        // 再挑戦ボタン
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(isSuccess ? l10n.playAgain : l10n.tryAgain),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingM,
              ),
            ),
          ),
        ),

        const SizedBox(height: Dimensions.spacingS),

        // 練習モードボタン
        TextButton.icon(
          onPressed: onPractice,
          icon: const Icon(Icons.school),
          label: Text(l10n.practiceMode),
        ),
      ],
    );
  }
}
