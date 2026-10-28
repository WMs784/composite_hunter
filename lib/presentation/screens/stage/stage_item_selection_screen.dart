import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../widgets/prime_gem_painter.dart';
import '../../../domain/entities/prime.dart';
import 'stage_select_screen.dart';
import '../../../core/utils/logger.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';

/// ステージ用アイテム選択画面
class StageItemSelectionScreen extends ConsumerStatefulWidget {
  final StageInfo stage;

  const StageItemSelectionScreen({super.key, required this.stage});

  @override
  ConsumerState<StageItemSelectionScreen> createState() =>
      _StageItemSelectionScreenState();
}

class _StageItemSelectionScreenState
    extends ConsumerState<StageItemSelectionScreen> {
  Map<int, int> selectedCounts = {}; // prime value -> selected count

  /// ステージ別アイテム制限数を取得（総個数）
  int get maxSelectableCount {
    switch (widget.stage.stageNumber) {
      case 1:
        return 8; // 初心者向け：8個まで
      case 2:
        return 15; // 中級者向け：15個まで
      case 3:
        return 25; // 上級者向け：25個まで
      case 4:
        return 40; // 最上級者向け：40個まで
      default:
        return 15;
    }
  }

  /// 選択状態の確認
  int get totalSelectedCount =>
      selectedCounts.values.fold(0, (sum, count) => sum + count);
  bool get hasMinimumSelection => totalSelectedCount > 0;
  bool get hasReachedLimit => totalSelectedCount >= maxSelectableCount;
  int get remainingCount => maxSelectableCount - totalSelectedCount;

  @override
  Widget build(BuildContext context) {
    final allPrimes = ref.watch(inventoryProvider);
    final availablePrimes = allPrimes
        .where((prime) => prime.count > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(
            context,
          )!.selectItems(widget.stage.stageNumber.toString()),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ステージ情報ヘッダー
            _buildStageInfoHeader(),

            const SizedBox(height: Dimensions.spacingM),

            // 選択状況表示
            _buildSelectionStatus(),

            const SizedBox(height: Dimensions.spacingM),

            // アイテム選択グリッド
            Expanded(child: _buildItemSelectionGrid(availablePrimes)),

            const SizedBox(height: Dimensions.spacingM),

            // 開始ボタン
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  /// ステージ情報ヘッダー
  Widget _buildStageInfoHeader() {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(Dimensions.paddingM),
      padding: const EdgeInsets.all(Dimensions.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimensions.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(Dimensions.radiusM),
                ),
                child: Center(
                  child: Text(
                    widget.stage.stageNumber.toString(),
                    style: AppTextStyles.titleMedium.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.stage.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spacingXs),
                    Text(
                      widget.stage.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: cs.onPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.spacingM),
          Row(
            children: [
              _buildInfoChip(
                Icons.numbers,
                AppLocalizations.of(context)!.itemRange(
                  widget.stage.enemyRangeMin.toString(),
                  widget.stage.enemyRangeMax.toString(),
                ),
              ),
              const SizedBox(width: Dimensions.spacingS),
              _buildInfoChip(
                Icons.timer,
                AppLocalizations.of(
                  context,
                )!.timeLimit(widget.stage.timeLimit.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 選択状況表示
  Widget _buildSelectionStatus() {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingM),
      padding: const EdgeInsets.all(Dimensions.paddingM),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(color: cs.outline),
      ),
      child: Row(
        children: [
          Icon(Icons.inventory_2, color: cs.onPrimaryContainer, size: 24),
          const SizedBox(width: Dimensions.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.selectedItems,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: cs.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: Dimensions.spacingXs),
                Row(
                  children: [
                    Text(
                      '$totalSelectedCount',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' / $maxSelectableCount',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(width: Dimensions.spacingS),
                    Text(
                      '($remainingCount ${AppLocalizations.of(context)!.remaining})',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: cs.onPrimaryContainer.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 選択制限の視覚的表示
          Container(
            width: 80,
            height: 8,
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: totalSelectedCount / maxSelectableCount,
              child: Container(
                decoration: BoxDecoration(
                  color: hasReachedLimit ? cs.error : cs.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// アイテム選択グリッド
  Widget _buildItemSelectionGrid(List<Prime> availablePrimes) {
    if (availablePrimes.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noItemsAvailable,
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingM),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          crossAxisSpacing: Dimensions.spacingS,
          mainAxisSpacing: Dimensions.spacingS,
        ),
        itemCount: availablePrimes.length,
        itemBuilder: (context, index) {
          final prime = availablePrimes[index];
          final selectedCount = selectedCounts[prime.value] ?? 0;
          final canIncrease = remainingCount > 0;
          final canDecrease = selectedCount > 0;

          return _SelectableItemCard(
            prime: prime,
            selectedCount: selectedCount,
            canIncrease: canIncrease,
            canDecrease: canDecrease,
            onIncrease: () => _increaseItemCount(prime.value),
            onDecrease: () => _decreaseItemCount(prime.value),
          );
        },
      ),
    );
  }

  /// 開始ボタン
  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(Dimensions.paddingM),
      child: ElevatedButton(
        onPressed: hasMinimumSelection ? _startBattleWithSelectedItems : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingL),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_arrow),
            const SizedBox(width: Dimensions.spacingS),
            Text(
              AppLocalizations.of(context)!.startBattle,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 情報チップ
  Widget _buildInfoChip(IconData icon, String text) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingS,
        vertical: Dimensions.paddingXs,
      ),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(Dimensions.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: cs.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(color: cs.onSurface),
          ),
        ],
      ),
    );
  }

  /// アイテム個数増加処理
  void _increaseItemCount(int primeValue) {
    if (remainingCount > 0) {
      setState(() {
        selectedCounts[primeValue] = (selectedCounts[primeValue] ?? 0) + 1;
      });
    }
  }

  /// アイテム個数減少処理
  void _decreaseItemCount(int primeValue) {
    final currentCount = selectedCounts[primeValue] ?? 0;
    if (currentCount > 0) {
      setState(() {
        if (currentCount == 1) {
          selectedCounts.remove(primeValue);
        } else {
          selectedCounts[primeValue] = currentCount - 1;
        }
      });
    }
  }

  /// 選択されたアイテムでバトル開始
  void _startBattleWithSelectedItems() {
    Logger.logBattle(
      'Starting battle with selected counts',
      data: {'selected_counts': selectedCounts},
    );
    Logger.logBattle(
      'Total selected count',
      data: {'total_count': totalSelectedCount},
    );

    // 選択されたアイテムで一時的なインベントリを作成
    final selectedInventory = _createSelectedInventory();

    // 現在のメインインベントリを取得
    final originalMainInventory = ref.read(inventoryProvider);

    // バトルセッションを開始（選択されたアイテムのみ）
    ref
        .read(battleSessionProvider.notifier)
        .startStageWithSelectedItems(
          widget.stage.stageNumber,
          selectedInventory,
          originalMainInventory,
        );

    // バトル画面に遷移
    AppRouter.goToBattle(context);
  }

  /// 選択されたアイテムからインベントリを作成
  List<Prime> _createSelectedInventory() {
    final allPrimes = ref.read(inventoryProvider);
    List<Prime> selectedInventory = [];

    for (final entry in selectedCounts.entries) {
      final primeValue = entry.key;
      final selectedCount = entry.value;

      // 元のアイテムを見つけて、選択された個数で新しいPrimeオブジェクトを作成
      final originalPrime = allPrimes.firstWhere(
        (prime) => prime.value == primeValue,
        orElse: () =>
            Prime(value: primeValue, count: 0, firstObtained: DateTime.now()),
      );

      if (selectedCount > 0) {
        selectedInventory.add(
          Prime(
            value: primeValue,
            count: selectedCount,
            firstObtained: originalPrime.firstObtained,
          ),
        );
      }
    }

    return selectedInventory;
  }
}

/// 選択可能なアイテムカード（個数選択対応）
class _SelectableItemCard extends StatelessWidget {
  final Prime prime;
  final int selectedCount;
  final bool canIncrease;
  final bool canDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _SelectableItemCard({
    required this.prime,
    required this.selectedCount,
    required this.canIncrease,
    required this.canDecrease,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isSelected = selectedCount > 0;
    final canAdd = canIncrease && selectedCount < prime.count;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusM),
        border: Border.all(
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.15),
          width: isSelected ? 2.5 : 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.radiusM - 1),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Gem fills card background
            RepaintBoundary(
              child: CustomPaint(
                painter: PrimeGemPainter(
                  primeValue: prime.value,
                  isAvailable: true,
                ),
              ),
            ),
            // Text + controls overlay
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  prime.value.toString(),
                  style: GoogleFonts.fredoka(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
                      Shadow(blurRadius: 3, color: Colors.black54),
                    ],
                  ),
                ),
                Text(
                  'x${prime.count}',
                  style: GoogleFonts.fredoka(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.85),
                    shadows: const [
                      Shadow(blurRadius: 2, color: Colors.black38),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ctrlBtn(Icons.remove, canDecrease ? onDecrease : null, cs),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '$selectedCount',
                        style: GoogleFonts.fredoka(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _ctrlBtn(Icons.add, canAdd ? onIncrease : null, cs),
                  ],
                ),
              ],
            ),
            // Selection checkmark badge
            if (isSelected)
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: 10, color: cs.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _ctrlBtn(IconData icon, VoidCallback? onTap, ColorScheme cs) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: enabled
              ? Colors.white.withValues(alpha: 0.90)
              : Colors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: enabled ? cs.primary : Colors.white.withValues(alpha: 0.50),
          size: 12,
        ),
      ),
    );
  }
}
