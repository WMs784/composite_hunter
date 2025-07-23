import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:math';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../widgets/battle_menu_dialog.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/prime_usage_provider.dart';
import '../../../domain/entities/prime.dart';
import '../stage/stage_clear_screen.dart';
import '../game_over/game_over_screen.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/utils/logger.dart';

// Simple working providers for battle screen
final battleEnemyProvider = StateProvider<int>((ref) => 12);
final battleTimerProvider = StateProvider<int>((ref) => 90);

// Recently acquired primes (for visual feedback)
final recentlyAcquiredPrimesProvider =
    StateProvider<Map<int, DateTime>>((ref) => {});

class BattleScreen extends ConsumerStatefulWidget {
  const BattleScreen({super.key});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize battle state and start timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Logger.info('Battle screen initialized');
        _initializeBattleForStage();
        final session = ref.read(battleSessionProvider);
        if (!session.isPracticeMode) {
          _startTimer();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    final initialTime = ref.read(battleTimerProvider);
    Logger.logTimer('Starting timer', seconds: initialTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // mountedチェックを追加
      if (!mounted) {
        Logger.warning('Widget not mounted, cancelling timer');
        timer.cancel();
        return;
      }

      // 直接的な状態更新
      final currentTime = ref.read(battleTimerProvider);
      if (currentTime > 0) {
        final newTime = currentTime - 1;
        ref.read(battleTimerProvider.notifier).state = newTime;
        Logger.logTimer('Timer updated', seconds: newTime);
      } else {
        Logger.logTimer('Timer reached 0, handling time up');
        _handleTimeUp();
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _handleTimeUp() {
    final session = ref.read(battleSessionProvider);

    // 練習モードでは時間切れ処理をしない
    if (session.isPracticeMode) {
      return;
    }

    // Stop timer
    _stopTimer();

    // アイテム状態をステージ開始時に復元
    _restoreInventoryWithAnimation();

    // ゲームオーバー画面に遷移
    _goToGameOver(GameOverReason.timeUp);
  }

  void _showBattleMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BattleMenuDialog(
        onRestart: _restartBattle,
        onExit: _exitBattle,
      ),
    );
  }

  void _goToGameOver(GameOverReason reason) {
    final session = ref.read(battleSessionProvider);

    // Finalize used items at stage end (game over)
    if (!session.isPracticeMode) {
      ref
          .read(inventoryProvider.notifier)
          .finalizeUsedItems(session.usedPrimesInCurrentBattle);
    }

    // Reset used primes at stage end (game over)
    ref.read(battleSessionProvider.notifier).resetUsedPrimes();

    // Clear temporary rewards (game over)
    ref.read(battleTempRewardsProvider.notifier).clearTempRewards();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          reason: reason,
          stageNumber: session.stageNumber,
          isPracticeMode: session.isPracticeMode,
        ),
      ),
    );
  }

  bool _hasAvailableItems(int enemy) {
    final primes = ref.read(battleInventoryProvider);
    return primes.any((prime) => prime.count > 0 && enemy % prime.value == 0);
  }

  void _checkGameOverConditions() {
    final enemy = ref.read(battleEnemyProvider);
    final session = ref.read(battleSessionProvider);

    // 素数になったら攻撃できないのでゲームオーバーチェックをスキップ
    if (_isPrime(enemy)) return;

    // 練習モードではアイテム不足でゲームオーバーにならない
    if (session.isPracticeMode) return;

    // 使用可能なアイテムがあるかチェック
    if (!_hasAvailableItems(enemy)) {
      _stopTimer();

      // アイテム不足時もアイテム状態を復元
      _restoreInventoryWithAnimation();

      _goToGameOver(GameOverReason.noItems);
    }
  }

  void _initializeBattleForStage() {
    final session = ref.read(battleSessionProvider);

    // ステージに応じた敵と制限時間を設定
    if (session.isPracticeMode) {
      // 練習モードはタイマーなし
      final enemy = _generateEnemyForRange(6, 20);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      // 練習モードではタイマーを設定しない
      Logger.logBattle('Practice mode initialized',
          data: {'enemy': enemy, 'timer': 'disabled'});
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, timeLimit) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      ref.read(battleTimerProvider.notifier).state = timeLimit;
      Logger.logBattle('Stage initialized',
          data: {'stage': stageNumber, 'enemy': enemy, 'timer': timeLimit});
    }
  }

  (int, int) _getStageSettings(int stageNumber) {
    switch (stageNumber) {
      case 1:
        return (_generateEnemyForRange(6, 20), 30);
      case 2:
        return (_generateEnemyForRange(21, 100), 60);
      case 3:
        return (_generateEnemyForRange(101, 1000), 90);
      case 4:
        return (_generateEnemyForRange(1001, 10000), 120);
      default:
        return (_generateEnemyForRange(6, 20), 30);
    }
  }

  int _generateEnemyForRange(int min, int max) {
    final random = Random();
    int candidate;
    int attempts = 0;
    const maxAttempts = 100; // 無限ループを防ぐ

    // 合成数を生成するまで繰り返す（最大試行回数制限付き）
    do {
      candidate = min + random.nextInt(max - min + 1);
      attempts++;

      if (attempts >= maxAttempts) {
        // フォールバック：既知の合成数を返す
        return _getFallbackComposite(min, max);
      }
    } while (_isPrime(candidate) || candidate <= 1);

    return candidate;
  }

  /// フォールバック用の合成数を取得
  int _getFallbackComposite(int min, int max) {
    // 範囲に応じて既知の合成数を返す
    final composites = <int>[
      4,
      6,
      8,
      9,
      10,
      12,
      14,
      15,
      16,
      18,
      20,
      21,
      22,
      24,
      25,
      26,
      27,
      28,
      30,
      32,
      33,
      34,
      35,
      36,
      38,
      39,
      40,
      42,
      44,
      45,
      46,
      48,
      49,
      50,
      51,
      52,
      54,
      55,
      56,
      57,
      58,
      60,
      62,
      63,
      64,
      65,
      66,
      68,
      69,
      70,
      72,
      74,
      75,
      76,
      77,
      78,
      80,
      81,
      82,
      84,
      85,
      86,
      87,
      88,
      90,
      91,
      92,
      93,
      94,
      95,
      96,
      98,
      99,
      100
    ];

    // 範囲内の合成数を探す
    final validComposites =
        composites.where((c) => c >= min && c <= max).toList();

    if (validComposites.isNotEmpty) {
      final random = Random();
      return validComposites[random.nextInt(validComposites.length)];
    }

    // 範囲内に適切な合成数がない場合、最小の合成数を生成
    for (int i = min >= 4 ? min : 4; i <= max; i++) {
      if (!_isPrime(i)) {
        return i;
      }
    }

    // 最後の手段：確実に合成数である値を返す
    return min >= 4 ? min : 4;
  }

  void _generateNewEnemy() {
    final session = ref.read(battleSessionProvider);

    if (session.isPracticeMode) {
      // 練習モードはデフォルト設定
      ref.read(battleEnemyProvider.notifier).state =
          _generateEnemyForRange(6, 20);
      ref.read(battleTimerProvider.notifier).state = 30;
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, timeLimit) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      ref.read(battleTimerProvider.notifier).state = timeLimit;
    }
  }

  void _generateNewEnemyWithoutTimeReset() {
    final session = ref.read(battleSessionProvider);

    if (session.isPracticeMode) {
      // 練習モードは敵のみ生成、タイマーはそのまま
      ref.read(battleEnemyProvider.notifier).state =
          _generateEnemyForRange(6, 20);
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, _) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      // タイマーはリセットしない
    }
  }

  void _restartBattle() {
    Logger.logBattle('Restarting battle');

    // アイテム状態をステージ開始時に復元
    _restoreInventoryWithAnimation();

    // Reset battle
    _initializeBattleForStage();

    // Reset used primes for current battle
    ref.read(battleSessionProvider.notifier).resetUsedPrimes();

    // Restart timer
    _startTimer();

    // User feedback
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.battleRestarted),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _exitBattle() {
    Logger.logBattle('Exiting battle');
    // Stop timer before exiting
    _stopTimer();

    // アイテム状態をステージ開始時に復元
    _restoreInventoryWithAnimation();

    // Reset battle session before returning to stage selection
    ref.read(battleSessionProvider.notifier).resetSession();
    // Return to stage selection screen
    AppRouter.goToStageSelect(context);
  }

  /// アイテム復元処理（アニメーション付き）
  Future<void> _restoreInventoryWithAnimation() async {
    final session = ref.read(battleSessionProvider);
    if (session.originalMainInventory != null) {
      // 復元アニメーション開始
      _playRestoreAnimation();

      // アイテム状態を復元
      ref
          .read(inventoryProvider.notifier)
          .restoreInventory(session.originalMainInventory!);

      Logger.logInventory('Inventory restored',
          count: session.originalMainInventory!.length);
    }
  }

  /// 復元アニメーション（視覚的フィードバック）
  Future<void> _playRestoreAnimation() async {
    // 簡単な視覚的フィードバック
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.restore, color: Colors.white),
            SizedBox(width: 8),
            Text('Items restored to starting state'),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 1),
      ),
    );

    // 短時間の遅延でアニメーション効果を演出
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// 無効攻撃時の教育的フィードバック
  void _showInvalidAttackFeedback(BuildContext context, int prime, int enemy) {
    // まず素因数を計算
    final factors = _getFactors(enemy);
    final factorsText =
        factors.isNotEmpty ? factors.join(' × ') : 'No factors found';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.timerWarning,
              size: 24,
            ),
            SizedBox(width: 8),
            Text('Attack Failed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prime $prime cannot attack enemy $enemy.',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Why?',
              style: AppTextStyles.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              '$enemy is not divisible by $prime.',
              style: AppTextStyles.bodySmall,
            ),
            if (enemy % prime != 0) ...[
              const SizedBox(height: 4),
              Text(
                '$enemy ÷ $prime = ${enemy / prime} (not a whole number)',
                style: AppTextStyles.bodySmall.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Text(
              'Enemy\'s prime factors:',
              style: AppTextStyles.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              '$enemy = $factorsText',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try using one of these factors instead!',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );

    // 振動フィードバック（無効攻撃を示す）
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.block, color: Colors.white),
            const SizedBox(width: 8),
            Text('Prime $prime wasted! $enemy ÷ $prime is not a whole number.'),
          ],
        ),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 素因数分解を実行
  List<int> _getFactors(int n) {
    List<int> factors = [];
    int temp = n;

    // 2で割り切れる限り割る
    while (temp % 2 == 0) {
      factors.add(2);
      temp ~/= 2;
    }

    // 3以上の奇数で割る
    for (int i = 3; i * i <= temp; i += 2) {
      while (temp % i == 0) {
        factors.add(i);
        temp ~/= i;
      }
    }

    // tempが素数の場合
    if (temp > 2) {
      factors.add(temp);
    }

    return factors;
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(battleSessionProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(session.isPracticeMode
            ? l10n.practiceMode
            : l10n.stage(session.stageNumber?.toString() ?? '?')),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showBattleMenu(context),
          tooltip: 'Menu',
        ),
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
            children: [
              // Session progress (only for stage mode)
              if (!session.isPracticeMode) const _SessionProgressSection(),

              if (!session.isPracticeMode)
                const SizedBox(height: Dimensions.spacingM),

              // Timer display (only in stage mode)
              if (!session.isPracticeMode) const _TimerSection(),

              const SizedBox(height: Dimensions.spacingL),

              // Enemy display
              const Expanded(
                flex: 2,
                child: _EnemySection(),
              ),

              const SizedBox(height: Dimensions.spacingL),

              // Prime grid
              Expanded(
                flex: 3,
                child: _PrimeGridSection(
                  onGameOverCheck: _checkGameOverConditions,
                  onInvalidAttack: _showInvalidAttackFeedback,
                ),
              ),

              const SizedBox(height: Dimensions.spacingL),

              // Action buttons
              _ActionButtonsSection(
                onRestartTimer: _startTimer,
                onStopTimer: _stopTimer,
                onGenerateNewEnemy: _generateNewEnemy,
                onGenerateNewEnemyWithoutTimeReset:
                    _generateNewEnemyWithoutTimeReset,
                onRestoreInventory: _restoreInventoryWithAnimation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionProgressSection extends ConsumerWidget {
  const _SessionProgressSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(battleSessionProvider);
    final l10n = AppLocalizations.of(context)!;

    if (session.stageNumber == null || session.isPracticeMode) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events,
            color: AppColors.onPrimaryContainer,
            size: 20,
          ),
          const SizedBox(width: Dimensions.spacingS),
          Expanded(
            child: Text(
              '${l10n.victories}: ${session.victories}',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onPrimaryContainer,
              ),
            ),
          ),
          if (session.escapes > 0) ...[
            const Icon(
              Icons.directions_run,
              color: AppColors.error,
              size: 16,
            ),
            Text(
              '${session.escapes}',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: Dimensions.spacingS),
          ],
          if (session.wrongClaims > 0) ...[
            const Icon(
              Icons.error,
              color: AppColors.timerWarning,
              size: 16,
            ),
            Text(
              '${session.wrongClaims}',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.timerWarning,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimerSection extends ConsumerWidget {
  const _TimerSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(battleTimerProvider);
    final minutes = timer ~/ 60;
    final seconds = timer % 60;
    final formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    final l10n = AppLocalizations.of(context)!;

    Color timerColor = AppColors.timerNormal;
    Color backgroundColor = AppColors.surface;

    if (timer <= 10) {
      timerColor = AppColors.timerCritical;
      backgroundColor = AppColors.timerCritical.withValues(alpha: 0.1);
    } else if (timer <= 30) {
      timerColor = AppColors.timerWarning;
      backgroundColor = AppColors.timerWarning.withValues(alpha: 0.1);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final baseFontSize = screenWidth < 350 ? 20.0 : 24.0;
    final criticalFontSize = screenWidth < 350 ? 24.0 : 28.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 60,
        maxHeight: 100,
      ),
      padding: EdgeInsets.symmetric(
        horizontal:
            screenWidth < 350 ? Dimensions.paddingS : Dimensions.paddingM,
        vertical: Dimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(
          color: timer <= 10 ? timerColor : AppColors.outline,
          width: timer <= 10 ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: AppTextStyles.timerDisplay.copyWith(
                color: timerColor,
                fontSize: timer <= 10 ? criticalFontSize : baseFontSize,
                fontWeight: timer <= 10 ? FontWeight.w900 : FontWeight.bold,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(formattedTime),
              ),
            ),
          ),
          const SizedBox(height: Dimensions.spacingXs),
          Flexible(
            child: Text(
              l10n.timeRemaining,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: screenWidth < 350 ? 10 : 11,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _EnemySection extends ConsumerWidget {
  const _EnemySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(battleEnemyProvider);
    final isPrime = _isPrime(enemy);
    final session = ref.watch(battleSessionProvider);
    final l10n = AppLocalizations.of(context)!;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // レスポンシブな敵表示サイズ
    final enemyDisplaySize = screenWidth < 350
        ? Dimensions.enemyDisplaySize * 0.7
        : screenHeight < 600
            ? Dimensions.enemyDisplaySize * 0.8
            : Dimensions.enemyDisplaySize;

    // 敵の数値の桁数に応じたフォントサイズ調整
    final enemyString = enemy.toString();
    final baseFontSize = AppTextStyles.enemyValue.fontSize ?? 32;
    final adjustedFontSize = enemyString.length > 4
        ? baseFontSize * 0.8
        : enemyString.length > 2
            ? baseFontSize * 0.9
            : baseFontSize;

    return Card(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 120,
          maxHeight: screenHeight * 0.25,
        ),
        padding: EdgeInsets.symmetric(
          horizontal:
              screenWidth < 350 ? Dimensions.paddingS : Dimensions.paddingM,
          vertical:
              screenWidth < 350 ? Dimensions.paddingXs : Dimensions.paddingS,
        ),
        child: session.isPracticeMode
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enemy display
                    Container(
                      width: enemyDisplaySize,
                      height: enemyDisplaySize,
                      constraints: BoxConstraints(
                        minWidth: 60,
                        minHeight: 60,
                        maxWidth: screenWidth * 0.35,
                        maxHeight: screenWidth * 0.35,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.enemyNormal,
                        borderRadius: BorderRadius.circular(Dimensions.radiusL),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingS),
                            child: Text(
                              enemyString,
                              style: AppTextStyles.enemyValue.copyWith(
                                color: AppColors.onPrimary,
                                fontSize: adjustedFontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                        height: screenWidth < 350
                            ? Dimensions.spacingXs
                            : Dimensions.spacingS),

                    // Prime/Composite Number タイトル（練習モードのみ表示）
                    Flexible(
                      child: Text(
                        isPrime ? l10n.primeNumber : l10n.compositeNumber,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: screenWidth < 350 ? 14 : 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),

                    SizedBox(
                        height: screenWidth < 350 ? 2 : Dimensions.spacingXs),

                    // 説明文（練習モードのみ表示）
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth < 350
                              ? Dimensions.paddingXs
                              : Dimensions.paddingS,
                        ),
                        child: Text(
                          isPrime
                              ? l10n.enemyDefeated
                              : l10n.attackWithPrimeFactors,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: screenWidth < 350 ? 10 : 11,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  width: enemyDisplaySize,
                  height: enemyDisplaySize,
                  constraints: BoxConstraints(
                    minWidth: 60,
                    minHeight: 60,
                    maxWidth: screenWidth * 0.35,
                    maxHeight: screenWidth * 0.35,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.enemyNormal,
                    borderRadius: BorderRadius.circular(Dimensions.radiusL),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingS),
                        child: Text(
                          enemyString,
                          style: AppTextStyles.enemyValue.copyWith(
                            color: AppColors.onPrimary,
                            fontSize: adjustedFontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _PrimeGridSection extends ConsumerWidget {
  final VoidCallback onGameOverCheck;
  final void Function(BuildContext, int, int) onInvalidAttack;

  const _PrimeGridSection({
    required this.onGameOverCheck,
    required this.onInvalidAttack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primes = ref.watch(battleInventoryProvider);
    final enemy = ref.watch(battleEnemyProvider);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.yourPrimeNumbers,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: Dimensions.spacingM),
        Expanded(
          child: primes.isEmpty
              ? Center(
                  child: Text(
                    l10n.noPrimesAvailable,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Dimensions.primeGridCrossAxisCount,
                    childAspectRatio: Dimensions.primeGridAspectRatio,
                    crossAxisSpacing: Dimensions.primeGridSpacing,
                    mainAxisSpacing: Dimensions.primeGridRunSpacing,
                  ),
                  itemCount: primes.length,
                  itemBuilder: (context, index) {
                    final prime = primes[index];

                    return _PrimeButton(
                      prime: prime,
                      onPressed: () {
                        Logger.logBattle('Prime attack attempt',
                            data: {'prime': prime.value, 'enemy': enemy});
                        if (prime.count > 0) {
                          final canAttack =
                              enemy % prime.value == 0 && !_isPrime(enemy);

                          if (canAttack) {
                            // 有効な攻撃：敵の数値を更新
                            Logger.logBattle('Valid attack', data: {
                              'enemy': enemy,
                              'prime': prime.value,
                              'result': enemy ~/ prime.value
                            });
                            ref.read(battleEnemyProvider.notifier).state =
                                enemy ~/ prime.value;

                            // バトル中はアイテムを実際に消費しない
                            // ステージ終了時に使用したアイテムを確定する
                            // (練習モードでは消費しない)

                            // 使用統計を記録
                            ref
                                .read(primeUsageProvider.notifier)
                                .recordPrimeUsage(prime.value);

                            // 使用した素数を記録
                            ref
                                .read(battleSessionProvider.notifier)
                                .recordUsedPrime(prime.value);

                            // ゲームオーバー条件をチェック（少し遅延してUI更新を確実に）
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              onGameOverCheck();
                            });
                          } else {
                            // 無効な攻撃：教育的フィードバックを提供
                            Logger.logBattle('Invalid attack',
                                data: {'enemy': enemy, 'prime': prime.value});
                            onInvalidAttack(context, prime.value, enemy);

                            // バトル中はアイテムを実際に消費しない
                            // ステージ終了時に使用したアイテムを確定する

                            // 使用統計を記録（無効攻撃でも）
                            ref
                                .read(primeUsageProvider.notifier)
                                .recordPrimeUsage(prime.value);

                            // 無効攻撃も記録（学習データとして）
                            ref
                                .read(battleSessionProvider.notifier)
                                .recordUsedPrime(prime.value);
                          }
                        }
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _PrimeButton extends ConsumerWidget {
  final Prime prime;
  final VoidCallback? onPressed;

  const _PrimeButton({
    required this.prime,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAvailable = prime.count > 0;

    return Material(
      color: isAvailable
          ? AppColors.primeAvailable.withValues(alpha: 0.1)
          : AppColors.primeUnavailable.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(Dimensions.radiusM),
      child: InkWell(
        onTap: isAvailable ? onPressed : null,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
            border: Border.all(
              color: isAvailable
                  ? AppColors.primeAvailable
                  : AppColors.primeUnavailable,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    prime.value.toString(),
                    style: AppTextStyles.primeValue.copyWith(
                      color: isAvailable
                          ? AppColors.primeAvailable
                          : AppColors.primeUnavailable,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.spacingXs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingS,
                      vertical: Dimensions.paddingXs,
                    ),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? AppColors.primeAvailable.withValues(alpha: 0.2)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(Dimensions.radiusS),
                      border: Border.all(
                        color: isAvailable
                            ? AppColors.primeAvailable
                            : AppColors.primeUnavailable,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'x${prime.count}',
                      style: AppTextStyles.primeCount.copyWith(
                        color: isAvailable
                            ? AppColors.primeAvailable
                            : AppColors.primeUnavailable,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButtonsSection extends ConsumerWidget {
  final VoidCallback onRestartTimer;
  final VoidCallback onStopTimer;
  final VoidCallback onGenerateNewEnemy;
  final VoidCallback onGenerateNewEnemyWithoutTimeReset;
  final VoidCallback onRestoreInventory;

  const _ActionButtonsSection({
    required this.onRestartTimer,
    required this.onStopTimer,
    required this.onGenerateNewEnemy,
    required this.onGenerateNewEnemyWithoutTimeReset,
    required this.onRestoreInventory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(battleEnemyProvider);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Logger.logBattle('Escape button pressed');

              // Record escape in session
              ref.read(battleSessionProvider.notifier).recordEscape();

              // Apply time penalty (reduce timer by 10 seconds)
              final currentTime = ref.read(battleTimerProvider);
              final newTime =
                  (currentTime - 10).clamp(1, currentTime); // 最低1秒は残す
              ref.read(battleTimerProvider.notifier).state = newTime;

              // Generate new enemy without resetting timer or items
              onGenerateNewEnemyWithoutTimeReset();

              // Show feedback
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('逃走しました。時間が10秒減少しました。'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(l10n.escape),
          ),
        ),
        const SizedBox(width: Dimensions.spacingM),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              // 複数回の連続クリックを防ぐ
              if (context.mounted) {
                _claimVictory(context, ref, enemy, onStopTimer, onRestartTimer,
                    onGenerateNewEnemy);
              }
            },
            child: Text(l10n.claimVictory),
          ),
        ),
      ],
    );
  }

  void _claimVictory(
      BuildContext context,
      WidgetRef ref,
      int enemy,
      VoidCallback onStopTimer,
      VoidCallback onRestartTimer,
      VoidCallback onGenerateNewEnemy) {
    Logger.logBattle('Claim Victory button pressed');
    final l10n = AppLocalizations.of(context)!;

    if (_isPrime(enemy)) {
      // Correct claim - record victory and give reward
      final session = ref.read(battleSessionProvider);
      final usedPrimes = session.usedPrimesInCurrentBattle;
      ref.read(battleSessionProvider.notifier).recordVictory(enemy);

      // 最終素数を報酬として獲得
      if (!session.isPracticeMode) {
        // ステージモード：一時的な報酬として追加（ステージクリア時に確定）
        ref.read(battleTempRewardsProvider.notifier).addTempReward(enemy);
        Logger.logBattle('Stage mode victory reward (temp)',
            data: {'final_prime': enemy});

        // Track recently acquired primes for visual feedback
        final now = DateTime.now();
        final currentMap =
            Map<int, DateTime>.from(ref.read(recentlyAcquiredPrimesProvider));
        for (final prime in [enemy, ...usedPrimes]) {
          currentMap[prime] = now;
        }
        currentMap.removeWhere(
            (key, timestamp) => now.difference(timestamp).inSeconds > 2);
        ref.read(recentlyAcquiredPrimesProvider.notifier).state = currentMap;
      } else {
        // 練習モード：最終素数のみ獲得（アイテムは消費されない）
        ref.read(inventoryProvider.notifier).addPrime(enemy);
        // バトル中の一時的な報酬としても追加（UI表示用）
        ref.read(battleTempRewardsProvider.notifier).addTempReward(enemy);
        Logger.logBattle('Practice mode victory reward (immediate)',
            data: {'final_prime': enemy});

        // Track recently acquired prime for visual feedback
        final now = DateTime.now();
        final currentMap =
            Map<int, DateTime>.from(ref.read(recentlyAcquiredPrimesProvider));
        currentMap[enemy] = now;
        currentMap.removeWhere(
            (key, timestamp) => now.difference(timestamp).inSeconds > 2);
        ref.read(recentlyAcquiredPrimesProvider.notifier).state = currentMap;
      }

      // Check if stage is cleared
      final clearResult =
          ref.read(battleSessionProvider.notifier).checkClearCondition();

      if (clearResult != null) {
        // Stage cleared! Stop timer and navigate safely
        onStopTimer();

        // ステージクリア時の統合処理
        List<int> rewardItems = [];

        if (!session.isPracticeMode) {
          // デバッグ: クリア前のメインインベントリ状態
          final beforeInventory = ref.read(inventoryProvider);
          Logger.logBattle('Before stage clear - main inventory', data: {
            'total_items': beforeInventory.length,
            'items':
                beforeInventory.map((p) => '${p.value}x${p.count}').join(', ')
          });

          // 1. メインインベントリをオリジナル状態に復元
          if (session.originalMainInventory != null) {
            ref
                .read(inventoryProvider.notifier)
                .restoreInventory(session.originalMainInventory!);

            Logger.logBattle('Restored main inventory to original state',
                data: {
                  'restored_items': session.originalMainInventory!.length,
                  'items': session.originalMainInventory!
                      .map((p) => '${p.value}x${p.count}')
                      .join(', ')
                });
          }

          // 2. 一時的な報酬をメインインベントリに追加
          final tempRewards = ref
              .read(battleTempRewardsProvider.notifier)
              .finalizeTempRewards();

          Logger.logBattle('Adding rewards to main inventory', data: {
            'temp_rewards_count': tempRewards.length,
            'temp_rewards':
                tempRewards.map((r) => '${r.value}x${r.count}').join(', ')
          });

          for (final reward in tempRewards) {
            for (int i = 0; i < reward.count; i++) {
              ref.read(inventoryProvider.notifier).addPrime(reward.value);
              rewardItems.add(reward.value); // 報酬リストに追加
              Logger.logBattle('Added reward to main inventory', data: {
                'prime': reward.value,
                'total_in_reward_list': rewardItems.length
              });
            }
          }

          // デバッグ: クリア後のメインインベントリ状態
          final afterInventory = ref.read(inventoryProvider);
          Logger.logBattle('After stage clear - main inventory', data: {
            'total_items': afterInventory.length,
            'items':
                afterInventory.map((p) => '${p.value}x${p.count}').join(', '),
            'temp_rewards':
                tempRewards.map((r) => '${r.value}x${r.count}').join(', ')
          });
        } else {
          // 練習モード - 一時的な報酬のみクリア
          ref.read(battleTempRewardsProvider.notifier).finalizeTempRewards();
        }

        // 3. 使用したアイテムの記録をリセット
        ref.read(battleSessionProvider.notifier).resetUsedPrimes();

        // 4. originalMainInventoryをクリアして、後続の復元処理を防ぐ
        ref.read(battleSessionProvider.notifier).clearOriginalInventory();
        Logger.logBattle(
            'Cleared originalMainInventory to prevent restoration after stage clear');

        // 5. 報酬データを含む新しいStageClearResultを作成
        final clearResultWithRewards =
            clearResult.copyWith(rewardItems: rewardItems);

        // Delay navigation to ensure current frame completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StageClearScreen(clearResult: clearResultWithRewards),
              ),
            );
          }
        });
      } else {
        // Continue to next enemy automatically without popup
        // Generate new enemy and continue timer
        onGenerateNewEnemyWithoutTimeReset();

        // No intrusive feedback - let the player continue seamlessly
      }
    } else {
      // Wrong claim - record error
      ref.read(battleSessionProvider.notifier).recordWrongClaim();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.wrongClaim),
          content: Text(l10n.stillComposite(enemy.toString())),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.continueAction),
            ),
          ],
        ),
      );
    }
  }
}

bool _isPrime(int n) {
  if (n <= 1) return false;
  if (n <= 3) return true;
  if (n % 2 == 0 || n % 3 == 0) return false;

  for (int i = 5; i * i <= n; i += 6) {
    if (n % i == 0 || n % (i + 2) == 0) return false;
  }

  return true;
}
