import '../../domain/entities/achievement.dart';
import '../../flutter_gen/gen_l10n/app_localizations.dart';

/// Localized achievement text, keyed by achievement id.
/// Falls back to the stored (English) text for unknown ids.
extension AchievementL10n on AppLocalizations {
  String achievementTitle(Achievement a) {
    switch (a.id) {
      case 'first_victory':
        return achFirstVictoryTitle;
      case 'battle_veteran':
        return achBattleVeteranTitle;
      case 'victory_streak_10':
        return achVictoryStreak10Title;
      case 'victory_streak_25':
        return achVictoryStreak25Title;
      case 'power_hunter':
        return achPowerHunterTitle;
      case 'power_slayer':
        return achPowerSlayerTitle;
      case 'speed_demon':
        return achSpeedDemonTitle;
      case 'lightning_fast':
        return achLightningFastTitle;
      case 'efficient_hunter':
        return achEfficientHunterTitle;
      case 'minimalist':
        return achMinimalistTitle;
      case 'collector':
        return achCollectorTitle;
      case 'hoarder':
        return achHoarderTitle;
      case 'large_prime_collector':
        return achLargePrimeCollectorTitle;
      case 'level_up_10':
        return achLevelUp10Title;
      case 'level_up_25':
        return achLevelUp25Title;
      case 'level_up_50':
        return achLevelUp50Title;
      case 'perfect_battle':
        return achPerfectBattleTitle;
      case 'giant_slayer':
        return achGiantSlayerTitle;
      case 'comeback_king':
        return achComebackKingTitle;
      default:
        return a.title;
    }
  }

  String achievementDescription(Achievement a) {
    switch (a.id) {
      case 'first_victory':
        return achFirstVictoryDesc;
      case 'battle_veteran':
        return achBattleVeteranDesc;
      case 'victory_streak_10':
        return achVictoryStreak10Desc;
      case 'victory_streak_25':
        return achVictoryStreak25Desc;
      case 'power_hunter':
        return achPowerHunterDesc;
      case 'power_slayer':
        return achPowerSlayerDesc;
      case 'speed_demon':
        return achSpeedDemonDesc;
      case 'lightning_fast':
        return achLightningFastDesc;
      case 'efficient_hunter':
        return achEfficientHunterDesc;
      case 'minimalist':
        return achMinimalistDesc;
      case 'collector':
        return achCollectorDesc;
      case 'hoarder':
        return achHoarderDesc;
      case 'large_prime_collector':
        return achLargePrimeCollectorDesc;
      case 'level_up_10':
        return achLevelUp10Desc;
      case 'level_up_25':
        return achLevelUp25Desc;
      case 'level_up_50':
        return achLevelUp50Desc;
      case 'perfect_battle':
        return achPerfectBattleDesc;
      case 'giant_slayer':
        return achGiantSlayerDesc;
      case 'comeback_king':
        return achComebackKingDesc;
      default:
        return a.description;
    }
  }
}
