import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/battle_state.dart';
import '../../domain/entities/enemy.dart';
import '../../domain/entities/prime.dart';
import '../../domain/entities/timer_state.dart';
import '../../domain/entities/penalty_state.dart';
import '../../domain/entities/victory_claim.dart';
import '../../domain/services/battle_engine.dart';
import '../../domain/services/enemy_generator.dart';
import '../../domain/services/timer_manager.dart';
import 'inventory_provider.dart';
import 'game_provider.dart';
import '../../core/utils/logger.dart';

/// State notifier for battle management
class BattleNotifier extends StateNotifier<BattleState> {
  final EnemyGenerator _enemyGenerator;
  final TimerManager _timerManager;
  final Ref _ref;

  BattleNotifier(
    this._enemyGenerator,
    this._timerManager,
    this._ref,
  ) : super(const BattleState()) {
    // Listen to timer updates
    _timerManager.timerStream.listen(_handleTimerUpdate);
  }

  /// Start a new battle
  Future<void> startBattle() async {
    try {
      Logger.logBattle('Starting new battle');

      final inventory = _ref.read(inventoryProvider);
      final gameState = _ref.read(gameProvider);
      
      // Generate enemy based on current state
      final enemy = _enemyGenerator.generateEnemy(
        inventory,
        gameState.player.level,
      );

      // Calculate timer duration with penalties
      final baseDuration = TimerManager.getBaseTimeForEnemy(enemy);
      final adjustedDuration = TimerManager.getAdjustedTimeForEnemy(
        enemy,
        state.battlePenalties,
      );

      // Create timer state
      final timerState = TimerState(
        remainingSeconds: adjustedDuration,
        originalSeconds: baseDuration,
        isActive: false, // Will be activated when started
      );

      // Start the timer
      _timerManager.startTimer(adjustedDuration);

      // Update battle state
      state = state.startBattle(enemy, timerState);

      Logger.logBattle('Battle started', data: {
        'enemy': enemy.currentValue,
        'duration': adjustedDuration,
      });
    } catch (e, stackTrace) {
      Logger.error('Failed to start battle', e, stackTrace);
      state = state.copyWith(status: BattleStatus.defeat);
    }
  }

