import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Composite Hunter';

  @override
  String get practiceMode => 'Practice Mode';

  @override
  String stage(String number) {
    return 'Stage $number';
  }

  @override
  String get inventory => 'Inventory';

  @override
  String get collection => 'Collection';

  @override
  String get statistics => 'Statistics';

  @override
  String get primeInventory => 'Prime Inventory';

  @override
  String get timeRemaining => 'Time Remaining';

  @override
  String get primeNumber => 'Prime Number';

  @override
  String get compositeNumber => 'Composite Number';

  @override
  String get enemyDefeated => 'Enemy is defeated! Claim victory!';

  @override
  String get attackWithPrimeFactors =>
      'Attack with prime factors to defeat it!';

  @override
  String get yourPrimeNumbers => 'Your Prime Numbers';

  @override
  String get noPrimesAvailable => 'No primes available for attack';

  @override
  String get escape => 'Escape';

  @override
  String get claimVictory => 'Claim Victory!';

  @override
  String get victory => 'Victory!';

  @override
  String youDefeatedEnemy(String enemy) {
    return 'You defeated the enemy $enemy!';
  }

  @override
  String get practiceModeNoItems =>
      'Practice mode - no items consumed or gained';

  @override
  String get keepPracticing => 'Keep practicing!';

  @override
  String get rewardsObtained => 'Rewards obtained:';

  @override
  String finalPrime(String prime) {
    return 'Prime $prime (final result)';
  }

  @override
  String get usedPrimesReturned => 'Used primes returned:';

  @override
  String get continueFighting => 'Continue fighting!';

  @override
  String get continueAction => 'Continue';

  @override
  String get wrongClaim => 'Wrong Claim!';

  @override
  String stillComposite(String number) {
    return '$number is still a composite number. Keep attacking!';
  }

  @override
  String get gameOver => 'Game Over';

  @override
  String get timeRanOut => 'Time ran out!';

  @override
  String get noAvailableItems => 'No available items to attack!';

  @override
  String get victories => 'Victories';

  @override
  String get timePlayed => 'Time Played';

  @override
  String get escapes => 'Escapes';

  @override
  String get wrongClaims => 'Wrong Claims';

  @override
  String get tip => 'Tip';

  @override
  String get attackFasterTip =>
      'Try to attack faster next time!\nFocus on finding prime factors quickly.';

  @override
  String get collectMorePrimesTip =>
      'Collect more prime numbers!\nDefeat enemies to gain new primes.';

  @override
  String stageClear(String number) {
    return 'Stage $number Clear!';
  }

  @override
  String get totalTime => 'Total Time';

  @override
  String get score => 'Score';

  @override
  String get perfectClear => 'Perfect Clear!';

  @override
  String get noEscapesOrWrongClaims => 'No escapes or wrong claims!';

  @override
  String get newRecord => 'New Record!';

  @override
  String get bestPerformance => 'Your best performance yet!';

  @override
  String get escapedItemsRestored => 'Escaped - items and time restored';

  @override
  String get battleRestarted => 'Battle restarted - items restored';

  @override
  String get practiceResults => 'Practice Results';

  @override
  String stageResults(String number) {
    return 'Stage $number Results';
  }

  @override
  String get nextStage => 'Next Stage';

  @override
  String get stageSelect => 'Stage Select';

  @override
  String get playAgain => 'Play Again';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get totalPrimes => 'Total Primes';

  @override
  String get unique => 'Unique';

  @override
  String get available => 'Available';

  @override
  String primeWithValue(String number) {
    return 'Prime $number';
  }

  @override
  String firstObtained(String time) {
    return 'First obtained: $time';
  }

  @override
  String get notYetDiscovered => 'Not yet discovered';

  @override
  String get usageStatistics => 'Usage Statistics';

  @override
  String get totalUsage => 'Total Usage';

  @override
  String get attacksMade => 'attacks made';

  @override
  String get mostUsedPrime => 'Most Used Prime';

  @override
  String timesUsed(String count) {
    return '$count times';
  }

  @override
  String get primeUsageChart => 'Prime Usage Chart';

  @override
  String usedTimes(String count) {
    return 'Used $count times';
  }

  @override
  String daysAgo(String count) {
    return '$count days ago';
  }

  @override
  String get chooseChallenge => 'Choose your challenge stage';

  @override
  String get resetGameData => 'Reset Game Data';

  @override
  String get resetConfirmation =>
      'This will reset your inventory and stage progress to initial values. Continue?';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get gameDataResetSuccess => 'Game data reset successfully';

  @override
  String errorDuringReset(String error) {
    return 'Error during reset: $error';
  }

  @override
  String get resetInventory => 'Reset Inventory';

  @override
  String get achievements => 'Achievements';

  @override
  String get stage1Title => 'Basic Battle';

  @override
  String get stage1Description =>
      'Fight small composite numbers and learn prime factorization';

  @override
  String get stage2Title => 'Intermediate Challenge';

  @override
  String get stage2Description =>
      'Face medium composite numbers with strategic attacks';

  @override
  String get stage3Title => 'Advanced Path';

  @override
  String get stage3Description =>
      'Engage in serious battles with large composite numbers';

  @override
  String get stage4Title => 'Expert Mode';

  @override
  String get stage4Description => 'Ultimate challenge for advanced players';

  @override
  String get achievementProgress => 'Achievement Progress';

  @override
  String achievementsUnlocked(String unlocked, String total) {
    return '$unlocked of $total unlocked';
  }

  @override
  String get battleAchievements => 'Battle Achievements';

  @override
  String get speedAchievements => 'Speed Achievements';

  @override
  String get specialAchievements => 'Special Achievements';

  @override
  String get firstVictory => 'First Victory';

  @override
  String get firstVictoryDesc => 'Win your first battle';

  @override
  String get primeHunter => 'Prime Hunter';

  @override
  String get primeHunterDesc => 'Win 10 battles';

  @override
  String get compositeCrusher => 'Composite Crusher';

  @override
  String get compositeCrusherDesc => 'Win 50 battles';

  @override
  String get lightningFast => 'Lightning Fast';

  @override
  String get lightningFastDesc => 'Win a battle in under 10 seconds';

  @override
  String get speedDemon => 'Speed Demon';

  @override
  String get speedDemonDesc => 'Win 5 battles in under 15 seconds each';

  @override
  String get powerHunter => 'Power Hunter';

  @override
  String get powerHunterDesc => 'Defeat 10 power enemies';

  @override
  String get perfectVictory => 'Perfect Victory';

  @override
  String get perfectVictoryDesc => 'Win without any wrong claims or escapes';

  @override
  String get primeCollector => 'Prime Collector';

  @override
  String get primeCollectorDesc => 'Collect 25 different prime numbers';

  @override
  String get tutorialWelcomeTitle => 'Welcome to\nComposite Hunter!';

  @override
  String get tutorialWelcomeContent =>
      'Learn prime factorization through exciting battles with composite numbers.';

  @override
  String get tutorialBasicTitle => 'Prime vs Composite';

  @override
  String get tutorialBasicContent =>
      'Prime numbers (2, 3, 5, 7...) can only be divided by 1 and themselves.\n\nComposite numbers (4, 6, 8, 9...) can be divided by other numbers.';

  @override
  String get tutorialBasicExample => '12 = 2 × 2 × 3';

  @override
  String get tutorialAttackTitle => 'Attack with Primes';

  @override
  String get tutorialAttackContent =>
      'Use your prime numbers to attack composite enemies.\n\nIf a prime divides the enemy, the enemy\'s value becomes smaller!';

  @override
  String get tutorialAttackExample => '12 ÷ 2 = 6\n6 ÷ 2 = 3\n3 is prime!';

  @override
  String get tutorialVictoryTitle => 'Claim Victory';

  @override
  String get tutorialVictoryContent =>
      'When you reduce an enemy to a prime number, press \"Claim Victory!\"\n\nBe careful - wrong claims cost you time!';

  @override
  String get tutorialVictoryExample => 'Enemy becomes prime?\nClaim Victory! ✓';

  @override
  String get tutorialTimerTitle => 'Time Pressure';

  @override
  String get tutorialTimerContent =>
      'Each battle has a time limit!\n\n• Escaping: -10 seconds next battle\n• Wrong claim: -10 seconds immediately\n• Timeout: -10 seconds next battle';

  @override
  String get tutorialTimerExample => 'Fight smart and fast!';

  @override
  String get tutorialReadyMessage => 'Ready to hunt some composite numbers?';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get startPlaying => 'Start Playing!';

  @override
  String selectItems(String stageNumber) {
    return 'Select Items - Stage $stageNumber';
  }

  @override
  String get selectedItems => 'Selected Items';

  @override
  String get remaining => 'remaining';

  @override
  String get noItemsAvailable => 'No items available for selection';

  @override
  String get startBattle => 'Start Battle';

  @override
  String itemRange(String min, String max) {
    return 'Range: $min-$max';
  }

  @override
  String timeLimit(String seconds) {
    return 'Time: ${seconds}s';
  }

  @override
  String haveCount(String count) {
    return 'Have: $count';
  }
}
