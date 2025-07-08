// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
// Player data
  Player get player =>
      throw _privateConstructorUsedError; // Game initialization state
  bool get isInitialized =>
      throw _privateConstructorUsedError; // Tutorial state
  bool get tutorialCompleted =>
      throw _privateConstructorUsedError; // Game session state
  bool get isFirstLaunch => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get isOfflineMode => throw _privateConstructorUsedError; // Game settings
  GameDifficulty get difficulty => throw _privateConstructorUsedError;
  GameLanguage get language =>
      throw _privateConstructorUsedError; // Achievement system state
  bool get achievementSystemEnabled => throw _privateConstructorUsedError;
  List<String> get completedAchievements => throw _privateConstructorUsedError;
  List<String> get newAchievements =>
      throw _privateConstructorUsedError; // Statistics tracking
  int get dailyBattlesCompleted => throw _privateConstructorUsedError;
  int get weeklyBattlesCompleted => throw _privateConstructorUsedError;
  int get monthlyBattlesCompleted =>
      throw _privateConstructorUsedError; // Current session stats
  int get sessionBattles => throw _privateConstructorUsedError;
  int get sessionVictories => throw _privateConstructorUsedError;
  int get sessionExperienceGained =>
      throw _privateConstructorUsedError; // Game events
  List<GameEvent> get recentEvents =>
      throw _privateConstructorUsedError; // Save data info
  DateTime? get lastSavedAt => throw _privateConstructorUsedError;
  bool get hasUnsavedChanges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {Player player,
      bool isInitialized,
      bool tutorialCompleted,
      bool isFirstLaunch,
      bool isPaused,
      bool isOfflineMode,
      GameDifficulty difficulty,
      GameLanguage language,
      bool achievementSystemEnabled,
      List<String> completedAchievements,
      List<String> newAchievements,
      int dailyBattlesCompleted,
      int weeklyBattlesCompleted,
      int monthlyBattlesCompleted,
      int sessionBattles,
      int sessionVictories,
      int sessionExperienceGained,
      List<GameEvent> recentEvents,
      DateTime? lastSavedAt,
      bool hasUnsavedChanges});

  $PlayerCopyWith<$Res> get player;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? isInitialized = null,
    Object? tutorialCompleted = null,
    Object? isFirstLaunch = null,
    Object? isPaused = null,
    Object? isOfflineMode = null,
    Object? difficulty = null,
    Object? language = null,
    Object? achievementSystemEnabled = null,
    Object? completedAchievements = null,
    Object? newAchievements = null,
    Object? dailyBattlesCompleted = null,
    Object? weeklyBattlesCompleted = null,
    Object? monthlyBattlesCompleted = null,
    Object? sessionBattles = null,
    Object? sessionVictories = null,
    Object? sessionExperienceGained = null,
    Object? recentEvents = null,
    Object? lastSavedAt = freezed,
    Object? hasUnsavedChanges = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      tutorialCompleted: null == tutorialCompleted
          ? _value.tutorialCompleted
          : tutorialCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstLaunch: null == isFirstLaunch
          ? _value.isFirstLaunch
          : isFirstLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isOfflineMode: null == isOfflineMode
          ? _value.isOfflineMode
          : isOfflineMode // ignore: cast_nullable_to_non_nullable
              as bool,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as GameLanguage,
      achievementSystemEnabled: null == achievementSystemEnabled
          ? _value.achievementSystemEnabled
          : achievementSystemEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAchievements: null == completedAchievements
          ? _value.completedAchievements
          : completedAchievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      newAchievements: null == newAchievements
          ? _value.newAchievements
          : newAchievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dailyBattlesCompleted: null == dailyBattlesCompleted
          ? _value.dailyBattlesCompleted
          : dailyBattlesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      weeklyBattlesCompleted: null == weeklyBattlesCompleted
          ? _value.weeklyBattlesCompleted
          : weeklyBattlesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyBattlesCompleted: null == monthlyBattlesCompleted
          ? _value.monthlyBattlesCompleted
          : monthlyBattlesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      sessionBattles: null == sessionBattles
          ? _value.sessionBattles
          : sessionBattles // ignore: cast_nullable_to_non_nullable
              as int,
      sessionVictories: null == sessionVictories
          ? _value.sessionVictories
          : sessionVictories // ignore: cast_nullable_to_non_nullable
              as int,
      sessionExperienceGained: null == sessionExperienceGained
          ? _value.sessionExperienceGained
          : sessionExperienceGained // ignore: cast_nullable_to_non_nullable
              as int,
      recentEvents: null == recentEvents
          ? _value.recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<GameEvent>,
      lastSavedAt: freezed == lastSavedAt
          ? _value.lastSavedAt
          : lastSavedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasUnsavedChanges: null == hasUnsavedChanges
          ? _value.hasUnsavedChanges
          : hasUnsavedChanges // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player {
    return $PlayerCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Player player,
      bool isInitialized,
      bool tutorialCompleted,
      bool isFirstLaunch,
      bool isPaused,
      bool isOfflineMode,
      GameDifficulty difficulty,
      GameLanguage language,
      bool achievementSystemEnabled,
      List<String> completedAchievements,
      List<String> newAchievements,
      int dailyBattlesCompleted,
      int weeklyBattlesCompleted,
      int monthlyBattlesCompleted,
      int sessionBattles,
      int sessionVictories,
      int sessionExperienceGained,
      List<GameEvent> recentEvents,
      DateTime? lastSavedAt,
      bool hasUnsavedChanges});

  @override
  $PlayerCopyWith<$Res> get player;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? isInitialized = null,
    Object? tutorialCompleted = null,
    Object? isFirstLaunch = null,
    Object? isPaused = null,
    Object? isOfflineMode = null,
    Object? difficulty = null,
    Object? language = null,
    Object? achievementSystemEnabled = null,
    Object? completedAchievements = null,
    Object? newAchievements = null,
    Object? dailyBattlesCompleted = null,
    Object? weeklyBattlesCompleted = null,
    Object? monthlyBattlesCompleted = null,
    Object? sessionBattles = null,
    Object? sessionVictories = null,
    Object? sessionExperienceGained = null,
    Object? recentEvents = null,
    Object? lastSavedAt = freezed,
    Object? hasUnsavedChanges = null,
  }) {
    return _then(_$GameStateImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      tutorialCompleted: null == tutorialCompleted
          ? _value.tutorialCompleted
          : tutorialCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstLaunch: null == isFirstLaunch
          ? _value.isFirstLaunch
          : isFirstLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isOfflineMode: null == isOfflineMode
          ? _value.isOfflineMode
          : isOfflineMode // ignore: cast_nullable_to_non_nullable
              as bool,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as GameLanguage,
      achievementSystemEnabled: null == achievementSystemEnabled
          ? _value.achievementSystemEnabled
          : achievementSystemEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAchievements: null == completedAchievements
          ? _value._completedAchievements
          : completedAchievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      newAchievements: null == newAchievements
          ? _value._newAchievements
          : newAchievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dailyBattlesCompleted: null == dailyBattlesCompleted
          ? _value.dailyBattlesCompleted
          : dailyBattlesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      weeklyBattlesCompleted: null == weeklyBattlesCompleted
          ? _value.weeklyBattlesCompleted
          : weeklyBattlesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyBattlesCompleted: null == monthlyBattlesCompleted
          ? _value.monthlyBattlesCompleted
          : monthlyBattlesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      sessionBattles: null == sessionBattles
          ? _value.sessionBattles
          : sessionBattles // ignore: cast_nullable_to_non_nullable
              as int,
      sessionVictories: null == sessionVictories
          ? _value.sessionVictories
          : sessionVictories // ignore: cast_nullable_to_non_nullable
              as int,
      sessionExperienceGained: null == sessionExperienceGained
          ? _value.sessionExperienceGained
          : sessionExperienceGained // ignore: cast_nullable_to_non_nullable
              as int,
      recentEvents: null == recentEvents
          ? _value._recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<GameEvent>,
      lastSavedAt: freezed == lastSavedAt
          ? _value.lastSavedAt
          : lastSavedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasUnsavedChanges: null == hasUnsavedChanges
          ? _value.hasUnsavedChanges
          : hasUnsavedChanges // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {this.player = const Player(),
      this.isInitialized = false,
      this.tutorialCompleted = false,
      this.isFirstLaunch = false,
      this.isPaused = false,
      this.isOfflineMode = false,
      this.difficulty = GameDifficulty.normal,
      this.language = GameLanguage.japanese,
      this.achievementSystemEnabled = false,
      final List<String> completedAchievements = const [],
      final List<String> newAchievements = const [],
      this.dailyBattlesCompleted = 0,
      this.weeklyBattlesCompleted = 0,
      this.monthlyBattlesCompleted = 0,
      this.sessionBattles = 0,
      this.sessionVictories = 0,
      this.sessionExperienceGained = 0,
      final List<GameEvent> recentEvents = const [],
      this.lastSavedAt,
      this.hasUnsavedChanges = false})
      : _completedAchievements = completedAchievements,
        _newAchievements = newAchievements,
        _recentEvents = recentEvents;

