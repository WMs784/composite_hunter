// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Player {
// Basic player info
  int get level => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError; // Battle statistics
  int get totalBattles => throw _privateConstructorUsedError;
  int get totalVictories => throw _privateConstructorUsedError;
  int get totalEscapes => throw _privateConstructorUsedError;
  int get totalTimeOuts => throw _privateConstructorUsedError;
  int get totalPowerEnemiesDefeated =>
      throw _privateConstructorUsedError; // Performance statistics
  int get totalTurnsUsed => throw _privateConstructorUsedError;
  int get totalTimeSpent => throw _privateConstructorUsedError; // in seconds
  int get perfectBattles => throw _privateConstructorUsedError;
  int get fastestBattleTime => throw _privateConstructorUsedError; // in seconds
  int get longestWinStreak => throw _privateConstructorUsedError;
  int get currentWinStreak =>
      throw _privateConstructorUsedError; // Prime collection statistics
  int get totalPrimesCollected => throw _privateConstructorUsedError;
  int get uniquePrimesCollected => throw _privateConstructorUsedError;
  int get largestPrimeCollected => throw _privateConstructorUsedError;
  int get smallestEnemyDefeated => throw _privateConstructorUsedError;
  int get largestEnemyDefeated =>
      throw _privateConstructorUsedError; // Special achievements
  int get giantEnemiesDefeated =>
      throw _privateConstructorUsedError; // enemies > 1000
  int get speedVictories =>
      throw _privateConstructorUsedError; // battles won in < 10 seconds
  int get efficientVictories =>
      throw _privateConstructorUsedError; // battles won in <= 3 turns
  int get combackVictories =>
      throw _privateConstructorUsedError; // battles won with < 5 seconds remaining
// Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastPlayedAt => throw _privateConstructorUsedError;
  DateTime? get lastLevelUpAt => throw _privateConstructorUsedError;
  DateTime? get lastAchievementAt =>
      throw _privateConstructorUsedError; // Preferences
  PlayerPreferences get preferences => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {int level,
      int experience,
      int totalBattles,
      int totalVictories,
      int totalEscapes,
      int totalTimeOuts,
      int totalPowerEnemiesDefeated,
      int totalTurnsUsed,
      int totalTimeSpent,
      int perfectBattles,
      int fastestBattleTime,
      int longestWinStreak,
      int currentWinStreak,
      int totalPrimesCollected,
      int uniquePrimesCollected,
      int largestPrimeCollected,
      int smallestEnemyDefeated,
      int largestEnemyDefeated,
      int giantEnemiesDefeated,
      int speedVictories,
      int efficientVictories,
      int combackVictories,
      DateTime? createdAt,
      DateTime? lastPlayedAt,
      DateTime? lastLevelUpAt,
      DateTime? lastAchievementAt,
      PlayerPreferences preferences});

  $PlayerPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? experience = null,
    Object? totalBattles = null,
    Object? totalVictories = null,
    Object? totalEscapes = null,
    Object? totalTimeOuts = null,
    Object? totalPowerEnemiesDefeated = null,
    Object? totalTurnsUsed = null,
    Object? totalTimeSpent = null,
    Object? perfectBattles = null,
    Object? fastestBattleTime = null,
    Object? longestWinStreak = null,
    Object? currentWinStreak = null,
    Object? totalPrimesCollected = null,
    Object? uniquePrimesCollected = null,
    Object? largestPrimeCollected = null,
    Object? smallestEnemyDefeated = null,
    Object? largestEnemyDefeated = null,
    Object? giantEnemiesDefeated = null,
    Object? speedVictories = null,
    Object? efficientVictories = null,
    Object? combackVictories = null,
    Object? createdAt = freezed,
    Object? lastPlayedAt = freezed,
    Object? lastLevelUpAt = freezed,
    Object? lastAchievementAt = freezed,
    Object? preferences = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      totalBattles: null == totalBattles
          ? _value.totalBattles
          : totalBattles // ignore: cast_nullable_to_non_nullable
              as int,
      totalVictories: null == totalVictories
          ? _value.totalVictories
          : totalVictories // ignore: cast_nullable_to_non_nullable
              as int,
      totalEscapes: null == totalEscapes
          ? _value.totalEscapes
          : totalEscapes // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeOuts: null == totalTimeOuts
          ? _value.totalTimeOuts
          : totalTimeOuts // ignore: cast_nullable_to_non_nullable
              as int,
      totalPowerEnemiesDefeated: null == totalPowerEnemiesDefeated
          ? _value.totalPowerEnemiesDefeated
          : totalPowerEnemiesDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      totalTurnsUsed: null == totalTurnsUsed
          ? _value.totalTurnsUsed
          : totalTurnsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeSpent: null == totalTimeSpent
          ? _value.totalTimeSpent
          : totalTimeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      perfectBattles: null == perfectBattles
          ? _value.perfectBattles
          : perfectBattles // ignore: cast_nullable_to_non_nullable
              as int,
      fastestBattleTime: null == fastestBattleTime
          ? _value.fastestBattleTime
          : fastestBattleTime // ignore: cast_nullable_to_non_nullable
              as int,
      longestWinStreak: null == longestWinStreak
          ? _value.longestWinStreak
          : longestWinStreak // ignore: cast_nullable_to_non_nullable
              as int,
      currentWinStreak: null == currentWinStreak
          ? _value.currentWinStreak
          : currentWinStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrimesCollected: null == totalPrimesCollected
          ? _value.totalPrimesCollected
          : totalPrimesCollected // ignore: cast_nullable_to_non_nullable
              as int,
      uniquePrimesCollected: null == uniquePrimesCollected
          ? _value.uniquePrimesCollected
          : uniquePrimesCollected // ignore: cast_nullable_to_non_nullable
              as int,
      largestPrimeCollected: null == largestPrimeCollected
          ? _value.largestPrimeCollected
          : largestPrimeCollected // ignore: cast_nullable_to_non_nullable
              as int,
      smallestEnemyDefeated: null == smallestEnemyDefeated
          ? _value.smallestEnemyDefeated
          : smallestEnemyDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      largestEnemyDefeated: null == largestEnemyDefeated
          ? _value.largestEnemyDefeated
          : largestEnemyDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      giantEnemiesDefeated: null == giantEnemiesDefeated
          ? _value.giantEnemiesDefeated
          : giantEnemiesDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      speedVictories: null == speedVictories
          ? _value.speedVictories
          : speedVictories // ignore: cast_nullable_to_non_nullable
              as int,
      efficientVictories: null == efficientVictories
          ? _value.efficientVictories
          : efficientVictories // ignore: cast_nullable_to_non_nullable
              as int,
      combackVictories: null == combackVictories
          ? _value.combackVictories
          : combackVictories // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPlayedAt: freezed == lastPlayedAt
          ? _value.lastPlayedAt
          : lastPlayedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLevelUpAt: freezed == lastLevelUpAt
          ? _value.lastLevelUpAt
          : lastLevelUpAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAchievementAt: freezed == lastAchievementAt
          ? _value.lastAchievementAt
          : lastAchievementAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as PlayerPreferences,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerPreferencesCopyWith<$Res> get preferences {
    return $PlayerPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int level,
      int experience,
      int totalBattles,
      int totalVictories,
      int totalEscapes,
      int totalTimeOuts,
      int totalPowerEnemiesDefeated,
      int totalTurnsUsed,
      int totalTimeSpent,
      int perfectBattles,
      int fastestBattleTime,
      int longestWinStreak,
      int currentWinStreak,
      int totalPrimesCollected,
      int uniquePrimesCollected,
      int largestPrimeCollected,
      int smallestEnemyDefeated,
      int largestEnemyDefeated,
      int giantEnemiesDefeated,
      int speedVictories,
      int efficientVictories,
      int combackVictories,
      DateTime? createdAt,
      DateTime? lastPlayedAt,
      DateTime? lastLevelUpAt,
      DateTime? lastAchievementAt,
      PlayerPreferences preferences});

  @override
  $PlayerPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? experience = null,
    Object? totalBattles = null,
    Object? totalVictories = null,
    Object? totalEscapes = null,
    Object? totalTimeOuts = null,
    Object? totalPowerEnemiesDefeated = null,
    Object? totalTurnsUsed = null,
    Object? totalTimeSpent = null,
    Object? perfectBattles = null,
    Object? fastestBattleTime = null,
    Object? longestWinStreak = null,
    Object? currentWinStreak = null,
    Object? totalPrimesCollected = null,
    Object? uniquePrimesCollected = null,
    Object? largestPrimeCollected = null,
    Object? smallestEnemyDefeated = null,
    Object? largestEnemyDefeated = null,
    Object? giantEnemiesDefeated = null,
    Object? speedVictories = null,
    Object? efficientVictories = null,
    Object? combackVictories = null,
    Object? createdAt = freezed,
    Object? lastPlayedAt = freezed,
    Object? lastLevelUpAt = freezed,
    Object? lastAchievementAt = freezed,
    Object? preferences = null,
  }) {
    return _then(_$PlayerImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      totalBattles: null == totalBattles
          ? _value.totalBattles
          : totalBattles // ignore: cast_nullable_to_non_nullable
              as int,
      totalVictories: null == totalVictories
          ? _value.totalVictories
          : totalVictories // ignore: cast_nullable_to_non_nullable
              as int,
      totalEscapes: null == totalEscapes
          ? _value.totalEscapes
          : totalEscapes // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeOuts: null == totalTimeOuts
          ? _value.totalTimeOuts
          : totalTimeOuts // ignore: cast_nullable_to_non_nullable
              as int,
      totalPowerEnemiesDefeated: null == totalPowerEnemiesDefeated
          ? _value.totalPowerEnemiesDefeated
          : totalPowerEnemiesDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      totalTurnsUsed: null == totalTurnsUsed
          ? _value.totalTurnsUsed
          : totalTurnsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeSpent: null == totalTimeSpent
          ? _value.totalTimeSpent
          : totalTimeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      perfectBattles: null == perfectBattles
          ? _value.perfectBattles
          : perfectBattles // ignore: cast_nullable_to_non_nullable
              as int,
      fastestBattleTime: null == fastestBattleTime
          ? _value.fastestBattleTime
          : fastestBattleTime // ignore: cast_nullable_to_non_nullable
              as int,
      longestWinStreak: null == longestWinStreak
          ? _value.longestWinStreak
          : longestWinStreak // ignore: cast_nullable_to_non_nullable
              as int,
      currentWinStreak: null == currentWinStreak
          ? _value.currentWinStreak
          : currentWinStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrimesCollected: null == totalPrimesCollected
          ? _value.totalPrimesCollected
          : totalPrimesCollected // ignore: cast_nullable_to_non_nullable
              as int,
      uniquePrimesCollected: null == uniquePrimesCollected
          ? _value.uniquePrimesCollected
          : uniquePrimesCollected // ignore: cast_nullable_to_non_nullable
              as int,
      largestPrimeCollected: null == largestPrimeCollected
          ? _value.largestPrimeCollected
          : largestPrimeCollected // ignore: cast_nullable_to_non_nullable
              as int,
      smallestEnemyDefeated: null == smallestEnemyDefeated
          ? _value.smallestEnemyDefeated
          : smallestEnemyDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      largestEnemyDefeated: null == largestEnemyDefeated
          ? _value.largestEnemyDefeated
          : largestEnemyDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      giantEnemiesDefeated: null == giantEnemiesDefeated
          ? _value.giantEnemiesDefeated
          : giantEnemiesDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      speedVictories: null == speedVictories
          ? _value.speedVictories
          : speedVictories // ignore: cast_nullable_to_non_nullable
              as int,
      efficientVictories: null == efficientVictories
          ? _value.efficientVictories
          : efficientVictories // ignore: cast_nullable_to_non_nullable
              as int,
      combackVictories: null == combackVictories
          ? _value.combackVictories
          : combackVictories // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPlayedAt: freezed == lastPlayedAt
          ? _value.lastPlayedAt
          : lastPlayedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLevelUpAt: freezed == lastLevelUpAt
          ? _value.lastLevelUpAt
          : lastLevelUpAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAchievementAt: freezed == lastAchievementAt
          ? _value.lastAchievementAt
          : lastAchievementAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as PlayerPreferences,
    ));
  }
}

