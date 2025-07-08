import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';

class BattleScreen extends StatelessWidget {
  const BattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle'),
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
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingM),
          child: Column(
            children: [
              // Timer display
              _TimerSection(),
              
              SizedBox(height: Dimensions.spacingL),
              
              // Enemy display
              Expanded(
                flex: 2,
                child: _EnemySection(),
              ),
              
              SizedBox(height: Dimensions.spacingL),
              
              // Prime grid
              Expanded(
                flex: 3,
                child: _PrimeGridSection(),
              ),
              
              SizedBox(height: Dimensions.spacingL),
              
              // Action buttons
              _ActionButtonsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerSection extends StatelessWidget {
  const _TimerSection();

  @override
  Widget build(BuildContext context) {
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
              '01:30',
              style: AppTextStyles.timerDisplay.copyWith(
                color: AppColors.timerNormal,
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

class _EnemySection extends StatelessWidget {
  const _EnemySection();

  @override
  Widget build(BuildContext context) {
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
                  '12',
                  style: AppTextStyles.enemyValue.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: Dimensions.spacingM),
            
            Text(
              'Enemy Composite Number',
              style: AppTextStyles.titleMedium,
            ),
            
            const SizedBox(height: Dimensions.spacingS),
            
            Text(
              'Attack with prime factors to defeat it!',
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

class _PrimeGridSection extends StatelessWidget {
  const _PrimeGridSection();

  @override
  Widget build(BuildContext context) {
    // Sample prime numbers for display
    final primes = [2, 3, 5, 7, 11, 13, 17, 19];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Prime Numbers',
          style: AppTextStyles.titleMedium,
        ),
        
        const SizedBox(height: Dimensions.spacingM),
        
        Expanded(
          child: GridView.builder(
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
                value: prime,
                count: 3,
                onPressed: () {
                  // TODO: Handle prime selection
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
  final int value;
  final int count;
  final VoidCallback? onPressed;

  const _PrimeButton({
    required this.value,
    required this.count,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = count > 0;
    
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
                value.toString(),
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
                  'x$count',
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

class _ActionButtonsSection extends StatelessWidget {
  const _ActionButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: Handle escape
            },
            child: const Text('Escape'),
          ),
        ),
        
        const SizedBox(width: Dimensions.spacingM),
        
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Handle victory claim
            },
            child: const Text('Claim Victory!'),
          ),
        ),
      ],
    );
  }
}