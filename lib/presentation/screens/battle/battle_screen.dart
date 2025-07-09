import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../widgets/battle_menu_dialog.dart';
import '../../providers/battle_session_provider.dart';
import '../../../domain/entities/prime.dart';
import '../../../domain/entities/battle_state.dart';
import '../stage/stage_clear_screen.dart';

// Battle screen initial data
List<Prime> _getInitialPrimes() => [
  Prime(value: 2, count: 3, firstObtained: DateTime.now()),
  Prime(value: 3, count: 2, firstObtained: DateTime.now()),
  Prime(value: 5, count: 1, firstObtained: DateTime.now()),
  Prime(value: 7, count: 0, firstObtained: DateTime.now()),
  Prime(value: 11, count: 0, firstObtained: DateTime.now()),
  Prime(value: 13, count: 0, firstObtained: DateTime.now()),
];

// Simple working providers for battle screen
final battleEnemyProvider = StateProvider<int>((ref) => 12);
final battleTimerProvider = StateProvider<int>((ref) => 90);
final battlePrimesProvider = StateProvider<List<Prime>>((ref) => _getInitialPrimes());

class BattleScreen extends ConsumerStatefulWidget {
  const BattleScreen({super.key});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize battle state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Battle screen initialized');
    });
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

  void _restartBattle() {
    print('Restarting battle');
    // Reset battle
    ref.read(battleEnemyProvider.notifier).state = 12;
    ref.read(battleTimerProvider.notifier).state = 90;
    ref.read(battlePrimesProvider.notifier).state = _getInitialPrimes();
    
    // User feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Battle restarted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _exitBattle() {
    print('Exiting battle');
    // Return to stage selection screen
    AppRouter.goToStageSelect(context);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(battleSessionProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(session.isPracticeMode 
            ? 'Practice Mode' 
            : 'Stage ${session.stageNumber ?? '?'}'),
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
              const Expanded(
                flex: 3,
                child: _PrimeGridSection(),
              ),
              
              const SizedBox(height: Dimensions.spacingL),
              
              // Action buttons
              const _ActionButtonsSection(),
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
              'Victories: ${session.victories}',
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

    Color timerColor = AppColors.timerNormal;
    if (timer <= 10) {
      timerColor = AppColors.timerCritical;
    } else if (timer <= 30) {
      timerColor = AppColors.timerWarning;
    }

    return Container(
      width: double.infinity,
      height: Dimensions.timerDisplayHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(color: AppColors.outline),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTime,
              style: AppTextStyles.timerDisplay.copyWith(
                color: timerColor,
              ),
            ),
            const SizedBox(height: Dimensions.spacingXs),
            Text(
              'Time Remaining',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
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

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enemy display
            Container(
              width: Dimensions.enemyDisplaySize,
              height: Dimensions.enemyDisplaySize,
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
                child: Text(
                  enemy.toString(),
                  style: AppTextStyles.enemyValue.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: Dimensions.spacingM),
            
            Text(
              isPrime ? 'Prime Number' : 'Composite Number',
              style: AppTextStyles.titleMedium,
            ),
            
            const SizedBox(height: Dimensions.spacingS),
            
            Text(
              isPrime 
                ? 'Enemy is defeated! Claim victory!'
                : 'Attack with prime factors to defeat it!',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimeGridSection extends ConsumerWidget {
  const _PrimeGridSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primes = ref.watch(battlePrimesProvider);
    final enemy = ref.watch(battleEnemyProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Prime Numbers',
          style: AppTextStyles.titleMedium,
        ),
        
        const SizedBox(height: Dimensions.spacingM),
        
        Expanded(
          child: primes.isEmpty
              ? const Center(
                  child: Text(
                    'No primes available for attack',
                    style: TextStyle(fontSize: 16),
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
                        if (canAttack && prime.count > 0) {
                          ref.read(battleEnemyProvider.notifier).state = enemy ~/ prime.value;
                          final updatedPrimes = [...primes];
                          updatedPrimes[index] = prime.copyWith(count: prime.count - 1);
                          ref.read(battlePrimesProvider.notifier).state = updatedPrimes;
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
    final isAvailable = prime.count > 0 && canAttack;
    
    return Material(
      color: isAvailable ? AppColors.primeAvailable : AppColors.primeUnavailable,
      borderRadius: BorderRadius.circular(Dimensions.radiusM),
      child: InkWell(
        onTap: isAvailable ? onPressed : null,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
            border: Border.all(
              color: isAvailable ? AppColors.primary : AppColors.outline,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prime.value.toString(),
                style: AppTextStyles.primeValue.copyWith(
                  color: isAvailable ? AppColors.onPrimary : AppColors.onSurfaceVariant,
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
                      ? AppColors.primaryContainer 
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(Dimensions.radiusS),
                ),
                child: Text(
                  'x${prime.count}',
                  style: AppTextStyles.primeCount.copyWith(
                    color: isAvailable 
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
  const _ActionButtonsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(battleEnemyProvider);
    final canClaimVictory = _isPrime(enemy);
    
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              print('Escape button pressed');
              // Record escape in session
              ref.read(battleSessionProvider.notifier).recordEscape();
              // Reset battle
              ref.read(battleEnemyProvider.notifier).state = 12;
              ref.read(battlePrimesProvider.notifier).state = _getInitialPrimes();
            },
            child: const Text('Escape'),
          ),
        ),
        
        const SizedBox(width: Dimensions.spacingM),
        
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: canClaimVictory
                ? () => _claimVictory(context, ref, enemy)
                : null,
            child: const Text('Claim Victory!'),
          ),
        ),
      ],
    );
  }
  
  void _claimVictory(BuildContext context, WidgetRef ref, int enemy) {
    print('Claim Victory button pressed');
    
    if (_isPrime(enemy)) {
      // Correct claim - record victory
      ref.read(battleSessionProvider.notifier).recordVictory(enemy);
      
      // Check if stage is cleared
      final clearResult = ref.read(battleSessionProvider.notifier).checkClearCondition();
      
      if (clearResult != null) {
        // Stage cleared!
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StageClearScreen(clearResult: clearResult),
          ),
        );
      } else {
        // Continue to next enemy
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Victory!'),
            content: Text('You defeated the enemy $enemy! Continue fighting!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(battleEnemyProvider.notifier).state = 12;
                  ref.read(battlePrimesProvider.notifier).state = _getInitialPrimes();
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      }
    } else {
      // Wrong claim - record error
      ref.read(battleSessionProvider.notifier).recordWrongClaim();
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Wrong Claim!'),
          content: Text('$enemy is still a composite number. Keep attacking!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
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