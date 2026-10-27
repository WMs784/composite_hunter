import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/prime_gem_painter.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../widgets/battle_effects.dart';
import '../../widgets/battle_menu_dialog.dart';
import '../../providers/achievement_provider.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/prime_usage_provider.dart';
import '../../widgets/achievement_unlock_banner.dart';
import '../../../domain/entities/prime.dart';
import '../stage/stage_clear_screen.dart';
import '../game_over/game_over_screen.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/utils/logger.dart';

// Simple working providers for battle screen
final battleEnemyProvider = StateProvider<int>((ref) => 12);
final battleTimerProvider = StateProvider<int>((ref) => 90);
final battleStartTimeProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

// Recently acquired primes (for visual feedback)
final recentlyAcquiredPrimesProvider = StateProvider<Map<int, DateTime>>(
  (ref) => {},
);

// Attack feedback animation trigger (increments on each attack)
final battleAttackCountProvider = StateProvider<int>((ref) => 0);

// Max timer value for CircularProgressIndicator ratio
final battleMaxTimerProvider = StateProvider<int>((ref) => 90);

// Invalid attack animation trigger — red flash on enemy card
final battleInvalidAttackProvider = StateProvider<int>((ref) => 0);

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
      builder: (context) =>
          BattleMenuDialog(onRestart: _restartBattle, onExit: _exitBattle),
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
    ref.read(battleStartTimeProvider.notifier).state = DateTime.now();
    ref.read(battleComboProvider.notifier).state = 0;
    final session = ref.read(battleSessionProvider);

    // ステージに応じた敵と制限時間を設定
    if (session.isPracticeMode) {
      // 練習モードはタイマーなし
      final enemy = _generateEnemyForRange(6, 20);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      // 練習モードではタイマーを設定しない
      Logger.logBattle(
        'Practice mode initialized',
        data: {'enemy': enemy, 'timer': 'disabled'},
      );
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, timeLimit) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      ref.read(battleTimerProvider.notifier).state = timeLimit;
      ref.read(battleMaxTimerProvider.notifier).state = timeLimit;
      Logger.logBattle(
        'Stage initialized',
        data: {'stage': stageNumber, 'enemy': enemy, 'timer': timeLimit},
      );
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
      100,
    ];

    // 範囲内の合成数を探す
    final validComposites = composites
        .where((c) => c >= min && c <= max)
        .toList();

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
      ref.read(battleEnemyProvider.notifier).state = _generateEnemyForRange(
        6,
        20,
      );
      ref.read(battleTimerProvider.notifier).state = 30;
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, timeLimit) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      ref.read(battleTimerProvider.notifier).state = timeLimit;
    }
  }

  void _generateNewEnemyWithoutTimeReset() {
    ref.read(battleStartTimeProvider.notifier).state = DateTime.now();
    final session = ref.read(battleSessionProvider);

    if (session.isPracticeMode) {
      // 練習モードは敵のみ生成、タイマーはそのまま
      ref.read(battleEnemyProvider.notifier).state = _generateEnemyForRange(
        6,
        20,
      );
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

      Logger.logInventory(
        'Inventory restored',
        count: session.originalMainInventory!.length,
      );
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

  /// 無効攻撃時のフィードバック
  // game-designer: Silent fail — unchanged enemy IS the feedback.
  // A red flash on the enemy card signals "that didn't work" without explaining why.
  void _showInvalidAttackFeedback(BuildContext context, int prime, int enemy) {
    HapticFeedback.heavyImpact();
    ref.read(battleInvalidAttackProvider.notifier).state++;
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(battleSessionProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          session.isPracticeMode
              ? l10n.practiceMode
              : l10n.stage(session.stageNumber?.toString() ?? '?'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showBattleMenu(context),
          tooltip: l10n.menu,
        ),
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
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
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
                  const Expanded(flex: 2, child: _EnemySection()),

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
          Positioned.fill(
            child: Consumer(
              builder: (context, ref, _) {
                final timer = ref.watch(battleTimerProvider);
                return BattleEffectsOverlay(
                  urgent: !session.isPracticeMode && timer > 0 && timer <= 10,
                );
              },
            ),
          ),
        ],
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
    final cs = Theme.of(context).colorScheme;

    if (session.stageNumber == null || session.isPracticeMode) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.paddingM),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(color: cs.outline),
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events, color: cs.onPrimaryContainer, size: 20),
          const SizedBox(width: Dimensions.spacingS),
          Expanded(
            child: Text(
              '${l10n.victories}: ${session.victories}',
              style: AppTextStyles.labelLarge.copyWith(
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
          const ComboBadge(),
          if (session.escapes > 0) ...[
            Icon(Icons.directions_run, color: cs.error, size: 16),
            Text(
              '${session.escapes}',
              style: AppTextStyles.labelSmall.copyWith(color: cs.error),
            ),
            const SizedBox(width: Dimensions.spacingS),
          ],
          if (session.wrongClaims > 0) ...[
            const Icon(Icons.error, color: AppColors.timerWarning, size: 16),
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
    final maxTimer = ref.watch(battleMaxTimerProvider);
    // Final countdown: a tick each second for the last 5 seconds
    ref.listen<int>(battleTimerProvider, (previous, next) {
      if (next > 0 && next <= 5 && next != previous) {
        HapticFeedback.selectionClick();
      }
    });
    final minutes = timer ~/ 60;
    final seconds = timer % 60;
    final formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    // game-ui-design: Readability under motion — color encodes urgency with 3 states
    final bool isCritical = timer <= 10;
    final bool isWarning = timer <= 30 && !isCritical;

    Color timerColor = AppColors.timerNormal;
    Color backgroundColor = cs.surface;
    if (isCritical) {
      timerColor = AppColors.timerCritical;
      backgroundColor = AppColors.timerCritical.withValues(alpha: 0.12);
    } else if (isWarning) {
      timerColor = AppColors.timerWarning;
      backgroundColor = AppColors.timerWarning.withValues(alpha: 0.08);
    }

    final double progress = maxTimer > 0
        ? (timer / maxTimer).clamp(0.0, 1.0)
        : 1.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final baseFontSize = screenWidth < 350 ? 20.0 : 24.0;
    final criticalFontSize = screenWidth < 350 ? 26.0 : 30.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 64, maxHeight: 100),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 350
            ? Dimensions.paddingS
            : Dimensions.paddingM,
        vertical: Dimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(
          color: isCritical ? timerColor : cs.outline,
          width: isCritical ? 2.0 : 1.0,
        ),
      ),
      // flutter-ui-ux: Row layout — circular ring left, text right
      child: Row(
        children: [
          // Circular progress ring showing remaining time
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background ring
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 4,
                  color: timerColor.withValues(alpha: 0.15),
                ),
                // Foreground ring (actual progress)
                AnimatedBuilder(
                  animation: const AlwaysStoppedAnimation(0),
                  builder: (_, __) => CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4,
                    color: timerColor,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                // Timer icon inside ring
                Icon(
                  isCritical ? Icons.warning_rounded : Icons.timer_outlined,
                  size: 18,
                  color: timerColor,
                ),
              ],
            ),
          ),

          const SizedBox(width: Dimensions.spacingM),

          // Time text + label
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.orbitron(
                    color: timerColor,
                    fontSize: isCritical ? criticalFontSize : baseFontSize,
                    fontWeight: isCritical ? FontWeight.w900 : FontWeight.bold,
                  ),
                  child: Text(formattedTime),
                ),
                Text(
                  l10n.timeRemaining,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: cs.onSurfaceVariant,
                    fontSize: screenWidth < 350 ? 10 : 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Enemy Section ─────────────────────────────────────────────────────────────
// game-ui-design: Contextual HUD — enemy color shifts to green+glow when prime
// flutter-ui-ux: AnimationController for attack-flash (implicit) + pulse (explicit)
class _EnemySection extends ConsumerStatefulWidget {
  const _EnemySection();

  @override
  ConsumerState<_EnemySection> createState() => _EnemySectionState();
}

class _EnemySectionState extends ConsumerState<_EnemySection>
    with TickerProviderStateMixin {
  // Pulse animation — runs only when enemy is prime
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;

  // Attack flash animation — white burst on valid hit
  late AnimationController _flashController;
  late Animation<double> _flashOpacity;

  // Invalid attack flash — red burst on failed hit
  late AnimationController _invalidFlashController;
  late Animation<double> _invalidFlashOpacity;

  // Monster idle animation — continuous slow wobble for composite enemies
  late AnimationController _idleController;

  // Hit recoil — enemy shrinks briefly when a valid prime lands
  late AnimationController _hitController;

  // Shake — enemy trembles on invalid attack / wrong claim
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _pulseScale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _flashController = AnimationController(
      duration: const Duration(milliseconds: 380),
      vsync: this,
    );
    _flashOpacity = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.55), weight: 20),
        TweenSequenceItem(tween: Tween(begin: 0.55, end: 0.0), weight: 80),
      ],
    ).animate(CurvedAnimation(parent: _flashController, curve: Curves.easeOut));

    _invalidFlashController = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
    );
    _invalidFlashOpacity =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.45), weight: 25),
          TweenSequenceItem(tween: Tween(begin: 0.45, end: 0.0), weight: 75),
        ]).animate(
          CurvedAnimation(
            parent: _invalidFlashController,
            curve: Curves.easeOut,
          ),
        );

    _hitController = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
    );
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 420),
      vsync: this,
    );

    _idleController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _flashController.dispose();
    _invalidFlashController.dispose();
    _idleController.dispose();
    _hitController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enemy = ref.watch(battleEnemyProvider);
    final isPrime = _isPrime(enemy);
    final session = ref.watch(battleSessionProvider);
    final l10n = AppLocalizations.of(context)!;

    // Trigger white flash on valid attack
    ref.listen<int>(battleAttackCountProvider, (previous, next) {
      if (!mounted) return;
      _flashController.forward(from: 0);
      if (!reduceMotionOf(context)) _hitController.forward(from: 0);
    });

    // Trigger red flash on invalid attack or wrong claim
    ref.listen<int>(battleInvalidAttackProvider, (previous, next) {
      if (!mounted) return;
      _invalidFlashController.forward(from: 0);
      if (!reduceMotionOf(context)) _shakeController.forward(from: 0);
    });

    // Control pulse only when prime
    if (isPrime && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!isPrime && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.animateTo(0);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final enemyDisplaySize = screenWidth < 350
        ? Dimensions.enemyDisplaySize * 0.7
        : screenHeight < 600
        ? Dimensions.enemyDisplaySize * 0.8
        : Dimensions.enemyDisplaySize;

    final enemyString = enemy.toString();
    final baseFontSize = AppTextStyles.enemyValue.fontSize ?? 32;
    final adjustedFontSize = enemyString.length > 4
        ? baseFontSize * 0.8
        : enemyString.length > 2
        ? baseFontSize * 0.9
        : baseFontSize;

    // game-ui-design: Color encodes state — orange for danger, green for victory
    final List<Color> gradientColors = isPrime
        ? [const Color(0xFF1B5E20), const Color(0xFF388E3C)]
        : [const Color(0xFF4E342E), const Color(0xFF795548)];

    return AnimatedBuilder(
      animation: Listenable.merge([
        _pulseController,
        _flashController,
        _invalidFlashController,
        _idleController,
        _hitController,
        _shakeController,
      ]),
      builder: (context, child) {
        final hitScale = 1.0 - 0.10 * sin(pi * _hitController.value);
        final shakeX =
            sin(_shakeController.value * pi * 6) *
            8 *
            (1 - _shakeController.value);
        return Transform.translate(
          offset: Offset(shakeX, 0),
          child: Transform.scale(
            scale: (isPrime ? _pulseScale.value : 1.0) * hitScale,
            child: Stack(
              children: [
                // Main enemy card
                Card(
                  elevation: isPrime ? 10 : 4,
                  shadowColor: isPrime
                      ? AppColors.victoryGreen.withValues(alpha: 0.6)
                      : Colors.black38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusL),
                    side: isPrime
                        ? BorderSide(color: AppColors.victoryGreen, width: 2.5)
                        : BorderSide.none,
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 120,
                      maxHeight: screenHeight * 0.25,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth < 350
                          ? Dimensions.paddingS
                          : Dimensions.paddingM,
                      vertical: screenWidth < 350
                          ? Dimensions.paddingXs
                          : Dimensions.paddingS,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradientColors,
                      ),
                      borderRadius: BorderRadius.circular(Dimensions.radiusL),
                    ),
                    child: session.isPracticeMode
                        ? _buildPracticeLayout(
                            l10n,
                            enemy,
                            isPrime,
                            enemyDisplaySize,
                            adjustedFontSize,
                            enemyString,
                            screenWidth,
                          )
                        : _buildBattleLayout(
                            l10n,
                            enemy,
                            isPrime,
                            enemyDisplaySize,
                            adjustedFontSize,
                            enemyString,
                            screenWidth,
                          ),
                  ),
                ),

                // Valid attack flash — white burst
                if (_flashController.value > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusL,
                          ),
                          color: Colors.white.withValues(
                            alpha: _flashOpacity.value,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Invalid attack flash — red burst (game-designer: secondary action tells story)
                if (_invalidFlashController.value > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusL,
                          ),
                          color: Colors.red.withValues(
                            alpha: _invalidFlashOpacity.value,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // game-designer: Enemy is a character — shape and color driven by factorization.
  // Monster form (composite) morphs into sparkle star (prime) as factorization succeeds.
  Widget _buildBattleLayout(
    AppLocalizations l10n,
    int enemy,
    bool isPrime,
    double displaySize,
    double fontSize,
    String enemyString,
    double screenWidth,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            painter: EnemyMonsterPainter(
              primeFactors: _getPrimeFactors(enemy),
              tier: MonsterTier.of(enemy),
              animPhase: _idleController.value * 2 * pi,
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.50),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.30),
                width: 1.0,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                enemyString,
                style: AppTextStyles.enemyValue.copyWith(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      offset: Offset(1, 2),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeLayout(
    AppLocalizations l10n,
    int enemy,
    bool isPrime,
    double displaySize,
    double fontSize,
    String enemyString,
    double screenWidth,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildEnemyNumber(displaySize, fontSize, enemyString, screenWidth),
          SizedBox(
            height: screenWidth < 350
                ? Dimensions.spacingXs
                : Dimensions.spacingS,
          ),
          Flexible(
            child: Text(
              isPrime ? l10n.primeNumber : l10n.compositeNumber,
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: screenWidth < 350 ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(height: screenWidth < 350 ? 2 : Dimensions.spacingXs),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth < 350
                    ? Dimensions.paddingXs
                    : Dimensions.paddingS,
              ),
              child: Text(
                isPrime ? l10n.enemyDefeated : l10n.attackWithPrimeFactors,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: screenWidth < 350 ? 10 : 11,
                  height: 1.2,
                  shadows: const [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black38,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnemyNumber(
    double displaySize,
    double fontSize,
    String enemyString,
    double screenWidth,
  ) {
    return Container(
      width: displaySize,
      height: displaySize,
      constraints: BoxConstraints(
        minWidth: 60,
        minHeight: 60,
        maxWidth: screenWidth * 0.35,
        maxHeight: screenWidth * 0.35,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(Dimensions.radiusL),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingS),
            child: Text(
              enemyString,
              style: AppTextStyles.enemyValue.copyWith(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    offset: Offset(1, 2),
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
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
        Text(l10n.yourPrimeNumbers, style: AppTextStyles.titleMedium),
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
                        Logger.logBattle(
                          'Prime attack attempt',
                          data: {'prime': prime.value, 'enemy': enemy},
                        );
                        if (prime.count > 0) {
                          final canAttack =
                              enemy % prime.value == 0 && !_isPrime(enemy);

                          if (canAttack) {
                            // 有効な攻撃：敵の数値を更新
                            Logger.logBattle(
                              'Valid attack',
                              data: {
                                'enemy': enemy,
                                'prime': prime.value,
                                'result': enemy ~/ prime.value,
                              },
                            );
                            // Trigger attack flash animation
                            HapticFeedback.lightImpact();
                            ref
                                .read(battleAttackCountProvider.notifier)
                                .state++;
                            ref
                                .read(battleHitProvider.notifier)
                                .state = BattleHit(
                              ref.read(battleAttackCountProvider),
                              prime.value,
                            );
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
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () {
                                onGameOverCheck();
                              },
                            );
                          } else {
                            // 無効な攻撃：教育的フィードバックを提供
                            Logger.logBattle(
                              'Invalid attack',
                              data: {'enemy': enemy, 'prime': prime.value},
                            );
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

// ─── Prime Button ───────────────────────────────────────────────────────────────
// game-designer: All available primes look the same — the player must decide which
// to use. Discovery through experimentation, not color-coded answers.
// flutter-ui-ux: AnimatedScale squash on tap for satisfying micro-interaction.
class _PrimeButton extends StatefulWidget {
  final Prime prime;
  final VoidCallback? onPressed;

  const _PrimeButton({required this.prime, this.onPressed});

  @override
  State<_PrimeButton> createState() => _PrimeButtonState();
}

class _PrimeButtonState extends State<_PrimeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
    _tapScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.88), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.88, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _tapController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable = widget.prime.count > 0;

    return AnimatedBuilder(
      animation: _tapScale,
      builder: (context, child) =>
          Transform.scale(scale: _tapScale.value, child: child),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        child: InkWell(
          onTap: isAvailable
              ? () {
                  _tapController.forward(from: 0);
                  widget.onPressed?.call();
                }
              : null,
          borderRadius: BorderRadius.circular(Dimensions.radiusM),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
            child: Stack(
              fit: StackFit.expand,
              children: [
                RepaintBoundary(
                  child: CustomPaint(
                    painter: PrimeGemPainter(
                      primeValue: widget.prime.value,
                      isAvailable: isAvailable,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.prime.value.toString(),
                        style: GoogleFonts.fredoka(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(blurRadius: 3, color: Colors.black54),
                          ],
                        ),
                      ),
                      Text(
                        'x${widget.prime.count}',
                        style: GoogleFonts.fredoka(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.90),
                          shadows: const [
                            Shadow(blurRadius: 2, color: Colors.black45),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        // game-ui-design: Escape is intentionally less visually dominant
        OutlinedButton(
          onPressed: () {
            Logger.logBattle('Escape button pressed');
            ref.read(battleSessionProvider.notifier).recordEscape();
            ref.read(battleComboProvider.notifier).state = 0;
            final currentTime = ref.read(battleTimerProvider);
            final newTime = (currentTime - 10).clamp(1, currentTime);
            ref.read(battleTimerProvider.notifier).state = newTime;
            onGenerateNewEnemyWithoutTimeReset();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.escapedItemsRestored),
                backgroundColor: AppColors.timerWarning,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: cs.onSurfaceVariant,
            side: BorderSide(color: cs.outline),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingM,
              vertical: Dimensions.paddingM,
            ),
          ),
          child: Text(l10n.escape),
        ),
        const SizedBox(width: Dimensions.spacingM),

        // game-designer: Button has one consistent look regardless of prime/composite.
        // Players must judge for themselves when to claim — that IS the gameplay.
        // The ambient enemy card color (brown→green) is the only atmospheric signal.
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (context.mounted) {
                _claimVictory(
                  context,
                  ref,
                  enemy,
                  onStopTimer,
                  onRestartTimer,
                  onGenerateNewEnemy,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingM,
              ),
            ),
            child: Text(l10n.claimVictory),
          ),
        ),
      ],
    );
  }

  Future<void> _checkAndShowAchievements(
    BuildContext context,
    WidgetRef ref,
    int defeatedEnemy,
  ) async {
    final battleStart = ref.read(battleStartTimeProvider);
    final elapsedSeconds = DateTime.now().difference(battleStart).inSeconds;
    final session = ref.read(battleSessionProvider);

    final newlyUnlocked = await ref
        .read(achievementProvider.notifier)
        .checkBattleAchievements(
          isVictory: true,
          isPowerEnemy: false,
          battleTimeSeconds: elapsedSeconds,
          turnCount: session.usedPrimesInCurrentBattle.length,
          enemyValue: defeatedEnemy,
          isPerfectScore: session.wrongClaims == 0,
        );

    if (newlyUnlocked.isNotEmpty && context.mounted) {
      showAchievementUnlockNotifications(context, newlyUnlocked);
    }
  }

  void _claimVictory(
    BuildContext context,
    WidgetRef ref,
    int enemy,
    VoidCallback onStopTimer,
    VoidCallback onRestartTimer,
    VoidCallback onGenerateNewEnemy,
  ) {
    Logger.logBattle('Claim Victory button pressed');
    final l10n = AppLocalizations.of(context)!;

    if (_isPrime(enemy)) {
      // Correct claim - record victory and give reward
      final session = ref.read(battleSessionProvider);
      final usedPrimes = session.usedPrimesInCurrentBattle;
      ref.read(battleSessionProvider.notifier).recordVictory(enemy);
      HapticFeedback.mediumImpact();
      ref.read(battleComboProvider.notifier).state++;
      ref.read(battleCelebrationProvider.notifier).state++;

      // Check and show achievement unlock notifications (fire-and-forget)
      _checkAndShowAchievements(context, ref, enemy);

      // 最終素数を報酬として獲得
      if (!session.isPracticeMode) {
        // ステージモード：一時的な報酬として追加（ステージクリア時に確定）
        ref.read(battleTempRewardsProvider.notifier).addTempReward(enemy);
        Logger.logBattle(
          'Stage mode victory reward (temp)',
          data: {'final_prime': enemy},
        );

        // Track recently acquired primes for visual feedback
        final now = DateTime.now();
        final currentMap = Map<int, DateTime>.from(
          ref.read(recentlyAcquiredPrimesProvider),
        );
        for (final prime in [enemy, ...usedPrimes]) {
          currentMap[prime] = now;
        }
        currentMap.removeWhere(
          (key, timestamp) => now.difference(timestamp).inSeconds > 2,
        );
        ref.read(recentlyAcquiredPrimesProvider.notifier).state = currentMap;
      } else {
        // 練習モード：最終素数のみ獲得（アイテムは消費されない）
        ref.read(inventoryProvider.notifier).addPrime(enemy);
        // バトル中の一時的な報酬としても追加（UI表示用）
        ref.read(battleTempRewardsProvider.notifier).addTempReward(enemy);
        Logger.logBattle(
          'Practice mode victory reward (immediate)',
          data: {'final_prime': enemy},
        );

        // Track recently acquired prime for visual feedback
        final now = DateTime.now();
        final currentMap = Map<int, DateTime>.from(
          ref.read(recentlyAcquiredPrimesProvider),
        );
        currentMap[enemy] = now;
        currentMap.removeWhere(
          (key, timestamp) => now.difference(timestamp).inSeconds > 2,
        );
        ref.read(recentlyAcquiredPrimesProvider.notifier).state = currentMap;
      }

      // Check if stage is cleared
      final clearResult = ref
          .read(battleSessionProvider.notifier)
          .checkClearCondition();

      if (clearResult != null) {
        // Stage cleared! Stop timer and navigate safely
        onStopTimer();

        // ステージクリア時の統合処理
        List<int> rewardItems = [];

        if (!session.isPracticeMode) {
          // デバッグ: クリア前のメインインベントリ状態
          final beforeInventory = ref.read(inventoryProvider);
          Logger.logBattle(
            'Before stage clear - main inventory',
            data: {
              'total_items': beforeInventory.length,
              'items': beforeInventory
                  .map((p) => '${p.value}x${p.count}')
                  .join(', '),
            },
          );

          // 1. メインインベントリをオリジナル状態に復元
          if (session.originalMainInventory != null) {
            ref
                .read(inventoryProvider.notifier)
                .restoreInventory(session.originalMainInventory!);

            Logger.logBattle(
              'Restored main inventory to original state',
              data: {
                'restored_items': session.originalMainInventory!.length,
                'items': session.originalMainInventory!
                    .map((p) => '${p.value}x${p.count}')
                    .join(', '),
              },
            );
          }

          // 2. 一時的な報酬をメインインベントリに追加
          final tempRewards = ref
              .read(battleTempRewardsProvider.notifier)
              .finalizeTempRewards();

          Logger.logBattle(
            'Adding rewards to main inventory',
            data: {
              'temp_rewards_count': tempRewards.length,
              'temp_rewards': tempRewards
                  .map((r) => '${r.value}x${r.count}')
                  .join(', '),
            },
          );

          for (final reward in tempRewards) {
            for (int i = 0; i < reward.count; i++) {
              ref.read(inventoryProvider.notifier).addPrime(reward.value);
              rewardItems.add(reward.value); // 報酬リストに追加
              Logger.logBattle(
                'Added reward to main inventory',
                data: {
                  'prime': reward.value,
                  'total_in_reward_list': rewardItems.length,
                },
              );
            }
          }

          // デバッグ: クリア後のメインインベントリ状態
          final afterInventory = ref.read(inventoryProvider);
          Logger.logBattle(
            'After stage clear - main inventory',
            data: {
              'total_items': afterInventory.length,
              'items': afterInventory
                  .map((p) => '${p.value}x${p.count}')
                  .join(', '),
              'temp_rewards': tempRewards
                  .map((r) => '${r.value}x${r.count}')
                  .join(', '),
            },
          );
        } else {
          // 練習モード - 一時的な報酬のみクリア
          ref.read(battleTempRewardsProvider.notifier).finalizeTempRewards();
        }

        // 3. 使用したアイテムの記録をリセット
        ref.read(battleSessionProvider.notifier).resetUsedPrimes();

        // 4. originalMainInventoryをクリアして、後続の復元処理を防ぐ
        ref.read(battleSessionProvider.notifier).clearOriginalInventory();
        Logger.logBattle(
          'Cleared originalMainInventory to prevent restoration after stage clear',
        );

        // 5. 報酬データを含む新しいStageClearResultを作成
        final clearResultWithRewards = clearResult.copyWith(
          rewardItems: rewardItems,
        );

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
      // Wrong claim — red flash + brief SnackBar, no explanation given
      // game-designer: The unchanged composite enemy IS the feedback. Brief text
      // names the error without teaching the answer.
      ref.read(battleSessionProvider.notifier).recordWrongClaim();
      ref.read(battleComboProvider.notifier).state = 0;
      HapticFeedback.heavyImpact();
      ref.read(battleInvalidAttackProvider.notifier).state++;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wrongClaim),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ─── Pulsing Button Helper ──────────────────────────────────────────────────────
// flutter-ui-ux: Reusable micro-interaction wrapper for "ready" state emphasis
// game-ui-design: Motion guides attention — pulse only when action is critical
class _PulsingButton extends StatefulWidget {
  final Widget child;
  final bool active;

  const _PulsingButton({required this.child, required this.active});

  @override
  State<_PulsingButton> createState() => _PulsingButtonState();
}

class _PulsingButtonState extends State<_PulsingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 1.055,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.active) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_PulsingButton old) {
    super.didUpdateWidget(old);
    if (widget.active != old.active) {
      if (widget.active) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.animateTo(0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: widget.active ? _scale.value : 1.0,
        child: child,
      ),
      child: widget.child,
    );
  }
}

// ─── Prime Factorization Helper ─────────────────────────────────────────────────
List<int> _getPrimeFactors(int n) {
  final List<int> factors = [];
  int temp = n;
  while (temp % 2 == 0) {
    factors.add(2);
    temp ~/= 2;
  }
  for (int i = 3; i * i <= temp; i += 2) {
    while (temp % i == 0) {
      factors.add(i);
      temp ~/= i;
    }
  }
  if (temp > 1) factors.add(temp);
  return factors;
}

// ─── Enemy Monster Painter ──────────────────────────────────────────────────────
// game-designer: Enemy appearance driven by prime factorization:
//   - Spike count  = total factor count     (12=2×2×3 → 3 spikes)
//   - Eye count    = distinct prime count   (12={2,3} → 2 eyes)
//   - Color        = smallest prime factor  (2→red, 3→green, 5→orange, 7→purple)
//   - Size/menace  = enemy tier             (bigger numbers look scarier)
//   - Prime enemy  → transforms into sparkle star
enum MonsterTier {
  small(0.62),
  medium(0.70),
  large(0.78),
  boss(0.86);

  const MonsterTier(this.bodyScale);

  final double bodyScale;

  static MonsterTier of(int n) {
    if (n <= 20) return small;
    if (n <= 100) return medium;
    if (n <= 500) return large;
    return boss;
  }
}

class EnemyMonsterPainter extends CustomPainter {
  final List<int> primeFactors;
  final MonsterTier tier;

  final double animPhase;

  EnemyMonsterPainter({
    required this.primeFactors,
    required this.tier,
    required this.animPhase,
  });

  Color get _baseColor {
    if (primeFactors.isEmpty) return Colors.grey;
    final smallest = primeFactors.reduce(min);
    if (smallest == 2) return const Color(0xFFD32F2F);
    if (smallest == 3) return const Color(0xFF388E3C);
    if (smallest == 5) return const Color(0xFFF57C00);
    if (smallest == 7) return const Color(0xFF7B1FA2);
    return const Color(0xFF0288D1);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = min(cx, cy) * tier.bodyScale;
    _drawMonster(canvas, cx, cy, r);
  }

  void _drawMonster(Canvas canvas, double cx, double cy, double r) {
    final spikeCount = primeFactors.length.clamp(2, 8);
    final path = _buildBlobPath(cx, cy, r, spikeCount);

    // Boss aura — pulsing red glow
    if (tier == MonsterTier.boss) {
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(
            0xFFFF1744,
          ).withValues(alpha: 0.30 + 0.15 * sin(animPhase * 2))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
      );
    }

    // Drop shadow
    canvas.drawPath(
      path.shift(const Offset(3, 4)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    // Body
    canvas.drawPath(
      path,
      Paint()
        ..color = _baseColor
        ..style = PaintingStyle.fill,
    );
    // Top sheen
    canvas.save();
    canvas.clipPath(path);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - r * 0.1, cy - r * 0.3),
        width: r * 1.2,
        height: r * 0.7,
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.18)
        ..style = PaintingStyle.fill,
    );
    canvas.restore();
    // Outline
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
    // Face
    final eyeCount = primeFactors.toSet().length.clamp(1, 3);
    _drawEyes(canvas, cx, cy, r, eyeCount);
    _drawMouth(canvas, cx, cy, r, happy: false);
    if (tier == MonsterTier.boss) _drawFangs(canvas, cx, cy, r);
  }

  void _drawFangs(Canvas canvas, double cx, double cy, double r) {
    final mouthY = cy + r * 0.38;
    final mw = r * 0.38;
    final fang = Paint()..color = Colors.white;
    for (final dx in [-mw * 0.55, mw * 0.55]) {
      canvas.drawPath(
        Path()
          ..moveTo(cx + dx - r * 0.07, mouthY)
          ..lineTo(cx + dx + r * 0.07, mouthY)
          ..lineTo(cx + dx, mouthY + r * 0.16)
          ..close(),
        fang,
      );
    }
  }

  Path _buildBlobPath(double cx, double cy, double r, int bumps) {
    const pts = 72;
    final path = Path();
    for (int i = 0; i <= pts; i++) {
      final angle = 2 * pi * i / pts;
      final wobble =
          1.0 +
          0.10 * sin(bumps * angle + animPhase) +
          0.05 * sin(bumps * 2 * angle + animPhase * 1.3);
      final x = cx + r * wobble * cos(angle);
      final y = cy + r * wobble * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  void _drawEyes(Canvas canvas, double cx, double cy, double r, int count) {
    final eyeR = r * 0.13;
    final eyeY = cy - r * 0.20;
    final spacing = r * 0.28;
    final startX = cx - spacing * (count - 1) / 2;
    for (int i = 0; i < count; i++) {
      final ex = startX + spacing * i;
      canvas.drawCircle(
        Offset(ex, eyeY),
        eyeR,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        Offset(ex + eyeR * 0.15, eyeY + eyeR * 0.15),
        eyeR * 0.55,
        Paint()
          ..color = tier == MonsterTier.boss
              ? const Color(0xFFD50000)
              : Colors.black
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        Offset(ex - eyeR * 0.25, eyeY - eyeR * 0.25),
        eyeR * 0.20,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      );
    }
  }

  void _drawMouth(
    Canvas canvas,
    double cx,
    double cy,
    double r, {
    required bool happy,
  }) {
    final mouthY = cy + r * 0.38;
    final mw = r * 0.38;
    final ctrl = happy ? -r * 0.12 : r * 0.09;
    final path = Path()
      ..moveTo(cx - mw, mouthY)
      ..quadraticBezierTo(cx, mouthY + ctrl, cx + mw, mouthY);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.70)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(EnemyMonsterPainter old) =>
      old.animPhase != animPhase ||
      old.tier != tier ||
      old.primeFactors.length != primeFactors.length;
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
