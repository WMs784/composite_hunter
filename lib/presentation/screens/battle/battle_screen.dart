import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../widgets/battle_menu_dialog.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../../domain/entities/prime.dart';
import '../stage/stage_clear_screen.dart';
import '../game_over/game_over_screen.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';

// Simple working providers for battle screen
final battleEnemyProvider = StateProvider<int>((ref) => 12);
final battleTimerProvider = StateProvider<int>((ref) => 90);

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
        print('Battle screen initialized');
        _initializeBattleForStage();
        _startTimer();
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentTime = ref.read(battleTimerProvider);
      if (currentTime > 0) {
        ref.read(battleTimerProvider.notifier).state = currentTime - 1;
      } else {
        _handleTimeUp();
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _handleTimeUp() {
    // Stop timer
    _stopTimer();
    
    // アイテム状態をステージ開始時に復元（ゲームオーバー画面で処理されるため、ここでは更新しない）
    
    // ゲームオーバー画面に遷移
    _goToGameOver(GameOverReason.timeUp);
  }

  void _resetBattle() {
    // アイテム状態をステージ開始時に復元
    final session = ref.read(battleSessionProvider);
    if (session.stageStartInventory != null) {
      ref.read(inventoryProvider.notifier).restoreInventory(session.stageStartInventory!);
    }
    
    // Reset battle state and restart timer
    _initializeBattleForStage();
    
    // Reset used primes
    ref.read(battleSessionProvider.notifier).resetUsedPrimes();
    
    _startTimer();
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
    final primes = ref.read(inventoryProvider);
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
      _goToGameOver(GameOverReason.noItems);
    }
  }
  
  void _initializeBattleForStage() {
    final session = ref.read(battleSessionProvider);
    
    // ステージに応じた敵と制限時間を設定
    if (session.isPracticeMode) {
      // 練習モードはデフォルト設定
      ref.read(battleEnemyProvider.notifier).state = _generateEnemyForRange(6, 20);
      ref.read(battleTimerProvider.notifier).state = 30;
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, timeLimit) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      ref.read(battleTimerProvider.notifier).state = timeLimit;
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
    final random = DateTime.now().millisecondsSinceEpoch;
    int candidate;
    
    // 合成数を生成するまで繰り返す
    do {
      candidate = min + (random % (max - min + 1));
    } while (_isPrime(candidate) || candidate <= 1);
    
    return candidate;
  }
  
  void _generateNewEnemy() {
    final session = ref.read(battleSessionProvider);
    
    if (session.isPracticeMode) {
      // 練習モードはデフォルト設定
      ref.read(battleEnemyProvider.notifier).state = _generateEnemyForRange(6, 20);
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
      ref.read(battleEnemyProvider.notifier).state = _generateEnemyForRange(6, 20);
    } else {
      final stageNumber = session.stageNumber ?? 1;
      final (enemy, _) = _getStageSettings(stageNumber);
      ref.read(battleEnemyProvider.notifier).state = enemy;
      // タイマーはリセットしない
    }
  }

  void _restartBattle() {
    print('Restarting battle');
    
    // アイテム状態をステージ開始時に復元
    final session = ref.read(battleSessionProvider);
    if (session.stageStartInventory != null) {
      ref.read(inventoryProvider.notifier).restoreInventory(session.stageStartInventory!);
    }
    
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
    print('Exiting battle');
    // Stop timer before exiting
    _stopTimer();
    
    // アイテム状態をステージ開始時に復元
    final session = ref.read(battleSessionProvider);
    if (session.stageStartInventory != null) {
      ref.read(inventoryProvider.notifier).restoreInventory(session.stageStartInventory!);
    }
    
    // Reset battle session before returning to stage selection
    ref.read(battleSessionProvider.notifier).resetSession();
    // Return to stage selection screen
    AppRouter.goToStageSelect(context);
  }

  void _showInvalidAttackFeedback(BuildContext context, int primeValue, int enemyValue) {
    final l10n = AppLocalizations.of(context)!;
    
    // 素因数分解を計算
    List<int> factors = [];
    int temp = enemyValue;
    
    for (int i = 2; i * i <= temp; i++) {
      while (temp % i == 0) {
        factors.add(i);
        temp ~/= i;
      }
    }
    if (temp > 1) {
      factors.add(temp);
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('無効な攻撃'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('素数$primeValueは$enemyValueを割り切れません。'),
            const SizedBox(height: 16),
            Text('素因数分解:', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$enemyValue = ${factors.join(' × ')}'),
            const SizedBox(height: 16),
            Text('正しい素因数を使用してください。'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.continueAction),
          ),
        ],
      ),
    );
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
              if (!session.isPracticeMode)
                const _SessionProgressSection(),
              
              if (!session.isPracticeMode)
                const SizedBox(height: Dimensions.spacingM),
              
              // Timer display
              const _TimerSection(),
              
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
                onGenerateNewEnemyWithoutTimeReset: _generateNewEnemyWithoutTimeReset,
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
          Icon(
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
            Icon(
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
            Icon(
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
    final formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    final l10n = AppLocalizations.of(context)!;

    Color timerColor = AppColors.timerNormal;
    Color backgroundColor = AppColors.surface;
    
    if (timer <= 10) {
      timerColor = AppColors.timerCritical;
      backgroundColor = AppColors.timerCritical.withOpacity(0.1);
    } else if (timer <= 30) {
      timerColor = AppColors.timerWarning;
      backgroundColor = AppColors.timerWarning.withOpacity(0.1);
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
        horizontal: screenWidth < 350 ? Dimensions.paddingS : Dimensions.paddingM,
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
          minHeight: 150,
          maxHeight: screenHeight * 0.3,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 350 ? Dimensions.paddingM : Dimensions.paddingL,
          vertical: screenWidth < 350 ? Dimensions.paddingS : Dimensions.paddingM,
        ),
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
                    color: Colors.black.withOpacity(0.1),
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
            
            SizedBox(height: screenWidth < 350 ? Dimensions.spacingS : Dimensions.spacingM),
            
            // Prime/Composite Number タイトル
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
            
            SizedBox(height: screenWidth < 350 ? Dimensions.spacingXs : Dimensions.spacingS),
            
            // 説明文
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth < 350 ? Dimensions.paddingXs : Dimensions.paddingS,
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
    final primes = ref.watch(inventoryProvider);
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
                    final canAttack = enemy % prime.value == 0;
                    
                    return _PrimeButton(
                      prime: prime,
                      canAttack: canAttack,
                      onPressed: () {
                        print('Prime ${prime.value} attack');
                        if (prime.count > 0) {
                          final session = ref.read(battleSessionProvider);
                          
                          if (canAttack) {
                            // 有効な攻撃: 敵の数値を更新
                            ref.read(battleEnemyProvider.notifier).state = enemy ~/ prime.value;
                          } else {
                            // 無効な攻撃: 教育的フィードバックを表示
                            onInvalidAttack(context, prime.value, enemy);
                          }
                          
                          // 練習モードでない場合のみアイテムを消費
                          if (!session.isPracticeMode) {
                            // インベントリから素数を消費
                            ref.read(inventoryProvider.notifier).usePrime(prime.value);
                          }
                          
                          // 使用した素数を記録
                          ref.read(battleSessionProvider.notifier).recordUsedPrime(prime.value);
                          
                          // ゲームオーバー条件をチェック
                          Future.delayed(const Duration(milliseconds: 100), () {
                            onGameOverCheck();
                          });
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

class _PrimeButton extends StatelessWidget {
  final Prime prime;
  final bool canAttack;
  final VoidCallback? onPressed;

  const _PrimeButton({
    required this.prime,
    required this.canAttack,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasItems = prime.count > 0;
    
    return Material(
      color: hasItems ? AppColors.primeAvailable : AppColors.primeUnavailable,
      borderRadius: BorderRadius.circular(Dimensions.radiusM),
      child: InkWell(
        onTap: hasItems ? onPressed : null,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
            border: Border.all(
              color: hasItems ? AppColors.primary : AppColors.outline,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prime.value.toString(),
                style: AppTextStyles.primeValue.copyWith(
                  color: hasItems ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ),
              ),
              
              const SizedBox(height: Dimensions.spacingXs),
              
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingS,
                  vertical: Dimensions.paddingXs,
                ),
                decoration: BoxDecoration(
                  color: hasItems 
                      ? AppColors.primaryContainer 
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(Dimensions.radiusS),
                ),
                child: Text(
                  'x${prime.count}',
                  style: AppTextStyles.primeCount.copyWith(
                    color: hasItems 
                        ? AppColors.onPrimaryContainer 
                        : AppColors.onSurfaceVariant,
                  ),
                ),
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
  
  const _ActionButtonsSection({
    required this.onRestartTimer,
    required this.onStopTimer,
    required this.onGenerateNewEnemy,
    required this.onGenerateNewEnemyWithoutTimeReset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(battleEnemyProvider);
    final canClaimVictory = _isPrime(enemy);
    final l10n = AppLocalizations.of(context)!;
    
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              print('Escape button pressed');
              
              // Record escape in session
              ref.read(battleSessionProvider.notifier).recordEscape();
              
              // Apply time penalty (reduce timer by 10 seconds)
              final currentTime = ref.read(battleTimerProvider);
              final newTime = (currentTime - 10).clamp(1, currentTime); // 最低1秒は残す
              ref.read(battleTimerProvider.notifier).state = newTime;
              
              // Generate new enemy without resetting timer or items
              onGenerateNewEnemyWithoutTimeReset();
              
              // Show feedback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('逃走しました。時間が10秒減少しました。'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 2),
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
            onPressed: canClaimVictory
                ? () => _claimVictory(context, ref, enemy, onStopTimer, onRestartTimer, onGenerateNewEnemy)
                : null,
            child: Text(l10n.claimVictory),
          ),
        ),
      ],
    );
  }
  
  void _claimVictory(BuildContext context, WidgetRef ref, int enemy, VoidCallback onStopTimer, VoidCallback onRestartTimer, VoidCallback onGenerateNewEnemy) {
    print('Claim Victory button pressed');
    final l10n = AppLocalizations.of(context)!;
    
    if (_isPrime(enemy)) {
      // Stop timer during victory processing
      onStopTimer();
      
      // Correct claim - record victory and give reward
      final session = ref.read(battleSessionProvider);
      final usedPrimes = session.usedPrimesInCurrentBattle;
      ref.read(battleSessionProvider.notifier).recordVictory(enemy);
      
      // 練習モードでない場合のみ報酬を獲得
      if (!session.isPracticeMode) {
        // 完全な素因数分解の結果を獲得（最終素数 + 使用した素数）
        ref.read(inventoryProvider.notifier).receiveFactorizationReward(enemy, usedPrimes);
      }
      
      // Check if stage is cleared
      final clearResult = ref.read(battleSessionProvider.notifier).checkClearCondition();
      
      if (clearResult != null) {
        // Stage cleared! Stop timer and navigate safely
        onStopTimer();
        
        // Delay navigation to ensure current frame completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StageClearScreen(clearResult: clearResult),
              ),
            );
          }
        });
      } else {
        // Continue to next enemy automatically without popup
        // Reset used primes for next battle
        ref.read(battleSessionProvider.notifier).resetUsedPrimes();
        // Generate new enemy but don't reset inventory
        onGenerateNewEnemy();
        // Start new timer for next battle
        onRestartTimer();
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