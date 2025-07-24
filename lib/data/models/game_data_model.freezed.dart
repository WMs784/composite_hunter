// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameDataModel _$GameDataModelFromJson(Map<String, dynamic> json) {
  return _GameDataModel.fromJson(json);
}

/// @nodoc
mixin _$GameDataModel {
  int get playerLevel => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  int get totalBattles => throw _privateConstructorUsedError;
  int get totalVictories => throw _privateConstructorUsedError;
  int get totalEscapes => throw _privateConstructorUsedError;
  int get totalTimeOuts => throw _privateConstructorUsedError;
  int get totalPowerEnemiesDefeated => throw _privateConstructorUsedError;
  List<PrimeModel> get inventory => throw _privateConstructorUsedError;
  List<BattleResultModel> get battleHistory =>
      throw _privateConstructorUsedError;
  bool get tutorialCompleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastPlayedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameDataModelCopyWith<GameDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDataModelCopyWith<$Res> {
  factory $GameDataModelCopyWith(
    GameDataModel value,
    $Res Function(GameDataModel) then,
  ) = _$GameDataModelCopyWithImpl<$Res, GameDataModel>;
  @useResult
  $Res call({
    int playerLevel,
    int experience,
    int totalBattles,
    int totalVictories,
    int totalEscapes,
    int totalTimeOuts,
    int totalPowerEnemiesDefeated,
    List<PrimeModel> inventory,
    List<BattleResultModel> battleHistory,
    bool tutorialCompleted,
    DateTime createdAt,
    DateTime lastPlayedAt,
  });
}

/// @nodoc
class _$GameDataModelCopyWithImpl<$Res, $Val extends GameDataModel>
    implements $GameDataModelCopyWith<$Res> {
  _$GameDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerLevel = null,
    Object? experience = null,
    Object? totalBattles = null,
    Object? totalVictories = null,
    Object? totalEscapes = null,
    Object? totalTimeOuts = null,
    Object? totalPowerEnemiesDefeated = null,
    Object? inventory = null,
    Object? battleHistory = null,
    Object? tutorialCompleted = null,
    Object? createdAt = null,
    Object? lastPlayedAt = null,
  }) {
    return _then(
      _value.copyWith(
            playerLevel: null == playerLevel
                ? _value.playerLevel
                : playerLevel // ignore: cast_nullable_to_non_nullable
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
            inventory: null == inventory
                ? _value.inventory
                : inventory // ignore: cast_nullable_to_non_nullable
                      as List<PrimeModel>,
            battleHistory: null == battleHistory
                ? _value.battleHistory
                : battleHistory // ignore: cast_nullable_to_non_nullable
                      as List<BattleResultModel>,
            tutorialCompleted: null == tutorialCompleted
                ? _value.tutorialCompleted
                : tutorialCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastPlayedAt: null == lastPlayedAt
                ? _value.lastPlayedAt
                : lastPlayedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameDataModelImplCopyWith<$Res>
    implements $GameDataModelCopyWith<$Res> {
  factory _$$GameDataModelImplCopyWith(
    _$GameDataModelImpl value,
    $Res Function(_$GameDataModelImpl) then,
  ) = _$$GameDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int playerLevel,
    int experience,
    int totalBattles,
    int totalVictories,
    int totalEscapes,
    int totalTimeOuts,
    int totalPowerEnemiesDefeated,
    List<PrimeModel> inventory,
    List<BattleResultModel> battleHistory,
    bool tutorialCompleted,
    DateTime createdAt,
    DateTime lastPlayedAt,
  });
}

/// @nodoc
class _$$GameDataModelImplCopyWithImpl<$Res>
    extends _$GameDataModelCopyWithImpl<$Res, _$GameDataModelImpl>
    implements _$$GameDataModelImplCopyWith<$Res> {
  _$$GameDataModelImplCopyWithImpl(
    _$GameDataModelImpl _value,
    $Res Function(_$GameDataModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerLevel = null,
    Object? experience = null,
    Object? totalBattles = null,
    Object? totalVictories = null,
    Object? totalEscapes = null,
    Object? totalTimeOuts = null,
    Object? totalPowerEnemiesDefeated = null,
    Object? inventory = null,
    Object? battleHistory = null,
    Object? tutorialCompleted = null,
    Object? createdAt = null,
    Object? lastPlayedAt = null,
  }) {
    return _then(
      _$GameDataModelImpl(
        playerLevel: null == playerLevel
            ? _value.playerLevel
            : playerLevel // ignore: cast_nullable_to_non_nullable
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
        inventory: null == inventory
            ? _value._inventory
            : inventory // ignore: cast_nullable_to_non_nullable
                  as List<PrimeModel>,
        battleHistory: null == battleHistory
            ? _value._battleHistory
            : battleHistory // ignore: cast_nullable_to_non_nullable
                  as List<BattleResultModel>,
        tutorialCompleted: null == tutorialCompleted
            ? _value.tutorialCompleted
            : tutorialCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastPlayedAt: null == lastPlayedAt
            ? _value.lastPlayedAt
            : lastPlayedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameDataModelImpl implements _GameDataModel {
  const _$GameDataModelImpl({
    this.playerLevel = 1,
    this.experience = 0,
    this.totalBattles = 0,
    this.totalVictories = 0,
    this.totalEscapes = 0,
    this.totalTimeOuts = 0,
    this.totalPowerEnemiesDefeated = 0,
    final List<PrimeModel> inventory = const [],
    final List<BattleResultModel> battleHistory = const [],
    this.tutorialCompleted = false,
    required this.createdAt,
    required this.lastPlayedAt,
  }) : _inventory = inventory,
       _battleHistory = battleHistory;

  factory _$GameDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameDataModelImplFromJson(json);

  @override
  @JsonKey()
  final int playerLevel;
  @override
  @JsonKey()
  final int experience;
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
  final List<PrimeModel> _inventory;
  @override
  @JsonKey()
  List<PrimeModel> get inventory {
    if (_inventory is EqualUnmodifiableListView) return _inventory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inventory);
  }

  final List<BattleResultModel> _battleHistory;
  @override
  @JsonKey()
  List<BattleResultModel> get battleHistory {
    if (_battleHistory is EqualUnmodifiableListView) return _battleHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_battleHistory);
  }

  @override
  @JsonKey()
  final bool tutorialCompleted;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastPlayedAt;

  @override
  String toString() {
    return 'GameDataModel(playerLevel: $playerLevel, experience: $experience, totalBattles: $totalBattles, totalVictories: $totalVictories, totalEscapes: $totalEscapes, totalTimeOuts: $totalTimeOuts, totalPowerEnemiesDefeated: $totalPowerEnemiesDefeated, inventory: $inventory, battleHistory: $battleHistory, tutorialCompleted: $tutorialCompleted, createdAt: $createdAt, lastPlayedAt: $lastPlayedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameDataModelImpl &&
            (identical(other.playerLevel, playerLevel) ||
                other.playerLevel == playerLevel) &&
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
            (identical(
                  other.totalPowerEnemiesDefeated,
                  totalPowerEnemiesDefeated,
                ) ||
                other.totalPowerEnemiesDefeated == totalPowerEnemiesDefeated) &&
            const DeepCollectionEquality().equals(
              other._inventory,
              _inventory,
            ) &&
            const DeepCollectionEquality().equals(
              other._battleHistory,
              _battleHistory,
            ) &&
            (identical(other.tutorialCompleted, tutorialCompleted) ||
                other.tutorialCompleted == tutorialCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastPlayedAt, lastPlayedAt) ||
                other.lastPlayedAt == lastPlayedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    playerLevel,
    experience,
    totalBattles,
    totalVictories,
    totalEscapes,
    totalTimeOuts,
    totalPowerEnemiesDefeated,
    const DeepCollectionEquality().hash(_inventory),
    const DeepCollectionEquality().hash(_battleHistory),
    tutorialCompleted,
    createdAt,
    lastPlayedAt,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameDataModelImplCopyWith<_$GameDataModelImpl> get copyWith =>
      _$$GameDataModelImplCopyWithImpl<_$GameDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameDataModelImplToJson(this);
  }
}

abstract class _GameDataModel implements GameDataModel {
  const factory _GameDataModel({
    final int playerLevel,
    final int experience,
    final int totalBattles,
    final int totalVictories,
    final int totalEscapes,
    final int totalTimeOuts,
    final int totalPowerEnemiesDefeated,
    final List<PrimeModel> inventory,
    final List<BattleResultModel> battleHistory,
    final bool tutorialCompleted,
    required final DateTime createdAt,
    required final DateTime lastPlayedAt,
  }) = _$GameDataModelImpl;

  factory _GameDataModel.fromJson(Map<String, dynamic> json) =
      _$GameDataModelImpl.fromJson;

  @override
  int get playerLevel;
  @override
  int get experience;
  @override
  int get totalBattles;
  @override
  int get totalVictories;
  @override
  int get totalEscapes;
  @override
  int get totalTimeOuts;
  @override
  int get totalPowerEnemiesDefeated;
  @override
  List<PrimeModel> get inventory;
  @override
  List<BattleResultModel> get battleHistory;
  @override
  bool get tutorialCompleted;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastPlayedAt;
  @override
  @JsonKey(ignore: true)
  _$$GameDataModelImplCopyWith<_$GameDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
