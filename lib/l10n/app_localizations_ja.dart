// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '合成数ハンター';

  @override
  String get practiceMode => '練習モード';

  @override
  String stage(String number) {
    return 'ステージ $number';
  }

  @override
  String get inventory => 'インベントリ';

  @override
  String get collection => 'コレクション';

  @override
  String get statistics => '統計';

  @override
  String get primeInventory => '素数インベントリ';

  @override
  String get timeRemaining => '残り時間';

  @override
  String get primeNumber => '素数';

  @override
  String get compositeNumber => '合成数';

  @override
  String get enemyDefeated => '敵を倒しました！勝利を宣言してください！';

  @override
  String get attackWithPrimeFactors => '素因数で攻撃して倒してください！';

  @override
  String get yourPrimeNumbers => 'あなたの素数';

  @override
  String get noPrimesAvailable => '攻撃可能な素数がありません';

  @override
  String get escape => '逃げる';

  @override
  String get claimVictory => '勝利宣言！';

  @override
  String get victory => '勝利！';

  @override
  String youDefeatedEnemy(String enemy) {
    return '敵 $enemy を倒しました！';
  }

  @override
  String get practiceModeNoItems => '練習モード - アイテムの消費・獲得はありません';

  @override
  String get keepPracticing => '練習を続けてください！';

  @override
  String get rewardsObtained => '獲得報酬：';

  @override
  String finalPrime(String prime) {
    return '素数 $prime （最終結果）';
  }

  @override
  String get usedPrimesReturned => '使用した素数が返却されました：';

  @override
  String get continueFighting => '戦闘を続けてください！';

  @override
  String get continueAction => '続ける';

  @override
  String get wrongClaim => '誤った宣言！';

  @override
  String stillComposite(String number) {
    return '$number はまだ合成数です。攻撃を続けてください！';
  }

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get timeRanOut => '時間切れです！';

  @override
  String get noAvailableItems => '攻撃可能なアイテムがありません！';

  @override
  String get victories => '勝利数';

  @override
  String get timePlayed => 'プレイ時間';

  @override
  String get escapes => '逃走数';

  @override
  String get wrongClaims => '誤った宣言数';

  @override
  String get tip => 'ヒント';

  @override
  String get attackFasterTip => '次回はもっと速く攻撃してみてください！\n素因数を素早く見つけることに集中しましょう。';

  @override
  String get collectMorePrimesTip => 'より多くの素数を集めてください！\n敵を倒して新しい素数を獲得しましょう。';

  @override
  String stageClear(String number) {
    return 'ステージ $number クリア！';
  }

  @override
  String get totalTime => '合計時間';

  @override
  String get score => 'スコア';

  @override
  String get perfectClear => 'パーフェクトクリア！';

  @override
  String get noEscapesOrWrongClaims => '逃走や誤った宣言がありませんでした！';

  @override
  String get newRecord => '新記録！';

  @override
  String get bestPerformance => 'あなたの最高記録です！';

  @override
  String get escapedItemsRestored => '逃走しました - アイテムと時間が復元されました';

  @override
  String get battleRestarted => 'バトルが再開されました - アイテムが復元されました';

  @override
  String get practiceResults => '練習結果';

  @override
  String stageResults(String number) {
    return 'ステージ $number 結果';
  }

  @override
  String get nextStage => '次のステージ';

  @override
  String get stageSelect => 'ステージ選択';

  @override
  String get playAgain => 'もう一度プレイ';

  @override
  String get tryAgain => '再挑戦';

  @override
  String get totalPrimes => '合計素数';

  @override
  String get unique => 'ユニーク';

  @override
  String get available => '利用可能';

  @override
  String primeWithValue(String number) {
    return '素数 $number';
  }

  @override
  String firstObtained(String time) {
    return '初回取得: $time';
  }

  @override
  String get notYetDiscovered => 'まだ発見されていません';

  @override
  String get usageStatistics => '使用統計';

  @override
  String get totalUsage => '合計使用回数';

  @override
  String get attacksMade => '攻撃実行';

  @override
  String get mostUsedPrime => '最も使用された素数';

  @override
  String timesUsed(String count) {
    return '$count 回';
  }

  @override
  String get primeUsageChart => '素数使用グラフ';

  @override
  String usedTimes(String count) {
    return '$count 回使用';
  }

  @override
  String daysAgo(String count) {
    return '$count 日前';
  }

  @override
  String get chooseChallenge => 'チャレンジステージを選択';

  @override
  String get resetGameData => 'ゲームデータをリセット';

  @override
  String get resetConfirmation => 'インベントリとステージ進行状況を初期値にリセットします。継続しますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get reset => 'リセット';

  @override
  String get gameDataResetSuccess => 'ゲームデータのリセットが完了しました';

  @override
  String errorDuringReset(String error) {
    return 'リセット中にエラーが発生しました: $error';
  }

  @override
  String get resetInventory => 'インベントリリセット';

  @override
  String get achievements => '実績';

  @override
  String get stage1Title => '基本バトル';

  @override
  String get stage1Description => '小さな合成数と戦い、素因数分解を学ぼう';

  @override
  String get stage2Title => '中級チャレンジ';

  @override
  String get stage2Description => '中程度の合成数と戦略的な攻撃で対戦';

  @override
  String get stage3Title => '上級コース';

  @override
  String get stage3Description => '大きな合成数との本格的なバトルに挑戦';

  @override
  String get stage4Title => 'エキスパートモード';

  @override
  String get stage4Description => '上級プレイヤーのための究極の挑戦';

  @override
  String get achievementProgress => '実績進捗';

  @override
  String achievementsUnlocked(String unlocked, String total) {
    return '$unlocked / $total 解除済み';
  }

  @override
  String get battleAchievements => 'バトル実績';

  @override
  String get speedAchievements => 'スピード実績';

  @override
  String get specialAchievements => '特別実績';

  @override
  String get firstVictory => '初勝利';

  @override
  String get firstVictoryDesc => '初めてのバトルに勝利する';

  @override
  String get primeHunter => '素数ハンター';

  @override
  String get primeHunterDesc => '10回バトルに勝利する';

  @override
  String get compositeCrusher => '合成数クラッシャー';

  @override
  String get compositeCrusherDesc => '50回バトルに勝利する';

  @override
  String get lightningFast => '電光石火';

  @override
  String get lightningFastDesc => '10秒以内でバトルに勝利する';

  @override
  String get speedDemon => 'スピードデーモン';

  @override
  String get speedDemonDesc => '15秒以内でのバトル勝利を5回達成する';

  @override
  String get powerHunter => '冪乗ハンター';

  @override
  String get powerHunterDesc => '冪乗敵を10体倒す';

  @override
  String get perfectVictory => '完全勝利';

  @override
  String get perfectVictoryDesc => '誤った宣言や逃走なしで勝利する';

  @override
  String get primeCollector => '素数コレクター';

  @override
  String get primeCollectorDesc => '25種類の異なる素数を収集する';

  @override
  String get tutorialWelcomeTitle => '合成数ハンターへ\nようこそ！';

  @override
  String get tutorialWelcomeContent => '合成数との戦いを通じて素因数分解を学びましょう。';

  @override
  String get tutorialBasicTitle => '素数 vs 合成数';

  @override
  String get tutorialBasicContent =>
      '素数（2, 3, 5, 7...）は1と自分自身でしか割り切れません。\n\n合成数（4, 6, 8, 9...）は他の数でも割り切れます。';

  @override
  String get tutorialBasicExample => '12 = 2 × 2 × 3';

  @override
  String get tutorialAttackTitle => '素数で攻撃';

  @override
  String get tutorialAttackContent =>
      '素数を使って合成数の敵を攻撃しましょう。\n\n素数で割り切れると、敵の値が小さくなります！';

  @override
  String get tutorialAttackExample => '12 ÷ 2 = 6\n6 ÷ 2 = 3\n3は素数！';

  @override
  String get tutorialVictoryTitle => '勝利宣言';

  @override
  String get tutorialVictoryContent =>
      '敵を素数まで減らしたら「勝利宣言！」を押してください。\n\n注意 - 間違った宣言は時間を失います！';

  @override
  String get tutorialVictoryExample => '敵が素数になった？\n勝利宣言！ ✓';

  @override
  String get tutorialTimerTitle => '時間制限';

  @override
  String get tutorialTimerContent =>
      '各バトルには制限時間があります！\n\n• 逃走: 次のバトルで-10秒\n• 誤った宣言: 即座に-10秒\n• タイムアップ: 次のバトルで-10秒';

  @override
  String get tutorialTimerExample => '賢く、素早く戦いましょう！';

  @override
  String get tutorialReadyMessage => '合成数狩りの準備はできましたか？';

  @override
  String get previous => '前へ';

  @override
  String get next => '次へ';

  @override
  String get startPlaying => 'ゲーム開始！';

  @override
  String selectItems(String stageNumber) {
    return 'アイテム選択 - ステージ$stageNumber';
  }

  @override
  String get selectedItems => '選択中のアイテム';

  @override
  String get remaining => '残り';

  @override
  String get noItemsAvailable => '選択可能なアイテムがありません';

  @override
  String get startBattle => 'バトル開始';

  @override
  String itemRange(String min, String max) {
    return '範囲: $min-$max';
  }

  @override
  String timeLimit(String seconds) {
    return '制限時間: $seconds秒';
  }

  @override
  String haveCount(String count) {
    return '所持: $count個';
  }

  @override
  String get menu => 'メニュー';

  @override
  String get restart => 'リスタート';

  @override
  String get restartDescription => '現在のバトルをリセットして最初からやり直します';

  @override
  String get exit => '終了';

  @override
  String get exitDescription => 'ステージ選択画面に戻ります';

  @override
  String get back => '戻る';

  @override
  String get exitBattleTitle => 'バトルを終了しますか？';

  @override
  String get exitBattleConfirmation => '現在の進行状況は保存されません。本当に終了しますか？';

  @override
  String get basicBattle => '基本バトル';

  @override
  String get basicBattleDescription => '小さな合成数と戦い、素因数分解を学ぼう';

  @override
  String get intermediateChallenge => '中級チャレンジ';

  @override
  String get intermediateChallengeDescription => '中型の合成数に戦略的な攻撃で挑もう';

  @override
  String get advancedPath => '上級への道';

  @override
  String get advancedPathDescription => '大きな合成数と本格的なバトルを繰り広げよう';

  @override
  String get expertMode => 'エキスパートモード';

  @override
  String get expertModeDescription => '上級者向けの究極のチャレンジ';
}