/// @nodoc

class _$PlayerImpl implements _Player {
  const _$PlayerImpl(
      {this.level = 1,
      this.experience = 0,
      this.totalBattles = 0,
      this.totalVictories = 0,
      this.totalEscapes = 0,
      this.totalTimeOuts = 0,
      this.totalPowerEnemiesDefeated = 0,
      this.totalTurnsUsed = 0,
      this.totalTimeSpent = 0,
      this.perfectBattles = 0,
      this.fastestBattleTime = 0,
      this.longestWinStreak = 0,
      this.currentWinStreak = 0,
      this.totalPrimesCollected = 0,
      this.uniquePrimesCollected = 0,
      this.largestPrimeCollected = 0,
      this.smallestEnemyDefeated = 0,
      this.largestEnemyDefeated = 0,
      this.giantEnemiesDefeated = 0,
      this.speedVictories = 0,
      this.efficientVictories = 0,
      this.combackVictories = 0,
      this.createdAt,
      this.lastPlayedAt,
      this.lastLevelUpAt,
      this.lastAchievementAt,
      this.preferences = const PlayerPreferences()});

// Basic player info
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int experience;
// Battle statistics
  @override
  @JsonKey()
  final int totalBattles;
  @override
  @JsonKey()
  final int totalVictories;
  @override
  @JsonKey()
  final int totalEscapes;
  @override
  @JsonKey()
  final int totalTimeOuts;
  @override
  @JsonKey()
  final int totalPowerEnemiesDefeated;
// Performance statistics
  @override
  @JsonKey()
  final int totalTurnsUsed;
  @override
  @JsonKey()
  final int totalTimeSpent;
// in seconds
  @override
  @JsonKey()
  final int perfectBattles;
  @override
  @JsonKey()
  final int fastestBattleTime;
// in seconds
  @override
  @JsonKey()
  final int longestWinStreak;
  @override
  @JsonKey()
  final int currentWinStreak;
// Prime collection statistics
  @override
  @JsonKey()
  final int totalPrimesCollected;
  @override
  @JsonKey()
  final int uniquePrimesCollected;
  @override
  @JsonKey()
  final int largestPrimeCollected;
  @override
  @JsonKey()
  final int smallestEnemyDefeated;
  @override
  @JsonKey()
  final int largestEnemyDefeated;
// Special achievements
  @override
  @JsonKey()
  final int giantEnemiesDefeated;
// enemies > 1000
  @override
  @JsonKey()
  final int speedVictories;
// battles won in < 10 seconds
  @override
  @JsonKey()
  final int efficientVictories;
// battles won in <= 3 turns
  @override
  @JsonKey()
  final int combackVictories;
// battles won with < 5 seconds remaining
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastPlayedAt;
  @override
  final DateTime? lastLevelUpAt;
  @override
  final DateTime? lastAchievementAt;
// Preferences
  @override
  @JsonKey()
  final PlayerPreferences preferences;

