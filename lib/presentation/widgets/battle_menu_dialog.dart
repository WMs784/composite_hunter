import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/dimensions.dart';
import '../../flutter_gen/gen_l10n/app_localizations.dart';

class BattleMenuDialog extends StatelessWidget {
  final VoidCallback? onRestart;
  final VoidCallback? onExit;

  const BattleMenuDialog({super.key, this.onRestart, this.onExit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingL),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(Dimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ヘッダー
            Row(
              children: [
                const Icon(Icons.menu, color: AppColors.primary, size: 28),
                const SizedBox(width: Dimensions.spacingM),
                Expanded(
                  child: Text(
                    l10n.menu,
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  iconSize: 24,
                ),
              ],
            ),

            const SizedBox(height: Dimensions.spacingL),

            // メニューオプション
            _MenuOption(
              icon: Icons.refresh,
              title: l10n.restart,
              description: l10n.restartDescription,
              color: AppColors.primary,
              onTap: () {
                Navigator.of(context).pop();
                onRestart?.call();
              },
            ),

            const SizedBox(height: Dimensions.spacingM),

            _MenuOption(
              icon: Icons.exit_to_app,
              title: l10n.exit,
              description: l10n.exitDescription,
              color: AppColors.error,
              onTap: () {
                Navigator.of(context).pop();
                _showExitConfirmation(context);
              },
            ),

            const SizedBox(height: Dimensions.spacingL),

            // Cancel button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingM,
                  ),
                ),
                child: Text(l10n.back),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.exitBattleTitle),
        content: Text(l10n.exitBattleConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close confirmation dialog
              onExit?.call();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.exit),
          ),
        ],
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback? onTap;

  const _MenuOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimensions.radiusM),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.paddingM),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusM),
          border: Border.all(color: AppColors.outline),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingM),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: Dimensions.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: Dimensions.spacingXs),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
