import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/entities/prime.dart';
import '../../data/repositories/game_repository.dart';
import '../../core/constants/game_constants.dart';
import '../../core/utils/logger.dart';

/// State notifier for inventory management
class InventoryNotifier extends StateNotifier<Inventory> {
  final GameRepository _repository;

  InventoryNotifier(this._repository) : super(const Inventory()) {
    _loadInventory();
  }

  /// Load inventory from repository
  Future<void> _loadInventory() async {
    try {
      Logger.logInventory('Loading inventory');
      final inventory = await _repository.loadInventory();
      state = inventory;
      Logger.logInventory('Inventory loaded', data: {
        'totalPrimes': inventory.totalCount,
        'uniquePrimes': inventory.uniqueCount,
      });
    } catch (e, stackTrace) {
      Logger.error('Failed to load inventory', e, stackTrace);
      // Initialize with default starter prime if loading fails
      await _initializeStarterInventory();
    }
  }

  /// Initialize inventory with starter prime
  Future<void> _initializeStarterInventory() async {
    try {
      Logger.logInventory('Initializing starter inventory');
      
      final starterPrime = Prime(
        value: GameConstants.initialPrimeValue,
        count: GameConstants.initialPrimeCount,
        firstObtained: DateTime.now(),
      );

      state = state.addPrime(starterPrime);
      await _saveInventory();
      
      Logger.logInventory('Starter inventory initialized');
    } catch (e, stackTrace) {
      Logger.error('Failed to initialize starter inventory', e, stackTrace);
    }
  }

  /// Add a prime to the inventory
  Future<void> addPrime(Prime prime) async {
    try {
      Logger.logInventory('Adding prime', prime: prime.value, count: prime.count);
      
      state = state.addPrime(prime);
      await _repository.updatePrime(prime);
      
      Logger.logInventory('Prime added successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to add prime', e, stackTrace);
    }
  }

  /// Use a prime (decrease count by 1)
  Future<void> usePrime(Prime prime) async {
    try {
      Logger.logInventory('Using prime', prime: prime.value);
      
      if (!state.isPrimeAvailable(prime.value)) {
        throw StateError('Prime ${prime.value} is not available');
      }

      state = state.usePrime(prime);
      
      // Update in repository - either update with new count or remove if count is 0
      final updatedPrime = state.getPrime(prime.value);
      if (updatedPrime != null) {
        await _repository.updatePrime(updatedPrime);
      } else {
        await _repository.removePrime(prime.value);
      }
      
      Logger.logInventory('Prime used successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to use prime', e, stackTrace);
      // Revert state on error
      await _loadInventory();
    }
  }

  /// Remove a prime completely from inventory
  Future<void> removePrime(int primeValue) async {
    try {
      Logger.logInventory('Removing prime', prime: primeValue);
      
      state = state.removePrime(primeValue);
      await _repository.removePrime(primeValue);
      
      Logger.logInventory('Prime removed successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to remove prime', e, stackTrace);
      // Revert state on error
      await _loadInventory();
    }
  }

  /// Add multiple primes at once (for rewards)
  Future<void> addMultiplePrimes(List<Prime> primes) async {
    try {
      Logger.logInventory('Adding multiple primes', data: {
        'count': primes.length,
        'primes': primes.map((p) => '${p.value}x${p.count}').toList(),
      });

      for (final prime in primes) {
        state = state.addPrime(prime);
        await _repository.updatePrime(prime);
      }
      
      Logger.logInventory('Multiple primes added successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to add multiple primes', e, stackTrace);
      // Revert state on error
      await _loadInventory();
    }
  }

  /// Grant a specific prime as reward
  Future<void> grantPrimeReward(int primeValue, {int count = 1}) async {
    try {
      Logger.logInventory('Granting prime reward', prime: primeValue, count: count);
      
      final reward = Prime(
        value: primeValue,
        count: count,
        firstObtained: DateTime.now(),
      );

      await addPrime(reward);
      
      Logger.logInventory('Prime reward granted successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to grant prime reward', e, stackTrace);
    }
  }

  /// Check if inventory can accommodate new prime
  bool canAddPrime(int primeValue, int count) {
    final existingPrime = state.getPrime(primeValue);
    final isSmallPrime = primeValue <= GameConstants.smallPrimeThreshold;
    
    final maxCount = isSmallPrime 
        ? GameConstants.maxSmallPrimeCount 
        : GameConstants.maxLargePrimeCount;
    
    final currentCount = existingPrime?.count ?? 0;
    return currentCount + count <= maxCount;
  }

  /// Get primes that can attack a specific enemy value
  List<Prime> getPrimesForEnemy(int enemyValue) {
    return state.getPrimesForAttack(enemyValue);
  }

  /// Sort inventory by different criteria
  void sortByValue() {
    state = Inventory(primes: state.sortedByValue);
  }

  void sortByCount() {
    state = Inventory(primes: state.sortedByCount);
  }

  void sortByUsage() {
    state = Inventory(primes: state.sortedByUsage);
  }

  /// Save inventory to repository
  Future<void> _saveInventory() async {
    try {
      await _repository.saveInventory(state);
    } catch (e, stackTrace) {
      Logger.error('Failed to save inventory', e, stackTrace);
    }
  }

  /// Refresh inventory from repository
  Future<void> refresh() async {
    await _loadInventory();
  }

  /// Get inventory statistics
  InventoryStats getStats() {
    return state.stats;
  }

