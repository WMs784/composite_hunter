import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../../domain/entities/stage.dart';
import '../../widgets/animated_stars.dart';
import '../../providers/stage_progress_provider.dart';

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
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _starsController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Save stage progress
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stageProgressProvider.notifier).completeStage(widget.clearResult);
    });
    
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
    
    // アニメーションを開始
    _mainController.forward();
    
    // 星のアニメーションを遅らせて開始
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _starsController.forward();
      }
    });
  }

  @override
  void dispose() {
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
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 勝利アイコン
            Container(
              width: 120,
              height: 120,
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
                size: 60,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: Dimensions.spacingXl),
            
            // ステージクリアテキスト
            Text(
              'Stage ${widget.clearResult.stageNumber} Clear!',
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
                return AnimatedStars(
                  stars: widget.clearResult.stars,
                  animation: _starsController,
                );
              },
            ),
            
            const SizedBox(height: Dimensions.spacingXl),
            
            // 結果詳細
            _buildResultDetails(),
            
            const SizedBox(height: Dimensions.spacingXl),
            
            // ボーナス情報
            if (widget.clearResult.isPerfect || widget.clearResult.isNewRecord)
              _buildBonusInfo(),
            
            const SizedBox(height: Dimensions.spacingXl),
            
            // ボタン
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDetails() {
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
            label: 'Victories',
            value: '${widget.clearResult.victories}',
            color: AppColors.victoryGreen,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          _buildResultRow(
            icon: Icons.timer,
            label: 'Total Time',
            value: _formatDuration(widget.clearResult.totalTime),
            color: AppColors.primary,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          _buildResultRow(
            icon: Icons.star,
            label: 'Score',
            value: '${widget.clearResult.score}',
            color: Colors.amber,
          ),
          
          if (widget.clearResult.escapes > 0) ...[
            const SizedBox(height: Dimensions.spacingM),
            _buildResultRow(
              icon: Icons.directions_run,
              label: 'Escapes',
              value: '${widget.clearResult.escapes}',
              color: AppColors.timerWarning,
            ),
          ],
          
          if (widget.clearResult.wrongClaims > 0) ...[
            const SizedBox(height: Dimensions.spacingM),
            _buildResultRow(
              icon: Icons.error,
              label: 'Wrong Claims',
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

  Widget _buildBonusInfo() {
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
          Icon(
            Icons.celebration,
            color: Colors.amber,
            size: 32,
          ),
          
          const SizedBox(height: Dimensions.spacingS),
          
          if (widget.clearResult.isPerfect) ...[
            Text(
              'Perfect Clear!',
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.amber[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'No escapes or wrong claims!',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.amber[600],
              ),
            ),
          ],
          
          if (widget.clearResult.isNewRecord) ...[
            if (widget.clearResult.isPerfect)
              const SizedBox(height: Dimensions.spacingS),
            Text(
              'New Record!',
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.amber[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your best performance yet!',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.amber[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // 次のステージボタン
        if (widget.clearResult.stageNumber < 4)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _goToNextStage(context),
              icon: const Icon(Icons.arrow_forward),
              label: Text('Next Stage'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingM),
              ),
            ),
          ),
        
        const SizedBox(height: Dimensions.spacingM),
        
        // ステージ選択に戻るボタン
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _goToStageSelect(context),
            icon: const Icon(Icons.list),
            label: const Text('Stage Select'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingM),
            ),
          ),
        ),
        
        const SizedBox(height: Dimensions.spacingS),
        
        // もう一度プレイボタン
        TextButton.icon(
          onPressed: () => _retryStage(context),
          icon: const Icon(Icons.refresh),
          label: const Text('Play Again'),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }

  void _goToNextStage(BuildContext context) {
    // 次のステージに進む処理
    Navigator.pop(context);
    // TODO: 次のステージの実装
  }

  void _goToStageSelect(BuildContext context) {
    AppRouter.goToStageSelect(context);
  }

  void _retryStage(BuildContext context) {
    Navigator.pop(context);
    AppRouter.goToBattle(context);
  }
}