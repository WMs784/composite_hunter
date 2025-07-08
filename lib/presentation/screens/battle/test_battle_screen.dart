import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../../domain/entities/prime.dart';

// Simple test providers
final testEnemyProvider = StateProvider<int>((ref) => 12);
final testTimerProvider = StateProvider<int>((ref) => 90);
final testPrimesProvider = StateProvider<List<Prime>>((ref) => [
  Prime(value: 2, count: 3, firstObtained: DateTime.now()),
  Prime(value: 3, count: 2, firstObtained: DateTime.now()),
  Prime(value: 5, count: 1, firstObtained: DateTime.now()),
  Prime(value: 7, count: 1, firstObtained: DateTime.now()),
]);

class TestBattleScreen extends ConsumerStatefulWidget {
  const TestBattleScreen({super.key});

  @override
  ConsumerState<TestBattleScreen> createState() => _TestBattleScreenState();
}

class _TestBattleScreenState extends ConsumerState<TestBattleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Battle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory),
            onPressed: () {
              print('Inventory button pressed');
              AppRouter.goToInventory(context);
            },
            tooltip: 'Inventory',
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () {
              print('Achievements button pressed');
              AppRouter.goToAchievements(context);
            },
            tooltip: 'Achievements',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Timer display
              _TestTimerSection(),
              
              const SizedBox(height: 20),
              
              // Enemy display
              Expanded(
                flex: 2,
                child: _TestEnemySection(),
              ),
              
              const SizedBox(height: 20),
              
              // Prime grid
              Expanded(
                flex: 3,
                child: _TestPrimeGridSection(),
              ),
              
              const SizedBox(height: 20),
              
              // Action buttons
              _TestActionButtonsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestTimerSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(testTimerProvider);
    final minutes = timer ~/ 60;
    final seconds = timer % 60;
    final formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.timerNormal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Time Remaining',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestEnemySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(testEnemyProvider);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enemy display
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.enemyNormal,
                borderRadius: BorderRadius.circular(16),
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
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'Enemy Composite Number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Attack with prime factors to defeat it!',
              style: TextStyle(
                fontSize: 14,
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

class _TestPrimeGridSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primes = ref.watch(testPrimesProvider);
    final enemy = ref.watch(testEnemyProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Prime Numbers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: primes.length,
            itemBuilder: (context, index) {
              final prime = primes[index];
              final canAttack = enemy % prime.value == 0;
              
              return _TestPrimeButton(
                prime: prime,
                canAttack: canAttack,
                onPressed: () {
                  print('Prime ${prime.value} pressed');
                  if (canAttack) {
                    ref.read(testEnemyProvider.notifier).state = enemy ~/ prime.value;
                    final updatedPrimes = [...primes];
                    updatedPrimes[index] = prime.copyWith(count: prime.count - 1);
                    ref.read(testPrimesProvider.notifier).state = updatedPrimes;
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

class _TestPrimeButton extends StatelessWidget {
  final Prime prime;
  final bool canAttack;
  final VoidCallback? onPressed;

  const _TestPrimeButton({
    required this.prime,
    required this.canAttack,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = prime.count > 0 && canAttack;
    
    return Material(
      color: isAvailable ? AppColors.primeAvailable : AppColors.primeUnavailable,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: isAvailable ? onPressed : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isAvailable ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ),
              ),
              
              const SizedBox(height: 4),
              
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isAvailable 
                      ? AppColors.primaryContainer 
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'x${prime.count}',
                  style: TextStyle(
                    fontSize: 12,
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

class _TestActionButtonsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(testEnemyProvider);
    final canClaimVictory = enemy <= 1 || _isPrime(enemy);
    
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              print('Escape button pressed');
              // Reset enemy
              ref.read(testEnemyProvider.notifier).state = 12;
            },
            child: const Text('Escape'),
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: canClaimVictory
                ? () {
                    print('Claim Victory button pressed');
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Victory!'),
                        content: Text('You defeated the enemy $enemy!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref.read(testEnemyProvider.notifier).state = 12;
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
            child: const Text('Claim Victory!'),
          ),
        ),
      ],
    );
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