  /// Execute an attack with a prime
  Future<void> attack(Prime prime) async {
    if (state.currentEnemy == null || state.timerState?.isExpired == true) {
      return;
    }

    try {
      Logger.logBattle('Executing attack', data: {
        'prime': prime.value,
        'enemy': state.currentEnemy!.currentValue,
      });

      final result = BattleEngine.executeAttack(state.currentEnemy!, prime);

      await result.when(
        victory: (defeatedEnemy, rewardPrime, victoryClaim) async {
          // This shouldn't happen - attacks should await victory claim
          await _handleVictory(defeatedEnemy, rewardPrime, victoryClaim);
        },
        powerVictory: (defeatedEnemy, rewardPrime, rewardCount, victoryClaim) async {
          // This shouldn't happen - attacks should await victory claim
          await _handlePowerVictory(defeatedEnemy, rewardPrime, rewardCount, victoryClaim);
        },
        continue_: (newEnemy, usedPrime) async {
          await _handleContinue(newEnemy, usedPrime);
        },
        awaitingVictoryClaim: (newEnemy, usedPrime) async {
          await _handleAwaitingVictoryClaim(newEnemy, usedPrime);
        },
        wrongClaim: (penalty, currentEnemy, victoryClaim) async {
          // This shouldn't happen during attack
        },
        escape: (penalty) async {
          // This shouldn't happen during attack
        },
        timeOut: (penalty) async {
          // This shouldn't happen during attack
        },
        error: (message) {
          Logger.error('Attack failed: $message');
          _showError(message);
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to execute attack', e, stackTrace);
    }
  }

  /// Claim victory
  Future<void> claimVictory() async {
    if (state.currentEnemy == null || !state.canClaimVictory) {
      return;
    }

    try {
      Logger.logBattle('Claiming victory', data: {
        'enemyValue': state.currentEnemy!.currentValue,
      });

      final result = BattleEngine.processVictoryClaim(
        state.currentEnemy!,
        state.currentEnemy!.currentValue,
      );

      await result.when(
        victory: (defeatedEnemy, rewardPrime, victoryClaim) async {
          await _handleVictory(defeatedEnemy, rewardPrime, victoryClaim);
        },
        powerVictory: (defeatedEnemy, rewardPrime, rewardCount, victoryClaim) async {
          await _handlePowerVictory(defeatedEnemy, rewardPrime, rewardCount, victoryClaim);
        },
        continue_: (newEnemy, usedPrime) async {
          // This shouldn't happen during victory claim
        },
        awaitingVictoryClaim: (newEnemy, usedPrime) async {
          // This shouldn't happen during victory claim
        },
        wrongClaim: (penalty, currentEnemy, victoryClaim) async {
          await _handleWrongClaim(penalty, victoryClaim);
        },
        escape: (penalty) async {
          // This shouldn't happen during victory claim
        },
        timeOut: (penalty) async {
          // This shouldn't happen during victory claim
        },
        error: (message) {
          Logger.error('Victory claim failed: $message');
          _showError(message);
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to claim victory', e, stackTrace);
    }
  }

  /// Escape from battle
  void escape() {
    try {
      Logger.logBattle('Escaping from battle');

      final result = BattleEngine.processEscape();

      result.when(
        victory: (_, __, ___) {}, // Won't happen
        powerVictory: (_, __, ___, ____) {}, // Won't happen
        continue_: (_, __) {}, // Won't happen
        awaitingVictoryClaim: (_, __) {}, // Won't happen
        wrongClaim: (_, __, ___) {}, // Won't happen
        escape: (penalty) {
          _handleEscape(penalty);
        },
        timeOut: (_) {}, // Won't happen
        error: (message) {
          Logger.error('Escape failed: $message');
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to escape', e, stackTrace);
    }
  }

  /// Handle timer updates
  void _handleTimerUpdate(TimerState timerState) {
    state = state.copyWith(timerState: timerState);

    // Handle timeout
    if (timerState.isExpired && state.status == BattleStatus.fighting) {
      final result = BattleEngine.processTimeOut();
      
      result.when(
        victory: (_, __, ___) {}, // Won't happen
        powerVictory: (_, __, ___, ____) {}, // Won't happen
        continue_: (_, __) {}, // Won't happen
        awaitingVictoryClaim: (_, __) {}, // Won't happen
        wrongClaim: (_, __, ___) {}, // Won't happen
        escape: (_) {}, // Won't happen
        timeOut: (penalty) {
          _handleTimeOut(penalty);
        },
        error: (message) {
          Logger.error('Timeout handling failed: $message');
        },
      );
    }
  }

  /// Handle successful attack continuation
  Future<void> _handleContinue(Enemy newEnemy, Prime usedPrime) async {
    // Play attack animation
    await _playAttackAnimation(usedPrime.value);

    // Use the prime from inventory
    _ref.read(inventoryProvider.notifier).usePrime(usedPrime.value);

    // Update battle state
    state = state.nextTurn(usedPrime).copyWith(currentEnemy: newEnemy);
  }

  /// Handle awaiting victory claim state
  Future<void> _handleAwaitingVictoryClaim(Enemy newEnemy, Prime usedPrime) async {
    // Play attack animation
    await _playAttackAnimation(usedPrime.value);

    // Use the prime from inventory
    _ref.read(inventoryProvider.notifier).usePrime(usedPrime.value);

    // Update battle state - enemy is now prime, ready for victory claim
    state = state.nextTurn(usedPrime).copyWith(currentEnemy: newEnemy);
  }

  /// Handle successful victory
  Future<void> _handleVictory(Enemy defeatedEnemy, int rewardPrime, VictoryClaim victoryClaim) async {
    // Play victory animation
    await _playVictoryAnimation();

    // Add reward to inventory
    _ref.read(inventoryProvider.notifier).addPrime(rewardPrime);

    // Update battle state
    state = state.endBattle(BattleStatus.victory, claim: victoryClaim);

    // Stop timer
    _timerManager.stopTimer();

    // Update game statistics
    await _ref.read(gameProvider.notifier).recordVictory();

    // Clear penalties after successful battle
    state = state.copyWith(battlePenalties: []);

    Logger.logBattle('Victory completed');
  }

  /// Handle power enemy victory
  Future<void> _handlePowerVictory(
    Enemy defeatedEnemy,
    int rewardPrime,
    int rewardCount,
    VictoryClaim victoryClaim,
  ) async {
    // Play power victory animation
    await _playPowerVictoryAnimation();

    // Add multiple rewards to inventory
    for (int i = 0; i < rewardCount; i++) {
      _ref.read(inventoryProvider.notifier).addPrime(rewardPrime);
    }

    // Update battle state
    state = state.endBattle(BattleStatus.victory, claim: victoryClaim);

    // Stop timer
    _timerManager.stopTimer();

    // Update game statistics with power enemy bonus
    await _ref.read(gameProvider.notifier).recordPowerEnemyVictory();

    // Clear penalties after successful battle
    state = state.copyWith(battlePenalties: []);

    Logger.logBattle('Power victory completed');
  }

  /// Handle wrong victory claim
  Future<void> _handleWrongClaim(TimePenalty penalty, VictoryClaim victoryClaim) async {
    // Play penalty animation
    await _playPenaltyAnimation();

    // Apply penalty to timer
    _timerManager.applyPenalty(penalty);

    // Update battle state
    state = state.applyTimePenalty(penalty).copyWith(victoryClaim: victoryClaim);

    _showPenaltyMessage('The value ${victoryClaim.claimedValue} is still composite. Continue attacking!');
  }

  /// Handle escape
  void _handleEscape(TimePenalty penalty) {
    // Record penalty for next battle
    state = state.copyWith(
      status: BattleStatus.escape,
      battlePenalties: [...state.battlePenalties, penalty],
    );

    // Stop timer
    _timerManager.stopTimer();

    // Update game statistics
    _ref.read(gameProvider.notifier).recordEscape();

    Logger.logBattle('Escape completed');

    // Start new battle after delay
    Future.delayed(const Duration(milliseconds: 500), () {
      startBattle();
    });
  }

  /// Handle timeout
  void _handleTimeOut(TimePenalty penalty) {
    // Record penalty for next battle
    state = state.copyWith(
      status: BattleStatus.timeOut,
      battlePenalties: [...state.battlePenalties, penalty],
    );

    // Update game statistics
    _ref.read(gameProvider.notifier).recordTimeOut();

    Logger.logBattle('Timeout completed');

    // Start new battle after delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      startBattle();
    });
  }

  /// Animation methods
  Future<void> _playAttackAnimation(int primeValue) async {
    // TODO: Implement attack animation
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _playVictoryAnimation() async {
    // TODO: Implement victory animation
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  Future<void> _playPowerVictoryAnimation() async {
    // TODO: Implement power victory animation
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  Future<void> _playPenaltyAnimation() async {
    // TODO: Implement penalty animation
    await Future.delayed(const Duration(milliseconds: 800));
  }

  /// UI feedback methods
  void _showError(String message) {
    // TODO: Show error dialog/snackbar
    Logger.error('Battle error: $message');
  }

  void _showPenaltyMessage(String message) {
    // TODO: Show penalty message
    Logger.info('Penalty message: $message');
  }

  @override
  void dispose() {
    _timerManager.dispose();
    super.dispose();
  }
}

/// Battle provider
final battleProvider = StateNotifierProvider<BattleNotifier, BattleState>((ref) {
  return BattleNotifier(
    EnemyGenerator(),
    TimerManager(),
    ref,
  );
});

/// Computed providers for battle state
final canClaimVictoryProvider = Provider<bool>((ref) {
  final battleState = ref.watch(battleProvider);
  return battleState.canClaimVictory;
});

final isPowerEnemyProvider = Provider<bool>((ref) {
  final enemy = ref.watch(battleProvider).currentEnemy;
  return enemy?.isPowerEnemy ?? false;
});

final currentEnemyProvider = Provider<Enemy?>((ref) {
  return ref.watch(battleProvider).currentEnemy;
});

final battleStatusProvider = Provider<BattleStatus>((ref) {
  return ref.watch(battleProvider).status;
});

final battleProgressProvider = Provider<double>((ref) {
  return ref.watch(battleProvider).battleProgress;
});

final usedPrimesProvider = Provider<List<Prime>>((ref) {
  return ref.watch(battleProvider).usedPrimes;
});

final turnCountProvider = Provider<int>((ref) {
  return ref.watch(battleProvider).turnCount;
});

final battleDurationProvider = Provider<Duration?>((ref) {
  return ref.watch(battleProvider).battleDuration;
});

final battleSummaryProvider = Provider<BattleSummary>((ref) {
  return ref.watch(battleProvider).summary;
});

/// Timer-specific providers
final timerProvider = Provider<TimerState?>((ref) {
  return ref.watch(battleProvider).timerState;
});

final timeRemainingProvider = Provider<int>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.remainingSeconds ?? 0;
});

final timerProgressProvider = Provider<double>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.progress ?? 0.0;
});

final timeWarningProvider = Provider<bool>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.shouldShowWarning ?? false;
});

final timeCriticalProvider = Provider<bool>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.isCritical ?? false;
});

