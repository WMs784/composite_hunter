import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/math_utils.dart';

part 'victory_claim.freezed.dart';

@freezed
class VictoryClaim with _$VictoryClaim {
  const factory VictoryClaim({
    required int claimedValue,
    required DateTime claimedAt,
    required bool isCorrect,
    int? rewardPrime,
    String? errorMessage,
  }) = _VictoryClaim;

  const VictoryClaim._();

  /// Create a correct victory claim
  factory VictoryClaim.correct({
    required int claimedValue,
    DateTime? claimedAt,
  }) {
    return VictoryClaim(
      claimedValue: claimedValue,
      claimedAt: claimedAt ?? DateTime.now(),
      isCorrect: true,
      rewardPrime: claimedValue,
    );
  }

  /// Create an incorrect victory claim
  factory VictoryClaim.incorrect({
    required int claimedValue,
    DateTime? claimedAt,
    String? errorMessage,
  }) {
    return VictoryClaim(
      claimedValue: claimedValue,
      claimedAt: claimedAt ?? DateTime.now(),
      isCorrect: false,
      errorMessage:
          errorMessage ?? 'The claimed value $claimedValue is not prime',
    );
  }

  /// Validate the claim against the actual value
  static VictoryClaim validate(int actualValue, DateTime? claimedAt) {
    final isPrime = MathUtils.isPrime(actualValue);

    if (isPrime) {
      return VictoryClaim.correct(
        claimedValue: actualValue,
        claimedAt: claimedAt,
      );
    } else {
      return VictoryClaim.incorrect(
        claimedValue: actualValue,
        claimedAt: claimedAt,
        errorMessage:
            'The value $actualValue is still composite. Continue attacking!',
      );
    }
  }

  /// Get human-readable result message
  String get resultMessage {
    if (isCorrect) {
      return 'Correct! You found the prime $claimedValue!';
    } else {
      return errorMessage ?? 'Incorrect victory claim';
    }
  }

  /// Get the time taken for this claim (if available)
  Duration? timeSinceStart(DateTime battleStartTime) {
    if (claimedAt.isBefore(battleStartTime)) return null;
    return claimedAt.difference(battleStartTime);
  }

  @override
  String toString() {
    return 'VictoryClaim(value: $claimedValue, correct: $isCorrect, at: $claimedAt)';
  }
}
