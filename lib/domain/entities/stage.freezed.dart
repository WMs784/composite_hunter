// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Stage {
  int get stageNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get enemyRangeMin => throw _privateConstructorUsedError;
  int get enemyRangeMax => throw _privateConstructorUsedError;
  int get timeLimit => throw _privateConstructorUsedError;
  StageClearCondition get clearCondition => throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;
  int get bestScore => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StageCopyWith<Stage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageCopyWith<$Res> {
  factory $StageCopyWith(Stage value, $Res Function(Stage) then) =
      _$StageCopyWithImpl<$Res, Stage>;
  @useResult
  $Res call(
      {int stageNumber,
      String title,
      String description,
      int enemyRangeMin,
      int enemyRangeMax,
      int timeLimit,
      StageClearCondition clearCondition,
      bool isUnlocked,
      bool isCompleted,
      int stars,
      int bestScore,
      DateTime? completedAt});

  $StageClearConditionCopyWith<$Res> get clearCondition;
}

/// @nodoc
class _$StageCopyWithImpl<$Res, $Val extends Stage>
    implements $StageCopyWith<$Res> {
  _$StageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageNumber = null,
    Object? title = null,
    Object? description = null,
    Object? enemyRangeMin = null,
    Object? enemyRangeMax = null,
    Object? timeLimit = null,
    Object? clearCondition = null,
    Object? isUnlocked = null,
    Object? isCompleted = null,
    Object? stars = null,
    Object? bestScore = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      stageNumber: null == stageNumber
          ? _value.stageNumber
          : stageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enemyRangeMin: null == enemyRangeMin
          ? _value.enemyRangeMin
          : enemyRangeMin // ignore: cast_nullable_to_non_nullable
              as int,
      enemyRangeMax: null == enemyRangeMax
          ? _value.enemyRangeMax
          : enemyRangeMax // ignore: cast_nullable_to_non_nullable
              as int,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      clearCondition: null == clearCondition
          ? _value.clearCondition
          : clearCondition // ignore: cast_nullable_to_non_nullable
              as StageClearCondition,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StageClearConditionCopyWith<$Res> get clearCondition {
    return $StageClearConditionCopyWith<$Res>(_value.clearCondition, (value) {
      return _then(_value.copyWith(clearCondition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StageImplCopyWith<$Res> implements $StageCopyWith<$Res> {
  factory _$$StageImplCopyWith(
          _$StageImpl value, $Res Function(_$StageImpl) then) =
      __$$StageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int stageNumber,
      String title,
      String description,
      int enemyRangeMin,
      int enemyRangeMax,
      int timeLimit,
      StageClearCondition clearCondition,
      bool isUnlocked,
      bool isCompleted,
      int stars,
      int bestScore,
      DateTime? completedAt});

  @override
  $StageClearConditionCopyWith<$Res> get clearCondition;
}

/// @nodoc
class __$$StageImplCopyWithImpl<$Res>
    extends _$StageCopyWithImpl<$Res, _$StageImpl>
    implements _$$StageImplCopyWith<$Res> {
  __$$StageImplCopyWithImpl(
      _$StageImpl _value, $Res Function(_$StageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageNumber = null,
    Object? title = null,
    Object? description = null,
    Object? enemyRangeMin = null,
    Object? enemyRangeMax = null,
    Object? timeLimit = null,
    Object? clearCondition = null,
    Object? isUnlocked = null,
    Object? isCompleted = null,
    Object? stars = null,
    Object? bestScore = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$StageImpl(
      stageNumber: null == stageNumber
          ? _value.stageNumber
          : stageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enemyRangeMin: null == enemyRangeMin
          ? _value.enemyRangeMin
          : enemyRangeMin // ignore: cast_nullable_to_non_nullable
              as int,
      enemyRangeMax: null == enemyRangeMax
          ? _value.enemyRangeMax
          : enemyRangeMax // ignore: cast_nullable_to_non_nullable
              as int,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      clearCondition: null == clearCondition
          ? _value.clearCondition
          : clearCondition // ignore: cast_nullable_to_non_nullable
              as StageClearCondition,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StageImpl implements _Stage {
  const _$StageImpl(
      {required this.stageNumber,
      required this.title,
      required this.description,
      required this.enemyRangeMin,
      required this.enemyRangeMax,
      required this.timeLimit,
      required this.clearCondition,
      required this.isUnlocked,
      required this.isCompleted,
      required this.stars,
      required this.bestScore,
      required this.completedAt});

  @override
  final int stageNumber;
  @override
  final String title;
  @override
  final String description;
  @override
  final int enemyRangeMin;
  @override
  final int enemyRangeMax;
  @override
  final int timeLimit;
  @override
  final StageClearCondition clearCondition;
  @override
  final bool isUnlocked;
  @override
  final bool isCompleted;
  @override
  final int stars;
  @override
  final int bestScore;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'Stage(stageNumber: $stageNumber, title: $title, description: $description, enemyRangeMin: $enemyRangeMin, enemyRangeMax: $enemyRangeMax, timeLimit: $timeLimit, clearCondition: $clearCondition, isUnlocked: $isUnlocked, isCompleted: $isCompleted, stars: $stars, bestScore: $bestScore, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageImpl &&
            (identical(other.stageNumber, stageNumber) ||
                other.stageNumber == stageNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.enemyRangeMin, enemyRangeMin) ||
                other.enemyRangeMin == enemyRangeMin) &&
            (identical(other.enemyRangeMax, enemyRangeMax) ||
                other.enemyRangeMax == enemyRangeMax) &&
            (identical(other.timeLimit, timeLimit) ||
                other.timeLimit == timeLimit) &&
            (identical(other.clearCondition, clearCondition) ||
                other.clearCondition == clearCondition) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.bestScore, bestScore) ||
                other.bestScore == bestScore) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      stageNumber,
      title,
      description,
      enemyRangeMin,
      enemyRangeMax,
      timeLimit,
      clearCondition,
      isUnlocked,
      isCompleted,
      stars,
      bestScore,
      completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StageImplCopyWith<_$StageImpl> get copyWith =>
      __$$StageImplCopyWithImpl<_$StageImpl>(this, _$identity);
}

abstract class _Stage implements Stage {
  const factory _Stage(
      {required final int stageNumber,
      required final String title,
      required final String description,
      required final int enemyRangeMin,
      required final int enemyRangeMax,
      required final int timeLimit,
      required final StageClearCondition clearCondition,
      required final bool isUnlocked,
      required final bool isCompleted,
      required final int stars,
      required final int bestScore,
      required final DateTime? completedAt}) = _$StageImpl;

  @override
  int get stageNumber;
  @override
  String get title;
  @override
  String get description;
  @override
  int get enemyRangeMin;
  @override
  int get enemyRangeMax;
  @override
  int get timeLimit;
  @override
  StageClearCondition get clearCondition;
  @override
  bool get isUnlocked;
  @override
  bool get isCompleted;
  @override
  int get stars;
  @override
  int get bestScore;
  @override
  DateTime? get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$StageImplCopyWith<_$StageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StageClearCondition {
  int get requiredVictories => throw _privateConstructorUsedError; // 必要勝利数
  int get timeLimit => throw _privateConstructorUsedError; // 制限時間（秒）
  int get maxEscapes => throw _privateConstructorUsedError; // 最大逃走回数
  int get maxWrongClaims => throw _privateConstructorUsedError; // 最大誤判定回数
  StageClearType get clearType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StageClearConditionCopyWith<StageClearCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageClearConditionCopyWith<$Res> {
  factory $StageClearConditionCopyWith(
          StageClearCondition value, $Res Function(StageClearCondition) then) =
      _$StageClearConditionCopyWithImpl<$Res, StageClearCondition>;
  @useResult
  $Res call(
      {int requiredVictories,
      int timeLimit,
      int maxEscapes,
      int maxWrongClaims,
      StageClearType clearType});
}

/// @nodoc
class _$StageClearConditionCopyWithImpl<$Res, $Val extends StageClearCondition>
    implements $StageClearConditionCopyWith<$Res> {
  _$StageClearConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiredVictories = null,
    Object? timeLimit = null,
    Object? maxEscapes = null,
    Object? maxWrongClaims = null,
    Object? clearType = null,
  }) {
    return _then(_value.copyWith(
      requiredVictories: null == requiredVictories
          ? _value.requiredVictories
          : requiredVictories // ignore: cast_nullable_to_non_nullable
              as int,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      maxEscapes: null == maxEscapes
          ? _value.maxEscapes
          : maxEscapes // ignore: cast_nullable_to_non_nullable
              as int,
      maxWrongClaims: null == maxWrongClaims
          ? _value.maxWrongClaims
          : maxWrongClaims // ignore: cast_nullable_to_non_nullable
              as int,
      clearType: null == clearType
          ? _value.clearType
          : clearType // ignore: cast_nullable_to_non_nullable
              as StageClearType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StageClearConditionImplCopyWith<$Res>
    implements $StageClearConditionCopyWith<$Res> {
  factory _$$StageClearConditionImplCopyWith(_$StageClearConditionImpl value,
          $Res Function(_$StageClearConditionImpl) then) =
      __$$StageClearConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int requiredVictories,
      int timeLimit,
      int maxEscapes,
      int maxWrongClaims,
      StageClearType clearType});
}

/// @nodoc
class __$$StageClearConditionImplCopyWithImpl<$Res>
    extends _$StageClearConditionCopyWithImpl<$Res, _$StageClearConditionImpl>
    implements _$$StageClearConditionImplCopyWith<$Res> {
  __$$StageClearConditionImplCopyWithImpl(_$StageClearConditionImpl _value,
      $Res Function(_$StageClearConditionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiredVictories = null,
    Object? timeLimit = null,
    Object? maxEscapes = null,
    Object? maxWrongClaims = null,
    Object? clearType = null,
  }) {
    return _then(_$StageClearConditionImpl(
      requiredVictories: null == requiredVictories
          ? _value.requiredVictories
          : requiredVictories // ignore: cast_nullable_to_non_nullable
              as int,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      maxEscapes: null == maxEscapes
          ? _value.maxEscapes
          : maxEscapes // ignore: cast_nullable_to_non_nullable
              as int,
      maxWrongClaims: null == maxWrongClaims
          ? _value.maxWrongClaims
          : maxWrongClaims // ignore: cast_nullable_to_non_nullable
              as int,
      clearType: null == clearType
          ? _value.clearType
          : clearType // ignore: cast_nullable_to_non_nullable
              as StageClearType,
    ));
  }
}

/// @nodoc

class _$StageClearConditionImpl implements _StageClearCondition {
  const _$StageClearConditionImpl(
      {required this.requiredVictories,
      required this.timeLimit,
      required this.maxEscapes,
      required this.maxWrongClaims,
      required this.clearType});

  @override
  final int requiredVictories;
// 必要勝利数
  @override
  final int timeLimit;
// 制限時間（秒）
  @override
  final int maxEscapes;
// 最大逃走回数
  @override
  final int maxWrongClaims;
// 最大誤判定回数
  @override
  final StageClearType clearType;

  @override
  String toString() {
    return 'StageClearCondition(requiredVictories: $requiredVictories, timeLimit: $timeLimit, maxEscapes: $maxEscapes, maxWrongClaims: $maxWrongClaims, clearType: $clearType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageClearConditionImpl &&
            (identical(other.requiredVictories, requiredVictories) ||
                other.requiredVictories == requiredVictories) &&
            (identical(other.timeLimit, timeLimit) ||
                other.timeLimit == timeLimit) &&
            (identical(other.maxEscapes, maxEscapes) ||
                other.maxEscapes == maxEscapes) &&
            (identical(other.maxWrongClaims, maxWrongClaims) ||
                other.maxWrongClaims == maxWrongClaims) &&
            (identical(other.clearType, clearType) ||
                other.clearType == clearType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requiredVictories, timeLimit,
      maxEscapes, maxWrongClaims, clearType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StageClearConditionImplCopyWith<_$StageClearConditionImpl> get copyWith =>
      __$$StageClearConditionImplCopyWithImpl<_$StageClearConditionImpl>(
          this, _$identity);
}

abstract class _StageClearCondition implements StageClearCondition {
  const factory _StageClearCondition(
      {required final int requiredVictories,
      required final int timeLimit,
      required final int maxEscapes,
      required final int maxWrongClaims,
      required final StageClearType clearType}) = _$StageClearConditionImpl;

  @override
  int get requiredVictories;
  @override // 必要勝利数
  int get timeLimit;
  @override // 制限時間（秒）
  int get maxEscapes;
  @override // 最大逃走回数
  int get maxWrongClaims;
  @override // 最大誤判定回数
  StageClearType get clearType;
  @override
  @JsonKey(ignore: true)
  _$$StageClearConditionImplCopyWith<_$StageClearConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StageClearResult {
  int get stageNumber => throw _privateConstructorUsedError;
  bool get isCleared => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get victories => throw _privateConstructorUsedError;
  int get escapes => throw _privateConstructorUsedError;
  int get wrongClaims => throw _privateConstructorUsedError;
  Duration get totalTime => throw _privateConstructorUsedError;
  List<int> get defeatedEnemies => throw _privateConstructorUsedError;
  bool get isPerfect => throw _privateConstructorUsedError;
  bool get isNewRecord => throw _privateConstructorUsedError;
  List<int> get rewardItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StageClearResultCopyWith<StageClearResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageClearResultCopyWith<$Res> {
  factory $StageClearResultCopyWith(
          StageClearResult value, $Res Function(StageClearResult) then) =
      _$StageClearResultCopyWithImpl<$Res, StageClearResult>;
  @useResult
  $Res call(
      {int stageNumber,
      bool isCleared,
      int stars,
      int score,
      int victories,
      int escapes,
      int wrongClaims,
      Duration totalTime,
      List<int> defeatedEnemies,
      bool isPerfect,
      bool isNewRecord,
      List<int> rewardItems});
}

/// @nodoc
class _$StageClearResultCopyWithImpl<$Res, $Val extends StageClearResult>
    implements $StageClearResultCopyWith<$Res> {
  _$StageClearResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageNumber = null,
    Object? isCleared = null,
    Object? stars = null,
    Object? score = null,
    Object? victories = null,
    Object? escapes = null,
    Object? wrongClaims = null,
    Object? totalTime = null,
    Object? defeatedEnemies = null,
    Object? isPerfect = null,
    Object? isNewRecord = null,
    Object? rewardItems = null,
  }) {
    return _then(_value.copyWith(
      stageNumber: null == stageNumber
          ? _value.stageNumber
          : stageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isCleared: null == isCleared
          ? _value.isCleared
          : isCleared // ignore: cast_nullable_to_non_nullable
              as bool,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      victories: null == victories
          ? _value.victories
          : victories // ignore: cast_nullable_to_non_nullable
              as int,
      escapes: null == escapes
          ? _value.escapes
          : escapes // ignore: cast_nullable_to_non_nullable
              as int,
      wrongClaims: null == wrongClaims
          ? _value.wrongClaims
          : wrongClaims // ignore: cast_nullable_to_non_nullable
              as int,
      totalTime: null == totalTime
          ? _value.totalTime
          : totalTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      defeatedEnemies: null == defeatedEnemies
          ? _value.defeatedEnemies
          : defeatedEnemies // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isPerfect: null == isPerfect
          ? _value.isPerfect
          : isPerfect // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewRecord: null == isNewRecord
          ? _value.isNewRecord
          : isNewRecord // ignore: cast_nullable_to_non_nullable
              as bool,
      rewardItems: null == rewardItems
          ? _value.rewardItems
          : rewardItems // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StageClearResultImplCopyWith<$Res>
    implements $StageClearResultCopyWith<$Res> {
  factory _$$StageClearResultImplCopyWith(_$StageClearResultImpl value,
          $Res Function(_$StageClearResultImpl) then) =
      __$$StageClearResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int stageNumber,
      bool isCleared,
      int stars,
      int score,
      int victories,
      int escapes,
      int wrongClaims,
      Duration totalTime,
      List<int> defeatedEnemies,
      bool isPerfect,
      bool isNewRecord,
      List<int> rewardItems});
}

/// @nodoc
class __$$StageClearResultImplCopyWithImpl<$Res>
    extends _$StageClearResultCopyWithImpl<$Res, _$StageClearResultImpl>
    implements _$$StageClearResultImplCopyWith<$Res> {
  __$$StageClearResultImplCopyWithImpl(_$StageClearResultImpl _value,
      $Res Function(_$StageClearResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageNumber = null,
    Object? isCleared = null,
    Object? stars = null,
    Object? score = null,
    Object? victories = null,
    Object? escapes = null,
    Object? wrongClaims = null,
    Object? totalTime = null,
    Object? defeatedEnemies = null,
    Object? isPerfect = null,
    Object? isNewRecord = null,
    Object? rewardItems = null,
  }) {
    return _then(_$StageClearResultImpl(
      stageNumber: null == stageNumber
          ? _value.stageNumber
          : stageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isCleared: null == isCleared
          ? _value.isCleared
          : isCleared // ignore: cast_nullable_to_non_nullable
              as bool,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      victories: null == victories
          ? _value.victories
          : victories // ignore: cast_nullable_to_non_nullable
              as int,
      escapes: null == escapes
          ? _value.escapes
          : escapes // ignore: cast_nullable_to_non_nullable
              as int,
      wrongClaims: null == wrongClaims
          ? _value.wrongClaims
          : wrongClaims // ignore: cast_nullable_to_non_nullable
              as int,
      totalTime: null == totalTime
          ? _value.totalTime
          : totalTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      defeatedEnemies: null == defeatedEnemies
          ? _value._defeatedEnemies
          : defeatedEnemies // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isPerfect: null == isPerfect
          ? _value.isPerfect
          : isPerfect // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewRecord: null == isNewRecord
          ? _value.isNewRecord
          : isNewRecord // ignore: cast_nullable_to_non_nullable
              as bool,
      rewardItems: null == rewardItems
          ? _value._rewardItems
          : rewardItems // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$StageClearResultImpl implements _StageClearResult {
  const _$StageClearResultImpl(
      {required this.stageNumber,
      required this.isCleared,
      required this.stars,
      required this.score,
      required this.victories,
      required this.escapes,
      required this.wrongClaims,
      required this.totalTime,
      required final List<int> defeatedEnemies,
      required this.isPerfect,
      required this.isNewRecord,
      final List<int> rewardItems = const []})
      : _defeatedEnemies = defeatedEnemies,
        _rewardItems = rewardItems;

  @override
  final int stageNumber;
  @override
  final bool isCleared;
  @override
  final int stars;
  @override
  final int score;
  @override
  final int victories;
  @override
  final int escapes;
  @override
  final int wrongClaims;
  @override
  final Duration totalTime;
  final List<int> _defeatedEnemies;
  @override
  List<int> get defeatedEnemies {
    if (_defeatedEnemies is EqualUnmodifiableListView) return _defeatedEnemies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_defeatedEnemies);
  }

  @override
  final bool isPerfect;
  @override
  final bool isNewRecord;
  final List<int> _rewardItems;
  @override
  @JsonKey()
  List<int> get rewardItems {
    if (_rewardItems is EqualUnmodifiableListView) return _rewardItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rewardItems);
  }

  @override
  String toString() {
    return 'StageClearResult(stageNumber: $stageNumber, isCleared: $isCleared, stars: $stars, score: $score, victories: $victories, escapes: $escapes, wrongClaims: $wrongClaims, totalTime: $totalTime, defeatedEnemies: $defeatedEnemies, isPerfect: $isPerfect, isNewRecord: $isNewRecord, rewardItems: $rewardItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageClearResultImpl &&
            (identical(other.stageNumber, stageNumber) ||
                other.stageNumber == stageNumber) &&
            (identical(other.isCleared, isCleared) ||
                other.isCleared == isCleared) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.victories, victories) ||
                other.victories == victories) &&
            (identical(other.escapes, escapes) || other.escapes == escapes) &&
            (identical(other.wrongClaims, wrongClaims) ||
                other.wrongClaims == wrongClaims) &&
            (identical(other.totalTime, totalTime) ||
                other.totalTime == totalTime) &&
            const DeepCollectionEquality()
                .equals(other._defeatedEnemies, _defeatedEnemies) &&
            (identical(other.isPerfect, isPerfect) ||
                other.isPerfect == isPerfect) &&
            (identical(other.isNewRecord, isNewRecord) ||
                other.isNewRecord == isNewRecord) &&
            const DeepCollectionEquality()
                .equals(other._rewardItems, _rewardItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      stageNumber,
      isCleared,
      stars,
      score,
      victories,
      escapes,
      wrongClaims,
      totalTime,
      const DeepCollectionEquality().hash(_defeatedEnemies),
      isPerfect,
      isNewRecord,
      const DeepCollectionEquality().hash(_rewardItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StageClearResultImplCopyWith<_$StageClearResultImpl> get copyWith =>
      __$$StageClearResultImplCopyWithImpl<_$StageClearResultImpl>(
          this, _$identity);
}

abstract class _StageClearResult implements StageClearResult {
  const factory _StageClearResult(
      {required final int stageNumber,
      required final bool isCleared,
      required final int stars,
      required final int score,
      required final int victories,
      required final int escapes,
      required final int wrongClaims,
      required final Duration totalTime,
      required final List<int> defeatedEnemies,
      required final bool isPerfect,
      required final bool isNewRecord,
      final List<int> rewardItems}) = _$StageClearResultImpl;

  @override
  int get stageNumber;
  @override
  bool get isCleared;
  @override
  int get stars;
  @override
  int get score;
  @override
  int get victories;
  @override
  int get escapes;
  @override
  int get wrongClaims;
  @override
  Duration get totalTime;
  @override
  List<int> get defeatedEnemies;
  @override
  bool get isPerfect;
  @override
  bool get isNewRecord;
  @override
  List<int> get rewardItems;
  @override
  @JsonKey(ignore: true)
  _$$StageClearResultImplCopyWith<_$StageClearResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
