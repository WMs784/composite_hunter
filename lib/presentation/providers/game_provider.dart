import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/achievement.dart';
import '../../data/repositories/game_repository.dart';
import '../../data/mappers/game_mapper.dart';
import '../../core/constants/game_constants.dart';
import '../../core/utils/logger.dart';

/// State notifier for overall game state management
class GameNotifier extends StateNotifier<GameState> {
  final GameRepository _repository;
  final GameMapper _mapper;

  GameNotifier(this._repository, this._mapper) : super(const GameState()) {
    _loadGameState();
  }

  /// Load game state from repository
  Future<void> _loadGameState() async {
    try {
      Logger.info('Loading game state');
      
      final gameData = await _repository.loadGameData();
      final player = Player(
        level: gameData.playerLevel,
        experience: gameData.experience,
        totalBattles: gameData.totalBattles,
        totalVictories: gameData.totalVictories,
        totalEscapes: gameData.totalEscapes,
        totalTimeOuts: gameData.totalTimeOuts,
        totalPowerEnemiesDefeated: gameData.totalPowerEnemiesDefeated,
        createdAt: gameData.createdAt,
        lastPlayedAt: gameData.lastPlayedAt,
      );

      state = state.copyWith(
        player: player,
        isInitialized: true,
        tutorialCompleted: gameData.tutorialCompleted,
      );

      Logger.info('Game state loaded successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to load game state', e, stackTrace);
      await _initializeNewGame();
    }
  }

  /// Initialize new game for first-time players
  Future<void> _initializeNewGame() async {
    try {
      Logger.info('Initializing new game');
      
      final now = DateTime.now();
      final newPlayer = Player(
        level: 1,
        experience: 0,
        totalBattles: 0,
        totalVictories: 0,
        totalEscapes: 0,
        totalTimeOuts: 0,
        totalPowerEnemiesDefeated: 0,
        createdAt: now,
        lastPlayedAt: now,
      );

      state = state.copyWith(
        player: newPlayer,
        isInitialized: true,
        tutorialCompleted: false,
      );

      await _saveGameState();
      Logger.info('New game initialized');
    } catch (e, stackTrace) {
      Logger.error('Failed to initialize new game', e, stackTrace);
    }
  }

  /// Record a victory and update player stats
  Future<void> recordVictory() async {
    try {
      Logger.logGame('Recording victory');
      
      final updatedPlayer = state.player.copyWith(
        totalBattles: state.player.totalBattles + 1,
        totalVictories: state.player.totalVictories + 1,
        experience: state.player.experience + GameConstants.baseVictoryExperience,
        lastPlayedAt: DateTime.now(),
      );

      // Check for level up
      final newLevel = _calculateLevel(updatedPlayer.experience);
      final finalPlayer = updatedPlayer.copyWith(level: newLevel);
      
      state = state.copyWith(player: finalPlayer);
      await _saveGameState();

      // Check for level up notification
      if (newLevel > state.player.level) {
        _triggerLevelUpEvent(newLevel);
      }

      Logger.logGame('Victory recorded', data: {
        'newLevel': newLevel,
        'experience': finalPlayer.experience,
      });
    } catch (e, stackTrace) {
      Logger.error('Failed to record victory', e, stackTrace);
    }
  }

  /// Record power enemy victory with bonus rewards
  Future<void> recordPowerEnemyVictory() async {
    try {
      Logger.logGame('Recording power enemy victory');
      
      final bonusExperience = GameConstants.powerEnemyBonusExperience;
      final updatedPlayer = state.player.copyWith(
        totalBattles: state.player.totalBattles + 1,
        totalVictories: state.player.totalVictories + 1,
        totalPowerEnemiesDefeated: state.player.totalPowerEnemiesDefeated + 1,
        experience: state.player.experience + GameConstants.baseVictoryExperience + bonusExperience,
        lastPlayedAt: DateTime.now(),
      );

      // Check for level up
      final newLevel = _calculateLevel(updatedPlayer.experience);
      final finalPlayer = updatedPlayer.copyWith(level: newLevel);
      
      state = state.copyWith(player: finalPlayer);
      await _saveGameState();

      // Check for level up notification
      if (newLevel > state.player.level) {
        _triggerLevelUpEvent(newLevel);
      }

      Logger.logGame('Power enemy victory recorded');
    } catch (e, stackTrace) {
      Logger.error('Failed to record power enemy victory', e, stackTrace);
    }
  }

  /// Record an escape
  Future<void> recordEscape() async {
    try {
      Logger.logGame('Recording escape');
      
      final updatedPlayer = state.player.copyWith(
        totalBattles: state.player.totalBattles + 1,
        totalEscapes: state.player.totalEscapes + 1,
        lastPlayedAt: DateTime.now(),
      );

      state = state.copyWith(player: updatedPlayer);
      await _saveGameState();

      Logger.logGame('Escape recorded');
    } catch (e, stackTrace) {
      Logger.error('Failed to record escape', e, stackTrace);
    }
  }

