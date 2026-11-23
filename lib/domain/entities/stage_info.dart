/// ステージ選択に使うステージ情報
class StageInfo {
  final int stageNumber;
  final String title;
  final String description;
  final int enemyRangeMin;
  final int enemyRangeMax;
  final int timeLimit;
  final bool isUnlocked;
  final bool isCompleted;
  final int stars;

  const StageInfo({
    required this.stageNumber,
    required this.title,
    required this.description,
    required this.enemyRangeMin,
    required this.enemyRangeMax,
    required this.timeLimit,
    required this.isUnlocked,
    required this.isCompleted,
    required this.stars,
  });
}