  @override
  String toString() {
    return 'Player(level: $level, experience: $experience, totalBattles: $totalBattles, totalVictories: $totalVictories, totalEscapes: $totalEscapes, totalTimeOuts: $totalTimeOuts, totalPowerEnemiesDefeated: $totalPowerEnemiesDefeated, totalTurnsUsed: $totalTurnsUsed, totalTimeSpent: $totalTimeSpent, perfectBattles: $perfectBattles, fastestBattleTime: $fastestBattleTime, longestWinStreak: $longestWinStreak, currentWinStreak: $currentWinStreak, totalPrimesCollected: $totalPrimesCollected, uniquePrimesCollected: $uniquePrimesCollected, largestPrimeCollected: $largestPrimeCollected, smallestEnemyDefeated: $smallestEnemyDefeated, largestEnemyDefeated: $largestEnemyDefeated, giantEnemiesDefeated: $giantEnemiesDefeated, speedVictories: $speedVictories, efficientVictories: $efficientVictories, combackVictories: $combackVictories, createdAt: $createdAt, lastPlayedAt: $lastPlayedAt, lastLevelUpAt: $lastLevelUpAt, lastAchievementAt: $lastAchievementAt, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.totalBattles, totalBattles) ||
                other.totalBattles == totalBattles) &&
            (identical(other.totalVictories, totalVictories) ||
                other.totalVictories == totalVictories) &&
            (identical(other.totalEscapes, totalEscapes) ||
                other.totalEscapes == totalEscapes) &&
            (identical(other.totalTimeOuts, totalTimeOuts) ||
                other.totalTimeOuts == totalTimeOuts) &&
            (identical(other.totalPowerEnemiesDefeated,
                    totalPowerEnemiesDefeated) ||
                other.totalPowerEnemiesDefeated == totalPowerEnemiesDefeated) &&
            (identical(other.totalTurnsUsed, totalTurnsUsed) ||
                other.totalTurnsUsed == totalTurnsUsed) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent) &&
            (identical(other.perfectBattles, perfectBattles) ||
                other.perfectBattles == perfectBattles) &&
            (identical(other.fastestBattleTime, fastestBattleTime) ||
                other.fastestBattleTime == fastestBattleTime) &&
            (identical(other.longestWinStreak, longestWinStreak) ||
                other.longestWinStreak == longestWinStreak) &&
            (identical(other.currentWinStreak, currentWinStreak) ||
                other.currentWinStreak == currentWinStreak) &&
            (identical(other.totalPrimesCollected, totalPrimesCollected) ||
                other.totalPrimesCollected == totalPrimesCollected) &&
            (identical(other.uniquePrimesCollected, uniquePrimesCollected) ||
                other.uniquePrimesCollected == uniquePrimesCollected) &&
            (identical(other.largestPrimeCollected, largestPrimeCollected) ||
                other.largestPrimeCollected == largestPrimeCollected) &&
            (identical(other.smallestEnemyDefeated, smallestEnemyDefeated) ||
                other.smallestEnemyDefeated == smallestEnemyDefeated) &&
            (identical(other.largestEnemyDefeated, largestEnemyDefeated) ||
                other.largestEnemyDefeated == largestEnemyDefeated) &&
            (identical(other.giantEnemiesDefeated, giantEnemiesDefeated) ||
                other.giantEnemiesDefeated == giantEnemiesDefeated) &&
            (identical(other.speedVictories, speedVictories) ||
                other.speedVictories == speedVictories) &&
            (identical(other.efficientVictories, efficientVictories) ||
                other.efficientVictories == efficientVictories) &&
            (identical(other.combackVictories, combackVictories) ||
                other.combackVictories == combackVictories) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastPlayedAt, lastPlayedAt) ||
                other.lastPlayedAt == lastPlayedAt) &&
            (identical(other.lastLevelUpAt, lastLevelUpAt) ||
                other.lastLevelUpAt == lastLevelUpAt) &&
            (identical(other.lastAchievementAt, lastAchievementAt) ||
                other.lastAchievementAt == lastAchievementAt) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        level,
        experience,
        totalBattles,
        totalVictories,
        totalEscapes,
        totalTimeOuts,
        totalPowerEnemiesDefeated,
        totalTurnsUsed,
        totalTimeSpent,
        perfectBattles,
        fastestBattleTime,
        longestWinStreak,
        currentWinStreak,
        totalPrimesCollected,
        uniquePrimesCollected,
        largestPrimeCollected,
        smallestEnemyDefeated,
        largestEnemyDefeated,
        giantEnemiesDefeated,
        speedVictories,
        efficientVictories,
        combackVictories,
        createdAt,
        lastPlayedAt,
        lastLevelUpAt,
        lastAchievementAt,
        preferences
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);
}

