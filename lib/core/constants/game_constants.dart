class GameConstants {
  // Initial inventory
  static const int initialPrimeValue = 2;
  static const int initialPrimeCount = 3;

  // Enemy value ranges
  static const int smallEnemyMin = 6;
  static const int smallEnemyMax = 20;
  static const int mediumEnemyMin = 21;
  static const int mediumEnemyMax = 100;
  static const int largeEnemyMin = 101;
  static const int largeEnemyMax = 1000;
  static const int maxEnemyValue = 10000;

  // Prime limits
  static const int maxSmallPrimeCount = 5;
  static const int maxLargePrimeCount = 1;
  static const int smallPrimeThreshold = 10;

  // Power enemy
  static const double powerEnemySpawnRate = 0.1; // 10%
  static const int minPowerExponent = 2;
  static const int maxPowerExponent = 4;

  // Experience and levels
  static const int baseExperiencePerLevel = 100;
  static const double experienceMultiplier = 1.2;
  static const int baseVictoryExperience = 10;
  static const int powerEnemyBonusExperience = 20;
  static const int tutorialCompletionExperience = 50;
}
