import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Composite Hunter'**
  String get appTitle;

  /// Practice mode label
  ///
  /// In en, this message translates to:
  /// **'Practice Mode'**
  String get practiceMode;

  /// Stage label with number
  ///
  /// In en, this message translates to:
  /// **'Stage {number}'**
  String stage(String number);

  /// Inventory screen title
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// Collection tab title
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// Statistics tab title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Prime inventory screen title
  ///
  /// In en, this message translates to:
  /// **'Prime Inventory'**
  String get primeInventory;

  /// Timer label
  ///
  /// In en, this message translates to:
  /// **'Time Remaining'**
  String get timeRemaining;

  /// Prime number label
  ///
  /// In en, this message translates to:
  /// **'Prime Number'**
  String get primeNumber;

  /// Composite number label
  ///
  /// In en, this message translates to:
  /// **'Composite Number'**
  String get compositeNumber;

  /// Message when enemy becomes prime
  ///
  /// In en, this message translates to:
  /// **'Enemy is defeated! Claim victory!'**
  String get enemyDefeated;

  /// Instructions for attacking composite numbers
  ///
  /// In en, this message translates to:
  /// **'Attack with prime factors to defeat it!'**
  String get attackWithPrimeFactors;

  /// Prime numbers section title
  ///
  /// In en, this message translates to:
  /// **'Your Prime Numbers'**
  String get yourPrimeNumbers;

  /// Message when no primes are available
  ///
  /// In en, this message translates to:
  /// **'No primes available for attack'**
  String get noPrimesAvailable;

  /// Escape button label
  ///
  /// In en, this message translates to:
  /// **'Escape'**
  String get escape;

  /// Claim victory button label
  ///
  /// In en, this message translates to:
  /// **'Claim Victory!'**
  String get claimVictory;

  /// Victory dialog title
  ///
  /// In en, this message translates to:
  /// **'Victory!'**
  String get victory;

  /// Victory message with enemy number
  ///
  /// In en, this message translates to:
  /// **'You defeated the enemy {enemy}!'**
  String youDefeatedEnemy(String enemy);

  /// Practice mode message
  ///
  /// In en, this message translates to:
  /// **'Practice mode - no items consumed or gained'**
  String get practiceModeNoItems;

  /// Encouragement message for practice mode
  ///
  /// In en, this message translates to:
  /// **'Keep practicing!'**
  String get keepPracticing;

  /// Rewards section title
  ///
  /// In en, this message translates to:
  /// **'Rewards obtained:'**
  String get rewardsObtained;

  /// Final prime reward
  ///
  /// In en, this message translates to:
  /// **'Prime {prime} (final result)'**
  String finalPrime(String prime);

  /// Used primes returned label
  ///
  /// In en, this message translates to:
  /// **'Used primes returned:'**
  String get usedPrimesReturned;

  /// Continue message
  ///
  /// In en, this message translates to:
  /// **'Continue fighting!'**
  String get continueFighting;

  /// Continue button label
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// Wrong claim dialog title
  ///
  /// In en, this message translates to:
  /// **'Wrong Claim!'**
  String get wrongClaim;

  /// Wrong claim message
  ///
  /// In en, this message translates to:
  /// **'{number} is still a composite number. Keep attacking!'**
  String stillComposite(String number);

  /// Game over screen title
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// Time up game over reason
  ///
  /// In en, this message translates to:
  /// **'Time ran out!'**
  String get timeRanOut;

  /// No items game over reason
  ///
  /// In en, this message translates to:
  /// **'No available items to attack!'**
  String get noAvailableItems;

  /// Victories label
  ///
  /// In en, this message translates to:
  /// **'Victories'**
  String get victories;

  /// Time played label
  ///
  /// In en, this message translates to:
  /// **'Time Played'**
  String get timePlayed;

  /// Escapes label
  ///
  /// In en, this message translates to:
  /// **'Escapes'**
  String get escapes;

  /// Wrong claims label
  ///
  /// In en, this message translates to:
  /// **'Wrong Claims'**
  String get wrongClaims;

  /// Tip section title
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// Time up advice
  ///
  /// In en, this message translates to:
  /// **'Try to attack faster next time!\nFocus on finding prime factors quickly.'**
  String get attackFasterTip;

  /// No items advice
  ///
  /// In en, this message translates to:
  /// **'Collect more prime numbers!\nDefeat enemies to gain new primes.'**
  String get collectMorePrimesTip;

  /// Stage clear title
  ///
  /// In en, this message translates to:
  /// **'Stage {number} Clear!'**
  String stageClear(String number);

  /// Total time label
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// Score label
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// Perfect clear bonus
  ///
  /// In en, this message translates to:
  /// **'Perfect Clear!'**
  String get perfectClear;

  /// Perfect clear description
  ///
  /// In en, this message translates to:
  /// **'No escapes or wrong claims!'**
  String get noEscapesOrWrongClaims;

  /// New record bonus
  ///
  /// In en, this message translates to:
  /// **'New Record!'**
  String get newRecord;

  /// New record description
  ///
  /// In en, this message translates to:
  /// **'Your best performance yet!'**
  String get bestPerformance;

  /// Escape feedback message
  ///
  /// In en, this message translates to:
  /// **'Escaped - items and time restored'**
  String get escapedItemsRestored;

  /// Restart feedback message
  ///
  /// In en, this message translates to:
  /// **'Battle restarted - items restored'**
  String get battleRestarted;

  /// Practice mode results title
  ///
  /// In en, this message translates to:
  /// **'Practice Results'**
  String get practiceResults;

  /// Stage results title
  ///
  /// In en, this message translates to:
  /// **'Stage {number} Results'**
  String stageResults(String number);

  /// Next stage button label
  ///
  /// In en, this message translates to:
  /// **'Next Stage'**
  String get nextStage;

  /// Stage select button label
  ///
  /// In en, this message translates to:
  /// **'Stage Select'**
  String get stageSelect;

  /// Play again button label
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// Try again button label
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Total primes count label
  ///
  /// In en, this message translates to:
  /// **'Total Primes'**
  String get totalPrimes;

  /// Unique primes count label
  ///
  /// In en, this message translates to:
  /// **'Unique'**
  String get unique;

  /// Available primes count label
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Prime number with value
  ///
  /// In en, this message translates to:
  /// **'Prime {number}'**
  String primeWithValue(String number);

  /// When prime was first obtained
  ///
  /// In en, this message translates to:
  /// **'First obtained: {time}'**
  String firstObtained(String time);

  /// Prime not yet discovered message
  ///
  /// In en, this message translates to:
  /// **'Not yet discovered'**
  String get notYetDiscovered;

  /// Usage statistics section title
  ///
  /// In en, this message translates to:
  /// **'Usage Statistics'**
  String get usageStatistics;

  /// Total usage label
  ///
  /// In en, this message translates to:
  /// **'Total Usage'**
  String get totalUsage;

  /// Attacks made subtitle
  ///
  /// In en, this message translates to:
  /// **'attacks made'**
  String get attacksMade;

  /// Most used prime label
  ///
  /// In en, this message translates to:
  /// **'Most Used Prime'**
  String get mostUsedPrime;

  /// Usage count
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String timesUsed(String count);

  /// Prime usage chart title
  ///
  /// In en, this message translates to:
  /// **'Prime Usage Chart'**
  String get primeUsageChart;

  /// Prime usage count
  ///
  /// In en, this message translates to:
  /// **'Used {count} times'**
  String usedTimes(String count);

  /// Time ago format
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(String count);

  /// Stage selection subtitle
  ///
  /// In en, this message translates to:
  /// **'Choose your challenge stage'**
  String get chooseChallenge;

  /// Reset dialog title
  ///
  /// In en, this message translates to:
  /// **'Reset Game Data'**
  String get resetGameData;

  /// Reset confirmation message
  ///
  /// In en, this message translates to:
  /// **'This will reset your inventory and stage progress to initial values. Continue?'**
  String get resetConfirmation;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Reset success message
  ///
  /// In en, this message translates to:
  /// **'Game data reset successfully'**
  String get gameDataResetSuccess;

  /// Reset error message
  ///
  /// In en, this message translates to:
  /// **'Error during reset: {error}'**
  String errorDuringReset(String error);

  /// Reset inventory tooltip
  ///
  /// In en, this message translates to:
  /// **'Reset Inventory'**
  String get resetInventory;

  /// Achievements tooltip
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// Stage 1 title
  ///
  /// In en, this message translates to:
  /// **'Basic Battle'**
  String get stage1Title;

  /// Stage 1 description
  ///
  /// In en, this message translates to:
  /// **'Fight small composite numbers and learn prime factorization'**
  String get stage1Description;

  /// Stage 2 title
  ///
  /// In en, this message translates to:
  /// **'Intermediate Challenge'**
  String get stage2Title;

  /// Stage 2 description
  ///
  /// In en, this message translates to:
  /// **'Face medium composite numbers with strategic attacks'**
  String get stage2Description;

  /// Stage 3 title
  ///
  /// In en, this message translates to:
  /// **'Advanced Path'**
  String get stage3Title;

  /// Stage 3 description
  ///
  /// In en, this message translates to:
  /// **'Engage in serious battles with large composite numbers'**
  String get stage3Description;

  /// Stage 4 title
  ///
  /// In en, this message translates to:
  /// **'Expert Mode'**
  String get stage4Title;

  /// Stage 4 description
  ///
  /// In en, this message translates to:
  /// **'Ultimate challenge for advanced players'**
  String get stage4Description;

  /// Achievement progress title
  ///
  /// In en, this message translates to:
  /// **'Achievement Progress'**
  String get achievementProgress;

  /// Achievements unlocked count
  ///
  /// In en, this message translates to:
  /// **'{unlocked} of {total} unlocked'**
  String achievementsUnlocked(String unlocked, String total);

  /// Battle achievements section title
  ///
  /// In en, this message translates to:
  /// **'Battle Achievements'**
  String get battleAchievements;

  /// Speed achievements section title
  ///
  /// In en, this message translates to:
  /// **'Speed Achievements'**
  String get speedAchievements;

  /// Special achievements section title
  ///
  /// In en, this message translates to:
  /// **'Special Achievements'**
  String get specialAchievements;

  /// First victory achievement title
  ///
  /// In en, this message translates to:
  /// **'First Victory'**
  String get firstVictory;

  /// First victory achievement description
  ///
  /// In en, this message translates to:
  /// **'Win your first battle'**
  String get firstVictoryDesc;

  /// Prime hunter achievement title
  ///
  /// In en, this message translates to:
  /// **'Prime Hunter'**
  String get primeHunter;

  /// Prime hunter achievement description
  ///
  /// In en, this message translates to:
  /// **'Win 10 battles'**
  String get primeHunterDesc;

  /// Composite crusher achievement title
  ///
  /// In en, this message translates to:
  /// **'Composite Crusher'**
  String get compositeCrusher;

  /// Composite crusher achievement description
  ///
  /// In en, this message translates to:
  /// **'Win 50 battles'**
  String get compositeCrusherDesc;

  /// Lightning fast achievement title
  ///
  /// In en, this message translates to:
  /// **'Lightning Fast'**
  String get lightningFast;

  /// Lightning fast achievement description
  ///
  /// In en, this message translates to:
  /// **'Win a battle in under 10 seconds'**
  String get lightningFastDesc;

  /// Speed demon achievement title
  ///
  /// In en, this message translates to:
  /// **'Speed Demon'**
  String get speedDemon;

  /// Speed demon achievement description
  ///
  /// In en, this message translates to:
  /// **'Win 5 battles in under 15 seconds each'**
  String get speedDemonDesc;

  /// Power hunter achievement title
  ///
  /// In en, this message translates to:
  /// **'Power Hunter'**
  String get powerHunter;

  /// Power hunter achievement description
  ///
  /// In en, this message translates to:
  /// **'Defeat 10 power enemies'**
  String get powerHunterDesc;

  /// Perfect victory achievement title
  ///
  /// In en, this message translates to:
  /// **'Perfect Victory'**
  String get perfectVictory;

  /// Perfect victory achievement description
  ///
  /// In en, this message translates to:
  /// **'Win without any wrong claims or escapes'**
  String get perfectVictoryDesc;

  /// Prime collector achievement title
  ///
  /// In en, this message translates to:
  /// **'Prime Collector'**
  String get primeCollector;

  /// Prime collector achievement description
  ///
  /// In en, this message translates to:
  /// **'Collect 25 different prime numbers'**
  String get primeCollectorDesc;

  /// Tutorial welcome page title
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nComposite Hunter!'**
  String get tutorialWelcomeTitle;

  /// Tutorial welcome page content
  ///
  /// In en, this message translates to:
  /// **'Learn prime factorization through exciting battles with composite numbers.'**
  String get tutorialWelcomeContent;

  /// Tutorial basic concepts page title
  ///
  /// In en, this message translates to:
  /// **'Prime vs Composite'**
  String get tutorialBasicTitle;

  /// Tutorial basic concepts page content
  ///
  /// In en, this message translates to:
  /// **'Prime numbers (2, 3, 5, 7...) can only be divided by 1 and themselves.\n\nComposite numbers (4, 6, 8, 9...) can be divided by other numbers.'**
  String get tutorialBasicContent;

  /// Tutorial basic concepts example
  ///
  /// In en, this message translates to:
  /// **'12 = 2 × 2 × 3'**
  String get tutorialBasicExample;

  /// Tutorial attack mechanics page title
  ///
  /// In en, this message translates to:
  /// **'Attack with Primes'**
  String get tutorialAttackTitle;

  /// Tutorial attack mechanics page content
  ///
  /// In en, this message translates to:
  /// **'Use your prime numbers to attack composite enemies.\n\nIf a prime divides the enemy, the enemy\'s value becomes smaller!'**
  String get tutorialAttackContent;

  /// Tutorial attack mechanics example
  ///
  /// In en, this message translates to:
  /// **'12 ÷ 2 = 6\n6 ÷ 2 = 3\n3 is prime!'**
  String get tutorialAttackExample;

  /// Tutorial victory condition page title
  ///
  /// In en, this message translates to:
  /// **'Claim Victory'**
  String get tutorialVictoryTitle;

  /// Tutorial victory condition page content
  ///
  /// In en, this message translates to:
  /// **'When you reduce an enemy to a prime number, press \"Claim Victory!\"\n\nBe careful - wrong claims cost you time!'**
  String get tutorialVictoryContent;

  /// Tutorial victory condition example
  ///
  /// In en, this message translates to:
  /// **'Enemy becomes prime?\nClaim Victory! ✓'**
  String get tutorialVictoryExample;

  /// Tutorial timer and penalties page title
  ///
  /// In en, this message translates to:
  /// **'Time Pressure'**
  String get tutorialTimerTitle;

  /// Tutorial timer and penalties page content
  ///
  /// In en, this message translates to:
  /// **'Each battle has a time limit!\n\n• Escaping: -10 seconds next battle\n• Wrong claim: -10 seconds immediately\n• Timeout: -10 seconds next battle'**
  String get tutorialTimerContent;

  /// Tutorial timer and penalties example
  ///
  /// In en, this message translates to:
  /// **'Fight smart and fast!'**
  String get tutorialTimerExample;

  /// Tutorial ready message on last page
  ///
  /// In en, this message translates to:
  /// **'Ready to hunt some composite numbers?'**
  String get tutorialReadyMessage;

  /// Previous button
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Start playing button
  ///
  /// In en, this message translates to:
  /// **'Start Playing!'**
  String get startPlaying;

  /// Item selection screen title
  ///
  /// In en, this message translates to:
  /// **'Select Items - Stage {stageNumber}'**
  String selectItems(String stageNumber);

  /// Selected items header
  ///
  /// In en, this message translates to:
  /// **'Selected Items'**
  String get selectedItems;

  /// Remaining items count suffix
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remaining;

  /// Message when no items are available
  ///
  /// In en, this message translates to:
  /// **'No items available for selection'**
  String get noItemsAvailable;

  /// Start battle button
  ///
  /// In en, this message translates to:
  /// **'Start Battle'**
  String get startBattle;

  /// Enemy range display
  ///
  /// In en, this message translates to:
  /// **'Range: {min}-{max}'**
  String itemRange(String min, String max);

  /// Time limit display
  ///
  /// In en, this message translates to:
  /// **'Time: {seconds}s'**
  String timeLimit(String seconds);

  /// Item count display
  ///
  /// In en, this message translates to:
  /// **'Have: {count}'**
  String haveCount(String count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