final timerExpiredProvider = Provider<bool>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.isExpired ?? false;
});

final timerDisplayStateProvider = Provider<TimerDisplayState>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.displayState ?? TimerDisplayState.expired;
});

final formattedTimeProvider = Provider<String>((ref) {
  final timerState = ref.watch(timerProvider);
  return timerState?.formattedTime ?? '00:00';
});

/// Battle actions providers (for UI buttons state)
final canAttackProvider = Provider.family<bool, Prime>((ref, prime) {
  final battleState = ref.watch(battleProvider);
  final inventory = ref.watch(inventoryProvider);
  
  if (battleState.currentEnemy == null) return false;
  if (!battleState.isInProgress) return false;
  if (battleState.timerState?.isExpired == true) return false;
  
  return BattleEngine.canAttack(battleState.currentEnemy!, prime, inventory);
});

final availableAttacksProvider = Provider<List<Prime>>((ref) {
  final battleState = ref.watch(battleProvider);
  final inventory = ref.watch(inventoryProvider);
  
  return battleState.getAvailableAttacks(inventory);
});

final battleDifficultyProvider = Provider<int>((ref) {
  final battleState = ref.watch(battleProvider);
  final inventory = ref.watch(inventoryProvider);
  
  if (battleState.currentEnemy == null) return 0;
  
  return BattleEngine.calculateBattleDifficulty(
    battleState.currentEnemy!,
    inventory,
  );
});

final optimalAttacksProvider = Provider<List<Prime>>((ref) {
  final battleState = ref.watch(battleProvider);
  final inventory = ref.watch(inventoryProvider);
  
  if (battleState.currentEnemy == null) return [];
  
  return BattleEngine.suggestOptimalAttacks(
    battleState.currentEnemy!,
    inventory,
  );
});