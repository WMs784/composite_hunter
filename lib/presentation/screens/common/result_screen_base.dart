import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../providers/battle_session_provider.dart';
import '../../providers/inventory_provider.dart';

/// 結果画面共通のボタン機能
mixin ResultScreenMixin {
  /// 次のステージに進む
  void goToNextStage(
      BuildContext context, WidgetRef ref, int currentStageNumber) {
    final nextStageNumber = currentStageNumber + 1;

    // バトルセッションをリセット
    ref.read(battleSessionProvider.notifier).resetSession();

    // 現在のアイテム状態を取得
    final currentInventory = ref.read(inventoryProvider);

    // 次のステージを開始
    ref
        .read(battleSessionProvider.notifier)
        .startStage(nextStageNumber, currentInventory);

    // 現在の画面を閉じてバトル画面に遷移
    Navigator.pop(context);
    AppRouter.goToBattle(context);
  }

  /// ステージ選択画面に戻る
  void goToStageSelect(BuildContext context, WidgetRef ref) {
    // アイテム状態を復元
    final session = ref.read(battleSessionProvider);
    if (session.stageStartInventory != null) {
      ref
          .read(inventoryProvider.notifier)
          .restoreInventory(session.stageStartInventory!);
    }

    // バトルセッションをリセット
    ref.read(battleSessionProvider.notifier).resetSession();

    // 現在の画面を閉じてステージ選択画面に戻る
    Navigator.pop(context);
    AppRouter.goToStageSelect(context);
  }

  /// 同じステージを再プレイ
  void retryStage(BuildContext context, WidgetRef ref, int stageNumber) {
    // アイテム状態を復元
    final session = ref.read(battleSessionProvider);
    if (session.stageStartInventory != null) {
      ref
          .read(inventoryProvider.notifier)
          .restoreInventory(session.stageStartInventory!);
    }

    // バトルセッションをリセット
    ref.read(battleSessionProvider.notifier).resetSession();

    // 現在のアイテム状態を取得
    final currentInventory = ref.read(inventoryProvider);

    // 同じステージを再開
    ref
        .read(battleSessionProvider.notifier)
        .startStage(stageNumber, currentInventory);

    // 現在の画面を閉じてバトル画面に遷移
    Navigator.pop(context);
    AppRouter.goToBattle(context);
  }

  /// 練習モードを開始
  void goToPractice(BuildContext context, WidgetRef ref) {
    // アイテム状態を復元
    final session = ref.read(battleSessionProvider);
    if (session.stageStartInventory != null) {
      ref
          .read(inventoryProvider.notifier)
          .restoreInventory(session.stageStartInventory!);
    }

    // バトルセッションをリセット
    ref.read(battleSessionProvider.notifier).resetSession();

    // 練習モードを開始
    final currentInventory = ref.read(inventoryProvider);
    ref.read(battleSessionProvider.notifier).startPractice(currentInventory);

    // 現在の画面を閉じてバトル画面に戻る
    Navigator.pop(context);
    AppRouter.goToBattle(context);
  }
}

/// 共通のボタンレイアウト
class ResultScreenButtons extends StatelessWidget {
  final int? stageNumber;
  final bool isPracticeMode;
  final bool isSuccess;
  final VoidCallback? onNextStage;
  final VoidCallback onStageSelect;
  final VoidCallback onRetry;
  final VoidCallback onPractice;

  const ResultScreenButtons({
    super.key,
    this.stageNumber,
    this.isPracticeMode = false,
    this.isSuccess = false,
    this.onNextStage,
    required this.onStageSelect,
    required this.onRetry,
    required this.onPractice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 次のステージボタン（成功時かつ最終ステージでない場合のみ）
        if (isSuccess &&
            !isPracticeMode &&
            stageNumber != null &&
            stageNumber! < 4 &&
            onNextStage != null)
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onNextStage,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next Stage'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingM),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.spacingM),
            ],
          ),

        // ステージ選択に戻るボタン
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onStageSelect,
            icon: const Icon(Icons.list),
            label: const Text('Stage Select'),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimensions.paddingM),
            ),
          ),
        ),

        const SizedBox(height: Dimensions.spacingM),

        // 再挑戦ボタン
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(isSuccess ? 'Play Again' : 'Try Again'),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimensions.paddingM),
            ),
          ),
        ),

        const SizedBox(height: Dimensions.spacingS),

        // 練習モードボタン
        TextButton.icon(
          onPressed: onPractice,
          icon: const Icon(Icons.school),
          label: const Text('Practice Mode'),
        ),
      ],
    );
  }
}
