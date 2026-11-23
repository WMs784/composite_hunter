import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple working providers for battle screen
final battleEnemyProvider = StateProvider<int>((ref) => 12);
final battleTimerProvider = StateProvider<int>((ref) => 90);
final battleStartTimeProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

// Recently acquired primes (for visual feedback)
final recentlyAcquiredPrimesProvider = StateProvider<Map<int, DateTime>>(
  (ref) => {},
);

// Attack feedback animation trigger (increments on each attack)
final battleAttackCountProvider = StateProvider<int>((ref) => 0);

// Max timer value for CircularProgressIndicator ratio
final battleMaxTimerProvider = StateProvider<int>((ref) => 90);

// Invalid attack animation trigger — red flash on enemy card
final battleInvalidAttackProvider = StateProvider<int>((ref) => 0);