  /// Record a timeout
  Future<void> recordTimeOut() async {
    try {
      Logger.logGame('Recording timeout');
      
      final updatedPlayer = state.player.copyWith(
        totalBattles: state.player.totalBattles + 1,
        totalTimeOuts: state.player.totalTimeOuts + 1,
        lastPlayedAt: DateTime.now(),
      );

      state = state.copyWith(player: updatedPlayer);
      await _saveGameState();

      Logger.logGame('Timeout recorded');
    } catch (e, stackTrace) {
      Logger.error('Failed to record timeout', e, stackTrace);
    }
  }

  /// Complete tutorial
  Future<void> completeTutorial() async {
    try {
      Logger.logGame('Completing tutorial');
      
      state = state.copyWith(tutorialCompleted: true);
      await _repository.completeTutorial();
      
      // Award tutorial completion experience
      final updatedPlayer = state.player.copyWith(
        experience: state.player.experience + GameConstants.tutorialCompletionExperience,
      );
      
      final newLevel = _calculateLevel(updatedPlayer.experience);
      final finalPlayer = updatedPlayer.copyWith(level: newLevel);
      
      state = state.copyWith(player: finalPlayer);
      await _saveGameState();

      Logger.logGame('Tutorial completed');
    } catch (e, stackTrace) {
      Logger.error('Failed to complete tutorial', e, stackTrace);
    }
  }

  /// Add experience points
  Future<void> addExperience(int experience) async {
    try {
      Logger.logGame('Adding experience', data: {'experience': experience});
      
      final updatedPlayer = state.player.copyWith(
        experience: state.player.experience + experience,
        lastPlayedAt: DateTime.now(),
      );

      // Check for level up
      final newLevel = _calculateLevel(updatedPlayer.experience);
      final finalPlayer = updatedPlayer.copyWith(level: newLevel);
      
      state = state.copyWith(player: finalPlayer);
      await _saveGameState();

      // Check for level up notification
      if (newLevel > state.player.level) {
        _triggerLevelUpEvent(newLevel);
      }

      Logger.logGame('Experience added');
    } catch (e, stackTrace) {
      Logger.error('Failed to add experience', e, stackTrace);
    }
  }

  /// Calculate level from experience
  int _calculateLevel(int experience) {
    // Level formula: level = floor(sqrt(experience / 100)) + 1
    // This creates a progressively slower leveling curve
    return (experience / GameConstants.experiencePerLevel).floor() + 1;
  }

  /// Calculate experience needed for next level
  int getExperienceForNextLevel() {
    final currentLevel = state.player.level;
    final nextLevelExperience = (currentLevel) * GameConstants.experiencePerLevel;
    return nextLevelExperience - state.player.experience;
  }

  /// Get experience progress as percentage for current level
  double getLevelProgress() {
    final currentLevelExp = (state.player.level - 1) * GameConstants.experiencePerLevel;
    final nextLevelExp = state.player.level * GameConstants.experiencePerLevel;
    final currentExp = state.player.experience;
    
    if (currentExp >= nextLevelExp) return 1.0;
    
    final levelExp = currentExp - currentLevelExp;
    final levelRange = nextLevelExp - currentLevelExp;
    
    return (levelExp / levelRange).clamp(0.0, 1.0);
  }

  /// Calculate win rate
  double getWinRate() {
    if (state.player.totalBattles == 0) return 0.0;
    return state.player.totalVictories / state.player.totalBattles;
  }

  /// Get power enemy defeat rate
  double getPowerEnemyRate() {
    if (state.player.totalVictories == 0) return 0.0;
    return state.player.totalPowerEnemiesDefeated / state.player.totalVictories;
  }

  /// Trigger level up event
  void _triggerLevelUpEvent(int newLevel) {
    // TODO: Show level up animation/dialog
    Logger.logGame('Level up!', data: {'newLevel': newLevel});
  }

  /// Save current game state
  Future<void> _saveGameState() async {
    try {
      final gameData = _mapper.gameDataToModel(
        playerLevel: state.player.level,
        experience: state.player.experience,
        totalBattles: state.player.totalBattles,
        totalVictories: state.player.totalVictories,
        totalEscapes: state.player.totalEscapes,
        totalTimeOuts: state.player.totalTimeOuts,
        totalPowerEnemiesDefeated: state.player.totalPowerEnemiesDefeated,
        inventory: [], // Inventory is managed separately
        battleHistory: [], // Battle history is managed separately
        tutorialCompleted: state.tutorialCompleted,
        createdAt: state.player.createdAt,
        lastPlayedAt: state.player.lastPlayedAt,
      );

      await _repository.saveGameData(gameData);
    } catch (e, stackTrace) {
      Logger.error('Failed to save game state', e, stackTrace);
    }
  }