abstract class _Player implements Player {
  const factory _Player(
      {final int level,
      final int experience,
      final int totalBattles,
      final int totalVictories,
      final int totalEscapes,
      final int totalTimeOuts,
      final int totalPowerEnemiesDefeated,
      final int totalTurnsUsed,
      final int totalTimeSpent,
      final int perfectBattles,
      final int fastestBattleTime,
      final int longestWinStreak,
      final int currentWinStreak,
      final int totalPrimesCollected,
      final int uniquePrimesCollected,
      final int largestPrimeCollected,
      final int smallestEnemyDefeated,
      final int largestEnemyDefeated,
      final int giantEnemiesDefeated,
      final int speedVictories,
      final int efficientVictories,
      final int combackVictories,
      final DateTime? createdAt,
      final DateTime? lastPlayedAt,
      final DateTime? lastLevelUpAt,
      final DateTime? lastAchievementAt,
      final PlayerPreferences preferences}) = _$PlayerImpl;

  @override // Basic player info
  int get level;
  @override
  int get experience;
  @override // Battle statistics
  int get totalBattles;
  @override
  int get totalVictories;
  @override
  int get totalEscapes;
  @override
  int get totalTimeOuts;
  @override
  int get totalPowerEnemiesDefeated;
  @override // Performance statistics
  int get totalTurnsUsed;
  @override
  int get totalTimeSpent;
  @override // in seconds
  int get perfectBattles;
  @override
  int get fastestBattleTime;
  @override // in seconds
  int get longestWinStreak;
  @override
  int get currentWinStreak;
  @override // Prime collection statistics
  int get totalPrimesCollected;
  @override
  int get uniquePrimesCollected;
  @override
  int get largestPrimeCollected;
  @override
  int get smallestEnemyDefeated;
  @override
  int get largestEnemyDefeated;
  @override // Special achievements
  int get giantEnemiesDefeated;
  @override // enemies > 1000
  int get speedVictories;
  @override // battles won in < 10 seconds
  int get efficientVictories;
  @override // battles won in <= 3 turns
  int get combackVictories;
  @override // battles won with < 5 seconds remaining
// Timestamps
  DateTime? get createdAt;
  @override
  DateTime? get lastPlayedAt;
  @override
  DateTime? get lastLevelUpAt;
  @override
  DateTime? get lastAchievementAt;
  @override // Preferences
  PlayerPreferences get preferences;
  @override
  @JsonKey(ignore: true)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerPreferences {
// Gameplay preferences
  bool get showHints => throw _privateConstructorUsedError;
  bool get showAnimations => throw _privateConstructorUsedError;
  bool get autoSave => throw _privateConstructorUsedError;
  bool get vibrateOnAttack => throw _privateConstructorUsedError;
  bool get soundEffects => throw _privateConstructorUsedError;
  bool get backgroundMusic =>
      throw _privateConstructorUsedError; // Display preferences
  bool get showStatistics => throw _privateConstructorUsedError;
  bool get showTimer => throw _privateConstructorUsedError;
  bool get showProgress => throw _privateConstructorUsedError;
  bool get darkMode =>
      throw _privateConstructorUsedError; // Notification preferences
  bool get achievementNotifications => throw _privateConstructorUsedError;
  bool get levelUpNotifications => throw _privateConstructorUsedError;
  bool get dailyReminders =>
      throw _privateConstructorUsedError; // Tutorial preferences
  bool get skipTutorial => throw _privateConstructorUsedError;
  bool get showTips => throw _privateConstructorUsedError;
  bool get showControls => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerPreferencesCopyWith<PlayerPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerPreferencesCopyWith<$Res> {
  factory $PlayerPreferencesCopyWith(
          PlayerPreferences value, $Res Function(PlayerPreferences) then) =
      _$PlayerPreferencesCopyWithImpl<$Res, PlayerPreferences>;
  @useResult
  $Res call(
      {bool showHints,
      bool showAnimations,
      bool autoSave,
      bool vibrateOnAttack,
      bool soundEffects,
      bool backgroundMusic,
      bool showStatistics,
      bool showTimer,
      bool showProgress,
      bool darkMode,
      bool achievementNotifications,
      bool levelUpNotifications,
      bool dailyReminders,
      bool skipTutorial,
      bool showTips,
      bool showControls});
}

/// @nodoc
class _$PlayerPreferencesCopyWithImpl<$Res, $Val extends PlayerPreferences>
    implements $PlayerPreferencesCopyWith<$Res> {
  _$PlayerPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showHints = null,
    Object? showAnimations = null,
    Object? autoSave = null,
    Object? vibrateOnAttack = null,
    Object? soundEffects = null,
    Object? backgroundMusic = null,
    Object? showStatistics = null,
    Object? showTimer = null,
    Object? showProgress = null,
    Object? darkMode = null,
    Object? achievementNotifications = null,
    Object? levelUpNotifications = null,
    Object? dailyReminders = null,
    Object? skipTutorial = null,
    Object? showTips = null,
    Object? showControls = null,
  }) {
    return _then(_value.copyWith(
      showHints: null == showHints
          ? _value.showHints
          : showHints // ignore: cast_nullable_to_non_nullable
              as bool,
      showAnimations: null == showAnimations
          ? _value.showAnimations
          : showAnimations // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSave: null == autoSave
          ? _value.autoSave
          : autoSave // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrateOnAttack: null == vibrateOnAttack
          ? _value.vibrateOnAttack
          : vibrateOnAttack // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEffects: null == soundEffects
          ? _value.soundEffects
          : soundEffects // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundMusic: null == backgroundMusic
          ? _value.backgroundMusic
          : backgroundMusic // ignore: cast_nullable_to_non_nullable
              as bool,
      showStatistics: null == showStatistics
          ? _value.showStatistics
          : showStatistics // ignore: cast_nullable_to_non_nullable
              as bool,
      showTimer: null == showTimer
          ? _value.showTimer
          : showTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      showProgress: null == showProgress
          ? _value.showProgress
          : showProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      achievementNotifications: null == achievementNotifications
          ? _value.achievementNotifications
          : achievementNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      levelUpNotifications: null == levelUpNotifications
          ? _value.levelUpNotifications
          : levelUpNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminders: null == dailyReminders
          ? _value.dailyReminders
          : dailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      skipTutorial: null == skipTutorial
          ? _value.skipTutorial
          : skipTutorial // ignore: cast_nullable_to_non_nullable
              as bool,
      showTips: null == showTips
          ? _value.showTips
          : showTips // ignore: cast_nullable_to_non_nullable
              as bool,
      showControls: null == showControls
          ? _value.showControls
          : showControls // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerPreferencesImplCopyWith<$Res>
    implements $PlayerPreferencesCopyWith<$Res> {
  factory _$$PlayerPreferencesImplCopyWith(_$PlayerPreferencesImpl value,
          $Res Function(_$PlayerPreferencesImpl) then) =
      __$$PlayerPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showHints,
      bool showAnimations,
      bool autoSave,
      bool vibrateOnAttack,
      bool soundEffects,
      bool backgroundMusic,
      bool showStatistics,
      bool showTimer,
      bool showProgress,
      bool darkMode,
      bool achievementNotifications,
      bool levelUpNotifications,
      bool dailyReminders,
      bool skipTutorial,
      bool showTips,
      bool showControls});
}

/// @nodoc
class __$$PlayerPreferencesImplCopyWithImpl<$Res>
    extends _$PlayerPreferencesCopyWithImpl<$Res, _$PlayerPreferencesImpl>
    implements _$$PlayerPreferencesImplCopyWith<$Res> {
  __$$PlayerPreferencesImplCopyWithImpl(_$PlayerPreferencesImpl _value,
      $Res Function(_$PlayerPreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showHints = null,
    Object? showAnimations = null,
    Object? autoSave = null,
    Object? vibrateOnAttack = null,
    Object? soundEffects = null,
    Object? backgroundMusic = null,
    Object? showStatistics = null,
    Object? showTimer = null,
    Object? showProgress = null,
    Object? darkMode = null,
    Object? achievementNotifications = null,
    Object? levelUpNotifications = null,
    Object? dailyReminders = null,
    Object? skipTutorial = null,
    Object? showTips = null,
    Object? showControls = null,
  }) {
    return _then(_$PlayerPreferencesImpl(
      showHints: null == showHints
          ? _value.showHints
          : showHints // ignore: cast_nullable_to_non_nullable
              as bool,
      showAnimations: null == showAnimations
          ? _value.showAnimations
          : showAnimations // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSave: null == autoSave
          ? _value.autoSave
          : autoSave // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrateOnAttack: null == vibrateOnAttack
          ? _value.vibrateOnAttack
          : vibrateOnAttack // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEffects: null == soundEffects
          ? _value.soundEffects
          : soundEffects // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundMusic: null == backgroundMusic
          ? _value.backgroundMusic
          : backgroundMusic // ignore: cast_nullable_to_non_nullable
              as bool,
      showStatistics: null == showStatistics
          ? _value.showStatistics
          : showStatistics // ignore: cast_nullable_to_non_nullable
              as bool,
      showTimer: null == showTimer
          ? _value.showTimer
          : showTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      showProgress: null == showProgress
          ? _value.showProgress
          : showProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      achievementNotifications: null == achievementNotifications
          ? _value.achievementNotifications
          : achievementNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      levelUpNotifications: null == levelUpNotifications
          ? _value.levelUpNotifications
          : levelUpNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminders: null == dailyReminders
          ? _value.dailyReminders
          : dailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      skipTutorial: null == skipTutorial
          ? _value.skipTutorial
          : skipTutorial // ignore: cast_nullable_to_non_nullable
              as bool,
      showTips: null == showTips
          ? _value.showTips
          : showTips // ignore: cast_nullable_to_non_nullable
              as bool,
      showControls: null == showControls
          ? _value.showControls
          : showControls // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PlayerPreferencesImpl implements _PlayerPreferences {
  const _$PlayerPreferencesImpl(
      {this.showHints = true,
      this.showAnimations = true,
      this.autoSave = true,
      this.vibrateOnAttack = true,
      this.soundEffects = true,
      this.backgroundMusic = true,
      this.showStatistics = true,
      this.showTimer = true,
      this.showProgress = true,
      this.darkMode = false,
      this.achievementNotifications = true,
      this.levelUpNotifications = true,
      this.dailyReminders = false,
      this.skipTutorial = false,
      this.showTips = true,
      this.showControls = true});

// Gameplay preferences
  @override
  @JsonKey()
  final bool showHints;
  @override
  @JsonKey()
  final bool showAnimations;
  @override
  @JsonKey()
  final bool autoSave;
  @override
  @JsonKey()
  final bool vibrateOnAttack;
  @override
  @JsonKey()
  final bool soundEffects;
  @override
  @JsonKey()
  final bool backgroundMusic;
// Display preferences
  @override
  @JsonKey()
  final bool showStatistics;
  @override
  @JsonKey()
  final bool showTimer;
  @override
  @JsonKey()
  final bool showProgress;
  @override
  @JsonKey()
  final bool darkMode;
// Notification preferences
  @override
  @JsonKey()
  final bool achievementNotifications;
  @override
  @JsonKey()
  final bool levelUpNotifications;
  @override
  @JsonKey()
  final bool dailyReminders;
// Tutorial preferences
  @override
  @JsonKey()
  final bool skipTutorial;
  @override
  @JsonKey()
  final bool showTips;
  @override
  @JsonKey()
  final bool showControls;

  @override
  String toString() {
    return 'PlayerPreferences(showHints: $showHints, showAnimations: $showAnimations, autoSave: $autoSave, vibrateOnAttack: $vibrateOnAttack, soundEffects: $soundEffects, backgroundMusic: $backgroundMusic, showStatistics: $showStatistics, showTimer: $showTimer, showProgress: $showProgress, darkMode: $darkMode, achievementNotifications: $achievementNotifications, levelUpNotifications: $levelUpNotifications, dailyReminders: $dailyReminders, skipTutorial: $skipTutorial, showTips: $showTips, showControls: $showControls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerPreferencesImpl &&
            (identical(other.showHints, showHints) ||
                other.showHints == showHints) &&
            (identical(other.showAnimations, showAnimations) ||
                other.showAnimations == showAnimations) &&
            (identical(other.autoSave, autoSave) ||
                other.autoSave == autoSave) &&
            (identical(other.vibrateOnAttack, vibrateOnAttack) ||
                other.vibrateOnAttack == vibrateOnAttack) &&
            (identical(other.soundEffects, soundEffects) ||
                other.soundEffects == soundEffects) &&
            (identical(other.backgroundMusic, backgroundMusic) ||
                other.backgroundMusic == backgroundMusic) &&
            (identical(other.showStatistics, showStatistics) ||
                other.showStatistics == showStatistics) &&
            (identical(other.showTimer, showTimer) ||
                other.showTimer == showTimer) &&
            (identical(other.showProgress, showProgress) ||
                other.showProgress == showProgress) &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(
                    other.achievementNotifications, achievementNotifications) ||
                other.achievementNotifications == achievementNotifications) &&
            (identical(other.levelUpNotifications, levelUpNotifications) ||
                other.levelUpNotifications == levelUpNotifications) &&
            (identical(other.dailyReminders, dailyReminders) ||
                other.dailyReminders == dailyReminders) &&
            (identical(other.skipTutorial, skipTutorial) ||
                other.skipTutorial == skipTutorial) &&
            (identical(other.showTips, showTips) ||
                other.showTips == showTips) &&
            (identical(other.showControls, showControls) ||
                other.showControls == showControls));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      showHints,
      showAnimations,
      autoSave,
      vibrateOnAttack,
      soundEffects,
      backgroundMusic,
      showStatistics,
      showTimer,
      showProgress,
      darkMode,
      achievementNotifications,
      levelUpNotifications,
      dailyReminders,
      skipTutorial,
      showTips,
      showControls);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerPreferencesImplCopyWith<_$PlayerPreferencesImpl> get copyWith =>
      __$$PlayerPreferencesImplCopyWithImpl<_$PlayerPreferencesImpl>(
          this, _$identity);
}

abstract class _PlayerPreferences implements PlayerPreferences {
  const factory _PlayerPreferences(
      {final bool showHints,
      final bool showAnimations,
      final bool autoSave,
      final bool vibrateOnAttack,
      final bool soundEffects,
      final bool backgroundMusic,
      final bool showStatistics,
      final bool showTimer,
      final bool showProgress,
      final bool darkMode,
      final bool achievementNotifications,
      final bool levelUpNotifications,
      final bool dailyReminders,
      final bool skipTutorial,
      final bool showTips,
      final bool showControls}) = _$PlayerPreferencesImpl;

  @override // Gameplay preferences
  bool get showHints;
  @override
  bool get showAnimations;
  @override
  bool get autoSave;
  @override
  bool get vibrateOnAttack;
  @override
  bool get soundEffects;
  @override
  bool get backgroundMusic;
  @override // Display preferences
  bool get showStatistics;
  @override
  bool get showTimer;
  @override
  bool get showProgress;
  @override
  bool get darkMode;
  @override // Notification preferences
  bool get achievementNotifications;
  @override
  bool get levelUpNotifications;
  @override
  bool get dailyReminders;
  @override // Tutorial preferences
  bool get skipTutorial;
  @override
  bool get showTips;
  @override
  bool get showControls;
  @override
  @JsonKey(ignore: true)
  _$$PlayerPreferencesImplCopyWith<_$PlayerPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