// Player data
  @override
  @JsonKey()
  final Player player;
// Game initialization state
  @override
  @JsonKey()
  final bool isInitialized;
// Tutorial state
  @override
  @JsonKey()
  final bool tutorialCompleted;
// Game session state
  @override
  @JsonKey()
  final bool isFirstLaunch;
  @override
  @JsonKey()
  final bool isPaused;
  @override
  @JsonKey()
  final bool isOfflineMode;
// Game settings
  @override
  @JsonKey()
  final GameDifficulty difficulty;
  @override
  @JsonKey()
  final GameLanguage language;
// Achievement system state
  @override
  @JsonKey()
  final bool achievementSystemEnabled;
  final List<String> _completedAchievements;
  @override
  @JsonKey()
  List<String> get completedAchievements {
    if (_completedAchievements is EqualUnmodifiableListView)
      return _completedAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedAchievements);
  }

  final List<String> _newAchievements;
  @override
  @JsonKey()
  List<String> get newAchievements {
    if (_newAchievements is EqualUnmodifiableListView) return _newAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newAchievements);
  }

// Statistics tracking
  @override
  @JsonKey()
  final int dailyBattlesCompleted;
  @override
  @JsonKey()
  final int weeklyBattlesCompleted;
  @override
  @JsonKey()
  final int monthlyBattlesCompleted;
