import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../../domain/entities/stage.dart';
import '../../widgets/animated_stars.dart';
import '../../providers/stage_progress_provider.dart';
import '../common/result_screen_base.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../game_over/game_over_screen.dart'; // For LocalizedResultScreenButtons

class StageClearScreen extends ConsumerStatefulWidget {
  final StageClearResult clearResult;

  const StageClearScreen({
    super.key,
    required this.clearResult,
  });

  @override
  ConsumerState<StageClearScreen> createState() => _StageClearScreenState();
}

class _StageClearScreenState extends ConsumerState<StageClearScreen>
    with TickerProviderStateMixin, ResultScreenMixin {
  late AnimationController _mainController;
  late AnimationController _starsController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers first
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _starsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    // Save stage progress and start animations after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Save stage progress
        ref
            .read(stageProgressProvider.notifier)
            .completeStage(widget.clearResult);

        // Start main animation
        _mainController.forward();

        // Start star animation after delay
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted && _starsController.isCompleted == false) {
            _starsController.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Stop animations before disposing
    _mainController.stop();
    _starsController.stop();

    // Dispose controllers
    _mainController.dispose();
    _starsController.dispose();
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
            // Prevent layout errors during animation by ensuring valid animation values
            final fadeValue = _fadeAnimation.value.clamp(0.0, 1.0);
            final scaleValue = _scaleAnimation.value.clamp(0.1, 2.0);

            return Opacity(
              opacity: fadeValue,
              child: Transform.scale(
                scale: scaleValue,
                child: Transform.translate(
                  offset: _slideAnimation.value *
                      MediaQuery.of(context).size.height,
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
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.victoryGreen.withOpacity(0.1),
            AppColors.surface,
            AppColors.primaryContainer.withOpacity(0.1),
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
              // 勝利アイコン
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.victoryGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.victoryGreen.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 50,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: Dimensions.spacingL),

              // ステージクリアテキスト
              Text(
                l10n.stageClear(widget.clearResult.stageNumber.toString()),
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.victoryGreen,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: Dimensions.spacingM),

              // 星評価
              AnimatedBuilder(
                animation: _starsController,
                builder: (context, child) {
                  // Ensure animation is mounted and valid before building stars
                  if (!mounted ||
                      !_starsController.isAnimating &&
                          _starsController.value == 0.0) {
                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(widget.clearResult.stars, (index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 32,
                            );
                          }),
                        ),
                      ),
                    );
                  }
                  return AnimatedStars(
                    stars: widget.clearResult.stars,
                    animation: _starsController,
                  );
                },
              ),

              const SizedBox(height: Dimensions.spacingL),

              // 結果詳細
              _buildResultDetails(l10n),

              const SizedBox(height: Dimensions.spacingL),

              // ボーナス情報
              if (widget.clearResult.isPerfect ||
                  widget.clearResult.isNewRecord)
                _buildBonusInfo(l10n),

              const SizedBox(height: Dimensions.spacingL),

              // ボタン
              LocalizedResultScreenButtons(
                stageNumber: widget.clearResult.stageNumber,
                isPracticeMode: false,
                isSuccess: true,
                onNextStage: widget.clearResult.stageNumber < 4
                    ? () => goToNextStage(
                        context, ref, widget.clearResult.stageNumber)
                    : null,
                onStageSelect: () => goToStageSelect(context, ref),
                onRetry: () =>
                    retryStage(context, ref, widget.clearResult.stageNumber),
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

  Widget _buildResultDetails(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Dimensions.radiusL),
        border: Border.all(
          color: AppColors.outline.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          _buildResultRow(
            icon: Icons.emoji_events,
            label: l10n.victories,
            value: '${widget.clearResult.victories}',
            color: AppColors.victoryGreen,
          ),
          const SizedBox(height: Dimensions.spacingM),
          _buildResultRow(
            icon: Icons.timer,
            label: l10n.totalTime,
            value: _formatDuration(widget.clearResult.totalTime),
            color: AppColors.primary,
          ),
          const SizedBox(height: Dimensions.spacingM),
          _buildResultRow(
            icon: Icons.star,
            label: l10n.score,
            value: '${widget.clearResult.score}',
            color: Colors.amber,
          ),
          if (widget.clearResult.escapes > 0) ...[
            const SizedBox(height: Dimensions.spacingM),
            _buildResultRow(
              icon: Icons.directions_run,
              label: l10n.escapes,
              value: '${widget.clearResult.escapes}',
              color: AppColors.timerWarning,
            ),
          ],
          if (widget.clearResult.wrongClaims > 0) ...[
            const SizedBox(height: Dimensions.spacingM),
            _buildResultRow(
              icon: Icons.error,
              label: l10n.wrongClaims,
              value: '${widget.clearResult.wrongClaims}',
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
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: Dimensions.spacingM),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyLarge,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBonusInfo(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.withOpacity(0.1),
            Colors.amber.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(color: Colors.amber),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.celebration,
            color: Colors.amber,
            size: 32,
          ),
          const SizedBox(height: Dimensions.spacingS),
          if (widget.clearResult.isPerfect) ...[
            Text(
              l10n.perfectClear,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.amber[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              l10n.noEscapesOrWrongClaims,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.amber[600],
              ),
            ),
          ],
          if (widget.clearResult.isNewRecord) ...[
            if (widget.clearResult.isPerfect)
              const SizedBox(height: Dimensions.spacingS),
            Text(
              l10n.newRecord,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.amber[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              l10n.bestPerformance,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.amber[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