  /// Clear all primes (for testing or reset)
  Future<void> clearInventory() async {
    try {
      Logger.logInventory('Clearing inventory');
      
      for (final prime in state.primes) {
        await _repository.removePrime(prime.value);
      }
      
      state = const Inventory();
      
      Logger.logInventory('Inventory cleared');
    } catch (e, stackTrace) {
      Logger.error('Failed to clear inventory', e, stackTrace);
    }
  }

  /// Debug method to add test primes
  Future<void> addTestPrimes() async {
    final testPrimes = [
      Prime(value: 2, count: 3, firstObtained: DateTime.now()),
      Prime(value: 3, count: 2, firstObtained: DateTime.now()),
      Prime(value: 5, count: 1, firstObtained: DateTime.now()),
      Prime(value: 7, count: 1, firstObtained: DateTime.now()),
      Prime(value: 11, count: 1, firstObtained: DateTime.now()),
    ];

    await addMultiplePrimes(testPrimes);
  }
}

/// Inventory provider
final inventoryProvider = StateNotifierProvider<InventoryNotifier, Inventory>((ref) {
  final repository = GameRepository();
  return InventoryNotifier(repository);
});

/// Game repository provider
final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository();
});

/// Computed providers for inventory
final totalPrimesProvider = Provider<int>((ref) {
  return ref.watch(inventoryProvider).totalCount;
});

final uniquePrimesProvider = Provider<int>((ref) {
  return ref.watch(inventoryProvider).uniqueCount;
});

final availablePrimesProvider = Provider<List<Prime>>((ref) {
  return ref.watch(inventoryProvider).availablePrimes;
});

final sortedPrimesByValueProvider = Provider<List<Prime>>((ref) {
  return ref.watch(inventoryProvider).sortedByValue;
});

final sortedPrimesByCountProvider = Provider<List<Prime>>((ref) {
  return ref.watch(inventoryProvider).sortedByCount;
});

final sortedPrimesByUsageProvider = Provider<List<Prime>>((ref) {
  return ref.watch(inventoryProvider).sortedByUsage;
});

final inventoryStatsProvider = Provider<InventoryStats>((ref) {
  return ref.watch(inventoryProvider).stats;
});

final hasAvailablePrimesProvider = Provider<bool>((ref) {
  return ref.watch(inventoryProvider).hasAvailablePrimes;
});

final isInventoryEmptyProvider = Provider<bool>((ref) {
  return ref.watch(inventoryProvider).isEmpty;
});

/// Specific prime providers
final primeProvider = Provider.family<Prime?, int>((ref, primeValue) {
  return ref.watch(inventoryProvider).getPrime(primeValue);
});

final primeCountProvider = Provider.family<int, int>((ref, primeValue) {
  final prime = ref.watch(primeProvider(primeValue));
  return prime?.count ?? 0;
});

final primeAvailableProvider = Provider.family<bool, int>((ref, primeValue) {
  return ref.watch(inventoryProvider).isPrimeAvailable(primeValue);
});

final primeUsageProvider = Provider.family<int, int>((ref, primeValue) {
  final prime = ref.watch(primeProvider(primeValue));
  return prime?.usageCount ?? 0;
});

/// Attack-specific providers
final primesForEnemyProvider = Provider.family<List<Prime>, int>((ref, enemyValue) {
  return ref.watch(inventoryProvider).getPrimesForAttack(enemyValue);
});

final canAttackEnemyProvider = Provider.family<bool, int>((ref, enemyValue) {
  final attackPrimes = ref.watch(primesForEnemyProvider(enemyValue));
  return attackPrimes.isNotEmpty;
});

/// Inventory categories
final smallPrimesProvider = Provider<List<Prime>>((ref) {
  return ref.watch(inventoryProvider).primes
      .where((prime) => prime.isSmallPrime)
      .toList();
});

final largePrimesProvider = Provider<List<Prime>>((ref) {
  return ref.watch(inventoryProvider).primes
      .where((prime) => !prime.isSmallPrime)
      .toList();
});

final mostUsedPrimeProvider = Provider<Prime?>((ref) {
  final stats = ref.watch(inventoryStatsProvider);
  return stats.mostUsedPrime;
});

final averageUsageProvider = Provider<double>((ref) {
  final stats = ref.watch(inventoryStatsProvider);
  return stats.averageUsage;
});

/// Inventory capacity providers
final canAddPrimeProvider = Provider.family<bool, ({int value, int count})>((ref, params) {
  final notifier = ref.read(inventoryProvider.notifier);
  return notifier.canAddPrime(params.value, params.count);
});

final primeCapacityProvider = Provider.family<int, int>((ref, primeValue) {
  final prime = ref.watch(primeProvider(primeValue));
  final isSmallPrime = primeValue <= GameConstants.smallPrimeThreshold;
  
  final maxCount = isSmallPrime 
      ? GameConstants.maxSmallPrimeCount 
      : GameConstants.maxLargePrimeCount;
  
  final currentCount = prime?.count ?? 0;
  return maxCount - currentCount;
});

/// Inventory search and filter providers
final searchPrimesProvider = Provider.family<List<Prime>, String>((ref, query) {
  final inventory = ref.watch(inventoryProvider);
  
  if (query.isEmpty) return inventory.primes;
  
  final searchValue = int.tryParse(query);
  if (searchValue != null) {
    return inventory.primes
        .where((prime) => prime.value.toString().contains(query))
        .toList();
  }
  
  return [];
});

final filterAvailableOnlyProvider = StateProvider<bool>((ref) => false);

final filteredPrimesProvider = Provider<List<Prime>>((ref) {
  final inventory = ref.watch(inventoryProvider);
  final availableOnly = ref.watch(filterAvailableOnlyProvider);
  
  if (availableOnly) {
    return inventory.availablePrimes;
  }
  
  return inventory.primes;
});