// Current session stats
  @override
  @JsonKey()
  final int sessionBattles;
  @override
  @JsonKey()
  final int sessionVictories;
  @override
  @JsonKey()
  final int sessionExperienceGained;
// Game events
  final List<GameEvent> _recentEvents;
// Game events
  @override
  @JsonKey()
  List<GameEvent> get recentEvents {
    if (_recentEvents is EqualUnmodifiableListView) return _recentEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentEvents);
  }

// Save data info
  @override
  final DateTime? lastSavedAt;
  @override
  @JsonKey()
  final bool hasUnsavedChanges;

  @override
  String toString() {
    return 'GameState(player: $player, isInitialized: $isInitialized, tutorialCompleted: $tutorialCompleted, isFirstLaunch: $isFirstLaunch, isPaused: $isPaused, isOfflineMode: $isOfflineMode, difficulty: $difficulty, language: $language, achievementSystemEnabled: $achievementSystemEnabled, completedAchievements: $completedAchievements, newAchievements: $newAchievements, dailyBattlesCompleted: $dailyBattlesCompleted, weeklyBattlesCompleted: $weeklyBattlesCompleted, monthlyBattlesCompleted: $monthlyBattlesCompleted, sessionBattles: $sessionBattles, sessionVictories: $sessionVictories, sessionExperienceGained: $sessionExperienceGained, recentEvents: $recentEvents, lastSavedAt: $lastSavedAt, hasUnsavedChanges: $hasUnsavedChanges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.tutorialCompleted, tutorialCompleted) ||
                other.tutorialCompleted == tutorialCompleted) &&
            (identical(other.isFirstLaunch, isFirstLaunch) ||
                other.isFirstLaunch == isFirstLaunch) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.isOfflineMode, isOfflineMode) ||
                other.isOfflineMode == isOfflineMode) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(
                    other.achievementSystemEnabled, achievementSystemEnabled) ||
                other.achievementSystemEnabled == achievementSystemEnabled) &&
            const DeepCollectionEquality()
                .equals(other._completedAchievements, _completedAchievements) &&
            const DeepCollectionEquality()
                .equals(other._newAchievements, _newAchievements) &&
            (identical(other.dailyBattlesCompleted, dailyBattlesCompleted) ||
                other.dailyBattlesCompleted == dailyBattlesCompleted) &&
            (identical(other.weeklyBattlesCompleted, weeklyBattlesCompleted) ||
                other.weeklyBattlesCompleted == weeklyBattlesCompleted) &&
            (identical(
                    other.monthlyBattlesCompleted, monthlyBattlesCompleted) ||
                other.monthlyBattlesCompleted == monthlyBattlesCompleted) &&
            (identical(other.sessionBattles, sessionBattles) ||
                other.sessionBattles == sessionBattles) &&
            (identical(other.sessionVictories, sessionVictories) ||
                other.sessionVictories == sessionVictories) &&
            (identical(
                    other.sessionExperienceGained, sessionExperienceGained) ||
                other.sessionExperienceGained == sessionExperienceGained) &&
            const DeepCollectionEquality()
                .equals(other._recentEvents, _recentEvents) &&
            (identical(other.lastSavedAt, lastSavedAt) ||
                other.lastSavedAt == lastSavedAt) &&
            (identical(other.hasUnsavedChanges, hasUnsavedChanges) ||
                other.hasUnsavedChanges == hasUnsavedChanges));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        player,
        isInitialized,
        tutorialCompleted,
        isFirstLaunch,
        isPaused,
        isOfflineMode,
        difficulty,
        language,
        achievementSystemEnabled,
        const DeepCollectionEquality().hash(_completedAchievements),
        const DeepCollectionEquality().hash(_newAchievements),
        dailyBattlesCompleted,
        weeklyBattlesCompleted,
        monthlyBattlesCompleted,
        sessionBattles,
        sessionVictories,
        sessionExperienceGained,
        const DeepCollectionEquality().hash(_recentEvents),
        lastSavedAt,
        hasUnsavedChanges
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final Player player,
      final bool isInitialized,
      final bool tutorialCompleted,
      final bool isFirstLaunch,
      final bool isPaused,
      final bool isOfflineMode,
      final GameDifficulty difficulty,
      final GameLanguage language,
      final bool achievementSystemEnabled,
      final List<String> completedAchievements,
      final List<String> newAchievements,
      final int dailyBattlesCompleted,
      final int weeklyBattlesCompleted,
      final int monthlyBattlesCompleted,
      final int sessionBattles,
      final int sessionVictories,
      final int sessionExperienceGained,
      final List<GameEvent> recentEvents,
      final DateTime? lastSavedAt,
      final bool hasUnsavedChanges}) = _$GameStateImpl;

  @override // Player data
  Player get player;
  @override // Game initialization state
  bool get isInitialized;
  @override // Tutorial state
  bool get tutorialCompleted;
  @override // Game session state
  bool get isFirstLaunch;
  @override
  bool get isPaused;
  @override
  bool get isOfflineMode;
  @override // Game settings
  GameDifficulty get difficulty;
  @override
  GameLanguage get language;
  @override // Achievement system state
  bool get achievementSystemEnabled;
  @override
  List<String> get completedAchievements;
  @override
  List<String> get newAchievements;
  @override // Statistics tracking
  int get dailyBattlesCompleted;
  @override
  int get weeklyBattlesCompleted;
  @override
  int get monthlyBattlesCompleted;
  @override // Current session stats
  int get sessionBattles;
  @override
  int get sessionVictories;
  @override
  int get sessionExperienceGained;
  @override // Game events
  List<GameEvent> get recentEvents;
  @override // Save data info
  DateTime? get lastSavedAt;
  @override
  bool get hasUnsavedChanges;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameEvent {
  String get id => throw _privateConstructorUsedError;
  GameEventType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameEventCopyWith<GameEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
  @useResult
  $Res call(
      {String id,
      GameEventType type,
      DateTime timestamp,
      String description,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? description = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameEventImplCopyWith<$Res>
    implements $GameEventCopyWith<$Res> {
  factory _$$GameEventImplCopyWith(
          _$GameEventImpl value, $Res Function(_$GameEventImpl) then) =
      __$$GameEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      GameEventType type,
      DateTime timestamp,
      String description,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$GameEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameEventImpl>
    implements _$$GameEventImplCopyWith<$Res> {
  __$$GameEventImplCopyWithImpl(
      _$GameEventImpl _value, $Res Function(_$GameEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? description = null,
    Object? data = freezed,
  }) {
    return _then(_$GameEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$GameEventImpl implements _GameEvent {
  const _$GameEventImpl(
      {required this.id,
      required this.type,
      required this.timestamp,
      required this.description,
      final Map<String, dynamic>? data})
      : _data = data;

  @override
  final String id;
  @override
  final GameEventType type;
  @override
  final DateTime timestamp;
  @override
  final String description;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'GameEvent(id: $id, type: $type, timestamp: $timestamp, description: $description, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, type, timestamp, description,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      __$$GameEventImplCopyWithImpl<_$GameEventImpl>(this, _$identity);
}

abstract class _GameEvent implements GameEvent {
  const factory _GameEvent(
      {required final String id,
      required final GameEventType type,
      required final DateTime timestamp,
      required final String description,
      final Map<String, dynamic>? data}) = _$GameEventImpl;

  @override
  String get id;
  @override
  GameEventType get type;
  @override
  DateTime get timestamp;
  @override
  String get description;
  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
