import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you'll need to edit this
/// file.
///
/// First, open your project's ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project's Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Composite Hunter'**
  String get appTitle;

  /// No description provided for @practiceMode.
  ///
  /// In en, this message translates to:
  /// **'Practice Mode'**
  String get practiceMode;

  /// No description provided for @stage.
  ///
  /// In en, this message translates to:
  /// **'Stage {number}'**
  String stage(String number);

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @primeInventory.
  ///
  /// In en, this message translates to:
  /// **'Prime Inventory'**
  String get primeInventory;

  /// No description provided for @timeRemaining.
  ///
  /// In en, this message translates to:
  /// **'Time Remaining'**
  String get timeRemaining;

  /// No description provided for @primeNumber.
  ///
  /// In en, this message translates to:
  /// **'Prime Number'**
  String get primeNumber;

  /// No description provided for @compositeNumber.
  ///
  /// In en, this message translates to:
  /// **'Composite Number'**
  String get compositeNumber;

  /// No description provided for @enemyDefeated.
  ///
  /// In en, this message translates to:
  /// **'Enemy is defeated! Claim victory!'**
  String get enemyDefeated;

  /// No description provided for @attackWithPrimeFactors.
  ///
  /// In en, this message translates to:
  /// **'Attack with prime factors to defeat it!'**
  String get attackWithPrimeFactors;

  /// No description provided for @yourPrimeNumbers.
  ///
  /// In en, this message translates to:
  /// **'Your Prime Numbers'**
  String get yourPrimeNumbers;

  /// No description provided for @noPrimesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No primes available for attack'**
  String get noPrimesAvailable;

  /// No description provided for @escape.
  ///
  /// In en, this message translates to:
  /// **'Escape'**
  String get escape;

  /// No description provided for @claimVictory.
  ///
  /// In en, this message translates to:
  /// **'Claim Victory!'**
  String get claimVictory;

  /// No description provided for @victory.
  ///
  /// In en, this message translates to:
  /// **'Victory!'**
  String get victory;

  /// No description provided for @youDefeatedEnemy.
  ///
  /// In en, this message translates to:
  /// **'You defeated the enemy {enemy}!'**
  String youDefeatedEnemy(String enemy);

  /// No description provided for @practiceModeNoItems.
  ///
  /// In en, this message translates to:
  /// **'Practice mode - no items consumed or gained'**
  String get practiceModeNoItems;

  /// No description provided for @keepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing!'**
  String get keepPracticing;

  /// No description provided for @rewardsObtained.
  ///
  /// In en, this message translates to:
  /// **'Rewards obtained:'**
  String get rewardsObtained;

  /// No description provided for @finalPrime.
  ///
  /// In en, this message translates to:
  /// **'Prime {prime} (final result)'**
  String finalPrime(String prime);

  /// No description provided for @usedPrimesReturned.
  ///
  /// In en, this message translates to:
  /// **'Used primes returned:'**
  String get usedPrimesReturned;

  /// No description provided for @continueFighting.
  ///
  /// In en, this message translates to:
  /// **'Continue fighting!'**
  String get continueFighting;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @wrongClaim.
  ///
  /// In en, this message translates to:
  /// **'Wrong Claim!'**
  String get wrongClaim;

  /// No description provided for @stillComposite.
  ///
  /// In en, this message translates to:
  /// **'{number} is still a composite number. Keep attacking!'**
  String stillComposite(String number);

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// No description provided for @timeRanOut.
  ///
  /// In en, this message translates to:
  /// **'Time ran out!'**
  String get timeRanOut;

  /// No description provided for @noAvailableItems.
  ///
  /// In en, this message translates to:
  /// **'No available items to attack!'**
  String get noAvailableItems;

  /// No description provided for @victories.
  ///
  /// In en, this message translates to:
  /// **'Victories'**
  String get victories;

  /// No description provided for @timePlayed.
  ///
  /// In en, this message translates to:
  /// **'Time Played'**
  String get timePlayed;

  /// No description provided for @escapes.
  ///
  /// In en, this message translates to:
  /// **'Escapes'**
  String get escapes;

  /// No description provided for @wrongClaims.
  ///
  /// In en, this message translates to:
  /// **'Wrong Claims'**
  String get wrongClaims;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// No description provided for @attackFasterTip.
  ///
  /// In en, this message translates to:
  /// **'Try to attack faster next time!\nFocus on finding prime factors quickly.'**
  String get attackFasterTip;

  /// No description provided for @collectMorePrimesTip.
  ///
  /// In en, this message translates to:
  /// **'Collect more prime numbers!\nDefeat enemies to gain new primes.'**
  String get collectMorePrimesTip;

  /// No description provided for @stageClear.
  ///
  /// In en, this message translates to:
  /// **'Stage {number} Clear!'**
  String stageClear(String number);

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @perfectClear.
  ///
  /// In en, this message translates to:
  /// **'Perfect Clear!'**
  String get perfectClear;

  /// No description provided for @noEscapesOrWrongClaims.
  ///
  /// In en, this message translates to:
  /// **'No escapes or wrong claims!'**
  String get noEscapesOrWrongClaims;

  /// No description provided for @newRecord.
  ///
  /// In en, this message translates to:
  /// **'New Record!'**
  String get newRecord;

  /// No description provided for @bestPerformance.
  ///
  /// In en, this message translates to:
  /// **'Your best performance yet!'**
  String get bestPerformance;

  /// No description provided for @escapedItemsRestored.
  ///
  /// In en, this message translates to:
  /// **'Escaped - items and time restored'**
  String get escapedItemsRestored;

  /// No description provided for @battleRestarted.
  ///
  /// In en, this message translates to:
  /// **'Battle restarted - items restored'**
  String get battleRestarted;

  /// No description provided for @practiceResults.
  ///
  /// In en, this message translates to:
  /// **'Practice Results'**
  String get practiceResults;

  /// No description provided for @stageResults.
  ///
  /// In en, this message translates to:
  /// **'Stage {number} Results'**
  String stageResults(String number);

  /// No description provided for @nextStage.
  ///
  /// In en, this message translates to:
  /// **'Next Stage'**
  String get nextStage;

  /// No description provided for @stageSelect.
  ///
  /// In en, this message translates to:
  /// **'Stage Select'**
  String get stageSelect;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @totalPrimes.
  ///
  /// In en, this message translates to:
  /// **'Total Primes'**
  String get totalPrimes;

  /// No description provided for @unique.
  ///
  /// In en, this message translates to:
  /// **'Unique'**
  String get unique;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @primeWithValue.
  ///
  /// In en, this message translates to:
  /// **'Prime {number}'**
  String primeWithValue(String number);

  /// No description provided for @firstObtained.
  ///
  /// In en, this message translates to:
  /// **'First obtained: {time}'**
  String firstObtained(String time);

  /// No description provided for @notYetDiscovered.
  ///
  /// In en, this message translates to:
  /// **'Not yet discovered'**
  String get notYetDiscovered;

  /// No description provided for @usageStatistics.
  ///
  /// In en, this message translates to:
  /// **'Usage Statistics'**
  String get usageStatistics;

  /// No description provided for @totalUsage.
  ///
  /// In en, this message translates to:
  /// **'Total Usage'**
  String get totalUsage;

  /// No description provided for @attacksMade.
  ///
  /// In en, this message translates to:
  /// **'attacks made'**
  String get attacksMade;

  /// No description provided for @mostUsedPrime.
  ///
  /// In en, this message translates to:
  /// **'Most Used Prime'**
  String get mostUsedPrime;

  /// No description provided for @timesUsed.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String timesUsed(String count);

  /// No description provided for @primeUsageChart.
  ///
  /// In en, this message translates to:
  /// **'Prime Usage Chart'**
  String get primeUsageChart;

  /// No description provided for @usedTimes.
  ///
  /// In en, this message translates to:
  /// **'Used {count} times'**
  String usedTimes(String count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(String count);

  /// No description provided for @chooseChallenge.
  ///
  /// In en, this message translates to:
  /// **'Choose your challenge stage'**
  String get chooseChallenge;

  /// No description provided for @resetGameData.
  ///
  /// In en, this message translates to:
  /// **'Reset Game Data'**
  String get resetGameData;

  /// No description provided for @resetConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This will reset your inventory and stage progress to initial values. Continue?'**
  String get resetConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @gameDataResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Game data reset successfully'**
  String get gameDataResetSuccess;

  /// No description provided for @errorDuringReset.
  ///
  /// In en, this message translates to:
  /// **'Error during reset: {error}'**
  String errorDuringReset(String error);

  /// No description provided for @resetInventory.
  ///
  /// In en, this message translates to:
  /// **'Reset Inventory'**
  String get resetInventory;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @stage1Title.
  ///
  /// In en, this message translates to:
  /// **'Basic Battle'**
  String get stage1Title;

  /// No description provided for @stage1Description.
  ///
  /// In en, this message translates to:
  /// **'Fight small composite numbers and learn prime factorization'**
  String get stage1Description;

  /// No description provided for @stage2Title.
  ///
  /// In en, this message translates to:
  /// **'Intermediate Challenge'**
  String get stage2Title;

  /// No description provided for @stage2Description.
  ///
  /// In en, this message translates to:
  /// **'Face medium composite numbers with strategic attacks'**
  String get stage2Description;

  /// No description provided for @stage3Title.
  ///
  /// In en, this message translates to:
  /// **'Advanced Path'**
  String get stage3Title;

  /// No description provided for @stage3Description.
  ///
  /// In en, this message translates to:
  /// **'Engage in serious battles with large composite numbers'**
  String get stage3Description;

  /// No description provided for @stage4Title.
  ///
  /// In en, this message translates to:
  /// **'Expert Mode'**
  String get stage4Title;

  /// No description provided for @stage4Description.
  ///
  /// In en, this message translates to:
  /// **'Ultimate challenge for advanced players'**
  String get stage4Description;

  /// No description provided for @achievementProgress.
  ///
  /// In en, this message translates to:
  /// **'Achievement Progress'**
  String get achievementProgress;

  /// No description provided for @achievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'{unlocked} of {total} unlocked'**
  String achievementsUnlocked(String unlocked, String total);

  /// No description provided for @battleAchievements.
  ///
  /// In en, this message translates to:
  /// **'Battle Achievements'**
  String get battleAchievements;

  /// No description provided for @speedAchievements.
  ///
  /// In en, this message translates to:
  /// **'Speed Achievements'**
  String get speedAchievements;

  /// No description provided for @specialAchievements.
  ///
  /// In en, this message translates to:
  /// **'Special Achievements'**
  String get specialAchievements;

  /// No description provided for @firstVictory.
  ///
  /// In en, this message translates to:
  /// **'First Victory'**
  String get firstVictory;

  /// No description provided for @firstVictoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Win your first battle'**
  String get firstVictoryDesc;

  /// No description provided for @primeHunter.
  ///
  /// In en, this message translates to:
  /// **'Prime Hunter'**
  String get primeHunter;

  /// No description provided for @primeHunterDesc.
  ///
  /// In en, this message translates to:
  /// **'Win 10 battles'**
  String get primeHunterDesc;

  /// No description provided for @compositeCrusher.
  ///
  /// In en, this message translates to:
  /// **'Composite Crusher'**
  String get compositeCrusher;

  /// No description provided for @compositeCrusherDesc.
  ///
  /// In en, this message translates to:
  /// **'Win 50 battles'**
  String get compositeCrusherDesc;

  /// No description provided for @lightningFast.
  ///
  /// In en, this message translates to:
  /// **'Lightning Fast'**
  String get lightningFast;

  /// No description provided for @lightningFastDesc.
  ///
  /// In en, this message translates to:
  /// **'Win a battle in under 10 seconds'**
  String get lightningFastDesc;

  /// No description provided for @speedDemon.
  ///
  /// In en, this message translates to:
  /// **'Speed Demon'**
  String get speedDemon;

  /// No description provided for @speedDemonDesc.
  ///
  /// In en, this message translates to:
  /// **'Win 5 battles in under 15 seconds each'**
  String get speedDemonDesc;

  /// No description provided for @powerHunter.
  ///
  /// In en, this message translates to:
  /// **'Power Hunter'**
  String get powerHunter;

  /// No description provided for @powerHunterDesc.
  ///
  /// In en, this message translates to:
  /// **'Defeat 10 power enemies'**
  String get powerHunterDesc;

  /// No description provided for @perfectVictory.
  ///
  /// In en, this message translates to:
  /// **'Perfect Victory'**
  String get perfectVictory;

  /// No description provided for @perfectVictoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Win without any wrong claims or escapes'**
  String get perfectVictoryDesc;

  /// No description provided for @primeCollector.
  ///
  /// In en, this message translates to:
  /// **'Prime Collector'**
  String get primeCollector;

  /// No description provided for @primeCollectorDesc.
  ///
  /// In en, this message translates to:
  /// **'Collect 25 different prime numbers'**
  String get primeCollectorDesc;

  /// No description provided for @tutorialWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nComposite Hunter!'**
  String get tutorialWelcomeTitle;

  /// No description provided for @tutorialWelcomeContent.
  ///
  /// In en, this message translates to:
  /// **'Learn prime factorization through exciting battles with composite numbers.'**
  String get tutorialWelcomeContent;

  /// No description provided for @tutorialBasicTitle.
  ///
  /// In en, this message translates to:
  /// **'Prime vs Composite'**
  String get tutorialBasicTitle;

  /// No description provided for @tutorialBasicContent.
  ///
  /// In en, this message translates to:
  /// **'Prime numbers (2, 3, 5, 7...) can only be divided by 1 and themselves.\n\nComposite numbers (4, 6, 8, 9...) can be divided by other numbers.'**
  String get tutorialBasicContent;

  /// No description provided for @tutorialBasicExample.
  ///
  /// In en, this message translates to:
  /// **'12 = 2 × 2 × 3'**
  String get tutorialBasicExample;

  /// No description provided for @tutorialAttackTitle.
  ///
  /// In en, this message translates to:
  /// **'Attack with Primes'**
  String get tutorialAttackTitle;

  /// No description provided for @tutorialAttackContent.
  ///
  /// In en, this message translates to:
  /// **'Use your prime numbers to attack composite enemies.\n\nIf a prime divides the enemy, the enemy\'s value becomes smaller!'**
  String get tutorialAttackContent;

  /// No description provided for @tutorialAttackExample.
  ///
  /// In en, this message translates to:
  /// **'12 ÷ 2 = 6\n6 ÷ 2 = 3\n3 is prime!'**
  String get tutorialAttackExample;

  /// No description provided for @tutorialVictoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim Victory'**
  String get tutorialVictoryTitle;

  /// No description provided for @tutorialVictoryContent.
  ///
  /// In en, this message translates to:
  /// **'When you reduce an enemy to a prime number, press \"Claim Victory!\"\n\nBe careful - wrong claims cost you time!'**
  String get tutorialVictoryContent;

  /// No description provided for @tutorialVictoryExample.
  ///
  /// In en, this message translates to:
  /// **'Enemy becomes prime?\nClaim Victory! ✓'**
  String get tutorialVictoryExample;

  /// No description provided for @tutorialTimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Pressure'**
  String get tutorialTimerTitle;

  /// No description provided for @tutorialTimerContent.
  ///
  /// In en, this message translates to:
  /// **'Each battle has a time limit!\n\n• Escaping: -10 seconds next battle\n• Wrong claim: -10 seconds immediately\n• Timeout: -10 seconds next battle'**
  String get tutorialTimerContent;

  /// No description provided for @tutorialTimerExample.
  ///
  /// In en, this message translates to:
  /// **'Fight smart and fast!'**
  String get tutorialTimerExample;

  /// No description provided for @tutorialReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Ready to hunt some composite numbers?'**
  String get tutorialReadyMessage;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @startPlaying.
  ///
  /// In en, this message translates to:
  /// **'Start Playing!'**
  String get startPlaying;

  /// No description provided for @selectItems.
  ///
  /// In en, this message translates to:
  /// **'Select Items - Stage {stageNumber}'**
  String selectItems(String stageNumber);

  /// No description provided for @selectedItems.
  ///
  /// In en, this message translates to:
  /// **'Selected Items'**
  String get selectedItems;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remaining;

  /// No description provided for @noItemsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No items available for selection'**
  String get noItemsAvailable;

  /// No description provided for @startBattle.
  ///
  /// In en, this message translates to:
  /// **'Start Battle'**
  String get startBattle;

  /// No description provided for @itemRange.
  ///
  /// In en, this message translates to:
  /// **'Range: {min}-{max}'**
  String itemRange(String min, String max);

  /// No description provided for @timeLimit.
  ///
  /// In en, this message translates to:
  /// **'Time: {seconds}s'**
  String timeLimit(String seconds);

  /// No description provided for @haveCount.
  ///
  /// In en, this message translates to:
  /// **'Have: {count}'**
  String haveCount(String count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue on GitHub with a '
    'reproducible sample app and the gen-l10n configuration that was used.'
  );
}