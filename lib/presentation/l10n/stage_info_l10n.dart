import '../../domain/entities/stage_info.dart';
import '../../flutter_gen/gen_l10n/app_localizations.dart';

extension StageInfoL10n on StageInfo {
  // 国際化対応のためのローカライズされたタイトルを取得
  String getLocalizedTitle(AppLocalizations l10n) {
    switch (stageNumber) {
      case 1:
        return l10n.basicBattle;
      case 2:
        return l10n.intermediateChallenge;
      case 3:
        return l10n.advancedPath;
      case 4:
        return l10n.expertMode;
      default:
        return title; // フォールバック
    }
  }

  // 国際化対応のためのローカライズされた説明を取得
  String getLocalizedDescription(AppLocalizations l10n) {
    switch (stageNumber) {
      case 1:
        return l10n.basicBattleDescription;
      case 2:
        return l10n.intermediateChallengeDescription;
      case 3:
        return l10n.advancedPathDescription;
      case 4:
        return l10n.expertModeDescription;
      default:
        return description; // フォールバック
    }
  }
}