  /// Reset game progress (for testing or new game)
  Future<void> resetGame() async {
    try {
      Logger.logGame('Resetting game');
      
      await _repository.clearAllData();
      await _initializeNewGame();
      
      Logger.logGame('Game reset completed');
    } catch (e, stackTrace) {
      Logger.error('Failed to reset game', e, stackTrace);
    }
  }

  /// Check if player is new (less than 5 battles)
  bool isNewPlayer() {
    return state.player.totalBattles < 5;
  }

  /// Check if tutorial should be shown
  bool shouldShowTutorial() {
    return !state.tutorialCompleted && isNewPlayer();
  }

  /// Get player rank based on level
  PlayerRank getPlayerRank() {
    final level = state.player.level;
    if (level >= 50) return PlayerRank.master;
    if (level >= 30) return PlayerRank.expert;
    if (level >= 20) return PlayerRank.advanced;
    if (level >= 10) return PlayerRank.intermediate;
    return PlayerRank.beginner;
  }

  /// Update last played time
  Future<void> updateLastPlayed() async {
    final updatedPlayer = state.player.copyWith(
      lastPlayedAt: DateTime.now(),
    );
    
    state = state.copyWith(player: updatedPlayer);
    await _saveGameState();
  }
}

/// Game provider
final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final repository = GameRepository();
  final mapper = GameMapper();
  return GameNotifier(repository, mapper);
});

/// Computed providers for game state
final playerProvider = Provider<Player>((ref) {
  return ref.watch(gameProvider).player;
});

final playerLevelProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).level;
});

final playerExperienceProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).experience;
});

final experienceForNextLevelProvider = Provider<int>((ref) {
  return ref.read(gameProvider.notifier).getExperienceForNextLevel();
});

final levelProgressProvider = Provider<double>((ref) {
  return ref.read(gameProvider.notifier).getLevelProgress();
});

final winRateProvider = Provider<double>((ref) {
  return ref.read(gameProvider.notifier).getWinRate();
});

final powerEnemyRateProvider = Provider<double>((ref) {
  return ref.read(gameProvider.notifier).getPowerEnemyRate();
});

final playerRankProvider = Provider<PlayerRank>((ref) {
  return ref.read(gameProvider.notifier).getPlayerRank();
});

final isNewPlayerProvider = Provider<bool>((ref) {
  return ref.read(gameProvider.notifier).isNewPlayer();
});

final shouldShowTutorialProvider = Provider<bool>((ref) {
  return ref.read(gameProvider.notifier).shouldShowTutorial();
});

final gameInitializedProvider = Provider<bool>((ref) {
  return ref.watch(gameProvider).isInitialized;
});

final tutorialCompletedProvider = Provider<bool>((ref) {
  return ref.watch(gameProvider).tutorialCompleted;
});

/// Player statistics providers
final totalBattlesProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).totalBattles;
});

final totalVictoriesProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).totalVictories;
});

final totalEscapesProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).totalEscapes;
});

final totalTimeOutsProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).totalTimeOuts;
});

final totalPowerEnemiesDefeatedProvider = Provider<int>((ref) {
  return ref.watch(playerProvider).totalPowerEnemiesDefeated;
});

final playerCreatedAtProvider = Provider<DateTime>((ref) {
  return ref.watch(playerProvider).createdAt;
});

final playerLastPlayedAtProvider = Provider<DateTime>((ref) {
  return ref.watch(playerProvider).lastPlayedAt;
});

/// Player performance providers
final defeatRateProvider = Provider<double>((ref) {
  final player = ref.watch(playerProvider);
  if (player.totalBattles == 0) return 0.0;
  final defeats = player.totalBattles - player.totalVictories;
  return defeats / player.totalBattles;
});

final escapeRateProvider = Provider<double>((ref) {
  final player = ref.watch(playerProvider);
  if (player.totalBattles == 0) return 0.0;
  return player.totalEscapes / player.totalBattles;
});

final timeOutRateProvider = Provider<double>((ref) {
  final player = ref.watch(playerProvider);
  if (player.totalBattles == 0) return 0.0;
  return player.totalTimeOuts / player.totalBattles;
});

/// Player rank enumeration
enum PlayerRank {
  beginner,
  intermediate,
  advanced,
  expert,
  master,
}

extension PlayerRankExtension on PlayerRank {
  String get displayName {
    switch (this) {
      case PlayerRank.beginner:
        return 'Beginner';
      case PlayerRank.intermediate:
        return 'Intermediate';
      case PlayerRank.advanced:
        return 'Advanced';
      case PlayerRank.expert:
        return 'Expert';
      case PlayerRank.master:
        return 'Master';
    }
  }

  String get description {
    switch (this) {
      case PlayerRank.beginner:
        return 'New to the world of prime hunting';
      case PlayerRank.intermediate:
        return 'Getting the hang of factorization';
      case PlayerRank.advanced:
        return 'Skilled at breaking down composites';
      case PlayerRank.expert:
        return 'Master of mathematical strategy';
      case PlayerRank.master:
        return 'Legendary prime hunter';
    }
  }
}