import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/prime_usage_provider.dart';
import '../../../domain/entities/prime.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.primeInventory),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: cs.primary,
          labelColor: cs.onPrimary,
          unselectedLabelColor: cs.onSurfaceVariant,
          tabs: [
            Tab(icon: const Icon(Icons.inventory), text: l10n.inventory),
            Tab(icon: const Icon(Icons.book), text: l10n.collection),
            Tab(icon: const Icon(Icons.analytics), text: l10n.statistics),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInventoryTab(),
          _buildCollectionTab(),
          _buildStatisticsTab(),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final inventory = ref.watch(inventoryProvider);
    final usageStats = ref.watch(primeUsageProvider);
    final availablePrimes = inventory.where((p) => p.count > 0).toList();

    return Column(
      children: [
        // Summary card
        Container(
          margin: const EdgeInsets.all(Dimensions.paddingM),
          padding: const EdgeInsets.all(Dimensions.paddingL),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                context,
                l10n.totalPrimes,
                inventory.fold(0, (sum, p) => sum + p.count).toString(),
                Icons.numbers,
              ),
              _buildSummaryItem(
                context,
                l10n.unique,
                inventory.length.toString(),
                Icons.category,
              ),
              _buildSummaryItem(
                context,
                l10n.available,
                availablePrimes.length.toString(),
                Icons.check_circle,
              ),
            ],
          ),
        ),

        // Prime list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingM,
            ),
            itemCount: availablePrimes.length,
            itemBuilder: (context, index) {
              final prime = availablePrimes[index];
              final usage = usageStats[prime.value] ?? 0;
              return _buildPrimeItem(prime, usage, l10n);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionTab() {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final inventory = ref.watch(inventoryProvider);
    final usageStats = ref.watch(primeUsageProvider);
    final availableItems = inventory.where((prime) => prime.count > 0).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      itemCount: availableItems.length,
      itemBuilder: (context, index) {
        final prime = availableItems[index];
        final usage = usageStats[prime.value] ?? 0;
        final isUnlocked = usage > 0 || prime.count > 0;
        final daysSinceObtained = DateTime.now()
            .difference(prime.firstObtained)
            .inDays;

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isUnlocked
                  ? cs.primary
                  : cs.surfaceContainerHighest,
              child: Text(
                prime.value.toString(),
                style: AppTextStyles.labelLarge.copyWith(
                  color: isUnlocked ? cs.onPrimary : cs.onSurfaceVariant,
                ),
              ),
            ),
            title: Text(
              l10n.primeWithValue(prime.value.toString()),
              style: AppTextStyles.titleMedium.copyWith(
                color: isUnlocked ? cs.onSurface : cs.onSurfaceVariant,
              ),
            ),
            subtitle: Text(
              isUnlocked
                  ? l10n.firstObtained(
                      l10n.daysAgo(daysSinceObtained.toString()),
                    )
                  : l10n.notYetDiscovered,
              style: AppTextStyles.bodySmall.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(Dimensions.paddingXs),
              decoration: BoxDecoration(
                color: isUnlocked
                    ? AppColors.victoryGreen.withValues(alpha: 0.1)
                    : cs.surface,
                borderRadius: BorderRadius.circular(Dimensions.radiusS),
                border: Border.all(
                  color: isUnlocked ? AppColors.victoryGreen : cs.outline,
                  width: 1,
                ),
              ),
              child: Icon(
                isUnlocked ? Icons.check_circle : Icons.lock,
                color: isUnlocked
                    ? AppColors.victoryGreen
                    : cs.onSurfaceVariant,
                size: Dimensions.iconS,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatisticsTab() {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final inventory = ref.watch(inventoryProvider);
    final usageStats = ref.watch(primeUsageProvider);
    final usageNotifier = ref.read(primeUsageProvider.notifier);
    final totalUsage = usageNotifier.totalUsage;
    final mostUsedPrime = usageNotifier.mostUsedPrime;
    final availablePrimes = inventory.where((p) => p.count > 0).toList();

    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.usageStatistics, style: AppTextStyles.headlineSmall),
          const SizedBox(height: Dimensions.spacingL),
          _buildStatCard(
            l10n.totalUsage,
            totalUsage.toString(),
            l10n.attacksMade,
            Icons.gps_fixed,
            cs.primary,
          ),
          const SizedBox(height: Dimensions.spacingM),
          if (mostUsedPrime != null)
            _buildStatCard(
              l10n.mostUsedPrime,
              mostUsedPrime.toString(),
              l10n.timesUsed(usageStats[mostUsedPrime].toString()),
              Icons.star,
              AppColors.victoryGreen,
            )
          else
            _buildStatCard(
              l10n.mostUsedPrime,
              '-',
              l10n.timesUsed('0'),
              Icons.star,
              AppColors.victoryGreen,
            ),
          const SizedBox(height: Dimensions.spacingL),
          Text(l10n.primeUsageChart, style: AppTextStyles.titleMedium),
          const SizedBox(height: Dimensions.spacingM),
          Expanded(
            child: ListView.builder(
              itemCount: availablePrimes.length,
              itemBuilder: (context, index) {
                final prime = availablePrimes[index];
                final usage = usageStats[prime.value] ?? 0;
                final percentage = totalUsage > 0 ? usage / totalUsage : 0.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.spacingXs,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          prime.value.toString(),
                          style: AppTextStyles.labelMedium,
                        ),
                      ),
                      const SizedBox(width: Dimensions.spacingM),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: cs.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
                        ),
                      ),
                      const SizedBox(width: Dimensions.spacingM),
                      SizedBox(
                        width: 40,
                        child: Text(
                          usage.toString(),
                          style: AppTextStyles.labelMedium,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingS),
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.radiusS),
          ),
          child: Icon(icon, color: cs.primary, size: Dimensions.iconM),
        ),
        const SizedBox(height: Dimensions.spacingXs),
        Text(
          value,
          style: AppTextStyles.titleLarge.copyWith(
            color: cs.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: cs.onPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimeItem(Prime prime, int usage, AppLocalizations l10n) {
    final cs = Theme.of(context).colorScheme;
    final isAvailable = prime.count > 0;
    final isRecentlyObtained =
        DateTime.now().difference(prime.firstObtained).inMinutes < 5;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.spacingXs),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isAvailable ? cs.primary : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
            border: isRecentlyObtained
                ? Border.all(color: AppColors.victoryGreen, width: 2)
                : null,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  prime.value.toString(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isAvailable ? cs.onPrimary : cs.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isRecentlyObtained)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.victoryGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.star, color: Colors.white, size: 8),
                  ),
                ),
            ],
          ),
        ),
        title: Text(
          l10n.primeWithValue(prime.value.toString()),
          style: AppTextStyles.titleMedium,
        ),
        subtitle: Text(
          l10n.usedTimes(usage.toString()),
          style: AppTextStyles.bodySmall.copyWith(color: cs.onSurfaceVariant),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingM,
            vertical: Dimensions.paddingS,
          ),
          decoration: BoxDecoration(
            color: isAvailable
                ? cs.primaryContainer
                : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Dimensions.radiusS),
          ),
          child: Text(
            'x${prime.count}',
            style: AppTextStyles.labelLarge.copyWith(
              color: isAvailable ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingL),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: color, size: Dimensions.iconL),
            ),
            const SizedBox(width: Dimensions.spacingL),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleMedium),
                  const SizedBox(height: Dimensions.spacingXs),
                  Text(
                    value,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
