// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BattleResultModel _$BattleResultModelFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'victory':
      return _Victory.fromJson(json);
    case 'powerVictory':
      return _PowerVictory.fromJson(json);
    case 'continue_':
      return _Continue.fromJson(json);
    case 'awaitingVictoryClaim':
      return _AwaitingVictoryClaim.fromJson(json);
    case 'wrongClaim':
      return _WrongClaim.fromJson(json);
    case 'escape':
      return _Escape.fromJson(json);
    case 'timeOut':
      return _TimeOut.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'BattleResultModel',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$BattleResultModel {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleResultModelCopyWith<$Res> {
  factory $BattleResultModelCopyWith(
    BattleResultModel value,
    $Res Function(BattleResultModel) then,
  ) = _$BattleResultModelCopyWithImpl<$Res, BattleResultModel>;
}

/// @nodoc
class _$BattleResultModelCopyWithImpl<$Res, $Val extends BattleResultModel>
    implements $BattleResultModelCopyWith<$Res> {
  _$BattleResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VictoryImplCopyWith<$Res> {
  factory _$$VictoryImplCopyWith(
    _$VictoryImpl value,
    $Res Function(_$VictoryImpl) then,
  ) = _$$VictoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    EnemyModel defeatedEnemy,
    int rewardPrime,
    DateTime completedAt,
    int battleDuration,
  });

  $EnemyModelCopyWith<$Res> get defeatedEnemy;
}

/// @nodoc
class _$$VictoryImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$VictoryImpl>
    implements _$$VictoryImplCopyWith<$Res> {
  _$$VictoryImplCopyWithImpl(
    _$VictoryImpl _value,
    $Res Function(_$VictoryImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defeatedEnemy = null,
    Object? rewardPrime = null,
    Object? completedAt = null,
    Object? battleDuration = null,
  }) {
    return _then(
      _$VictoryImpl(
        defeatedEnemy: null == defeatedEnemy
            ? _value.defeatedEnemy
            : defeatedEnemy // ignore: cast_nullable_to_non_nullable
                  as EnemyModel,
        rewardPrime: null == rewardPrime
            ? _value.rewardPrime
            : rewardPrime // ignore: cast_nullable_to_non_nullable
                  as int,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        battleDuration: null == battleDuration
            ? _value.battleDuration
            : battleDuration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyModelCopyWith<$Res> get defeatedEnemy {
    return $EnemyModelCopyWith<$Res>(_value.defeatedEnemy, (value) {
      return _then(_value.copyWith(defeatedEnemy: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$VictoryImpl implements _Victory {
  const _$VictoryImpl({
    required this.defeatedEnemy,
    required this.rewardPrime,
    required this.completedAt,
    required this.battleDuration,
    final String? $type,
  }) : $type = $type ?? 'victory';

  factory _$VictoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$VictoryImplFromJson(json);

  @override
  final EnemyModel defeatedEnemy;
  @override
  final int rewardPrime;
  @override
  final DateTime completedAt;
  @override
  final int battleDuration;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.victory(defeatedEnemy: $defeatedEnemy, rewardPrime: $rewardPrime, completedAt: $completedAt, battleDuration: $battleDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VictoryImpl &&
            (identical(other.defeatedEnemy, defeatedEnemy) ||
                other.defeatedEnemy == defeatedEnemy) &&
            (identical(other.rewardPrime, rewardPrime) ||
                other.rewardPrime == rewardPrime) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.battleDuration, battleDuration) ||
                other.battleDuration == battleDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    defeatedEnemy,
    rewardPrime,
    completedAt,
    battleDuration,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VictoryImplCopyWith<_$VictoryImpl> get copyWith =>
      _$$VictoryImplCopyWithImpl<_$VictoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return victory(defeatedEnemy, rewardPrime, completedAt, battleDuration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return victory?.call(
      defeatedEnemy,
      rewardPrime,
      completedAt,
      battleDuration,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (victory != null) {
      return victory(defeatedEnemy, rewardPrime, completedAt, battleDuration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return victory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return victory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (victory != null) {
      return victory(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VictoryImplToJson(this);
  }
}

abstract class _Victory implements BattleResultModel {
  const factory _Victory({
    required final EnemyModel defeatedEnemy,
    required final int rewardPrime,
    required final DateTime completedAt,
    required final int battleDuration,
  }) = _$VictoryImpl;

  factory _Victory.fromJson(Map<String, dynamic> json) = _$VictoryImpl.fromJson;

  EnemyModel get defeatedEnemy;
  int get rewardPrime;
  DateTime get completedAt;
  int get battleDuration;
  @JsonKey(ignore: true)
  _$$VictoryImplCopyWith<_$VictoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PowerVictoryImplCopyWith<$Res> {
  factory _$$PowerVictoryImplCopyWith(
    _$PowerVictoryImpl value,
    $Res Function(_$PowerVictoryImpl) then,
  ) = _$$PowerVictoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    EnemyModel defeatedEnemy,
    int rewardPrime,
    int rewardCount,
    DateTime completedAt,
    int battleDuration,
  });

  $EnemyModelCopyWith<$Res> get defeatedEnemy;
}

/// @nodoc
class _$$PowerVictoryImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$PowerVictoryImpl>
    implements _$$PowerVictoryImplCopyWith<$Res> {
  _$$PowerVictoryImplCopyWithImpl(
    _$PowerVictoryImpl _value,
    $Res Function(_$PowerVictoryImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defeatedEnemy = null,
    Object? rewardPrime = null,
    Object? rewardCount = null,
    Object? completedAt = null,
    Object? battleDuration = null,
  }) {
    return _then(
      _$PowerVictoryImpl(
        defeatedEnemy: null == defeatedEnemy
            ? _value.defeatedEnemy
            : defeatedEnemy // ignore: cast_nullable_to_non_nullable
                  as EnemyModel,
        rewardPrime: null == rewardPrime
            ? _value.rewardPrime
            : rewardPrime // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardCount: null == rewardCount
            ? _value.rewardCount
            : rewardCount // ignore: cast_nullable_to_non_nullable
                  as int,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        battleDuration: null == battleDuration
            ? _value.battleDuration
            : battleDuration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyModelCopyWith<$Res> get defeatedEnemy {
    return $EnemyModelCopyWith<$Res>(_value.defeatedEnemy, (value) {
      return _then(_value.copyWith(defeatedEnemy: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PowerVictoryImpl implements _PowerVictory {
  const _$PowerVictoryImpl({
    required this.defeatedEnemy,
    required this.rewardPrime,
    required this.rewardCount,
    required this.completedAt,
    required this.battleDuration,
    final String? $type,
  }) : $type = $type ?? 'powerVictory';

  factory _$PowerVictoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PowerVictoryImplFromJson(json);

  @override
  final EnemyModel defeatedEnemy;
  @override
  final int rewardPrime;
  @override
  final int rewardCount;
  @override
  final DateTime completedAt;
  @override
  final int battleDuration;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.powerVictory(defeatedEnemy: $defeatedEnemy, rewardPrime: $rewardPrime, rewardCount: $rewardCount, completedAt: $completedAt, battleDuration: $battleDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PowerVictoryImpl &&
            (identical(other.defeatedEnemy, defeatedEnemy) ||
                other.defeatedEnemy == defeatedEnemy) &&
            (identical(other.rewardPrime, rewardPrime) ||
                other.rewardPrime == rewardPrime) &&
            (identical(other.rewardCount, rewardCount) ||
                other.rewardCount == rewardCount) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.battleDuration, battleDuration) ||
                other.battleDuration == battleDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    defeatedEnemy,
    rewardPrime,
    rewardCount,
    completedAt,
    battleDuration,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PowerVictoryImplCopyWith<_$PowerVictoryImpl> get copyWith =>
      _$$PowerVictoryImplCopyWithImpl<_$PowerVictoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return powerVictory(
      defeatedEnemy,
      rewardPrime,
      rewardCount,
      completedAt,
      battleDuration,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return powerVictory?.call(
      defeatedEnemy,
      rewardPrime,
      rewardCount,
      completedAt,
      battleDuration,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (powerVictory != null) {
      return powerVictory(
        defeatedEnemy,
        rewardPrime,
        rewardCount,
        completedAt,
        battleDuration,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return powerVictory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return powerVictory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (powerVictory != null) {
      return powerVictory(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PowerVictoryImplToJson(this);
  }
}

abstract class _PowerVictory implements BattleResultModel {
  const factory _PowerVictory({
    required final EnemyModel defeatedEnemy,
    required final int rewardPrime,
    required final int rewardCount,
    required final DateTime completedAt,
    required final int battleDuration,
  }) = _$PowerVictoryImpl;

  factory _PowerVictory.fromJson(Map<String, dynamic> json) =
      _$PowerVictoryImpl.fromJson;

  EnemyModel get defeatedEnemy;
  int get rewardPrime;
  int get rewardCount;
  DateTime get completedAt;
  int get battleDuration;
  @JsonKey(ignore: true)
  _$$PowerVictoryImplCopyWith<_$PowerVictoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContinueImplCopyWith<$Res> {
  factory _$$ContinueImplCopyWith(
    _$ContinueImpl value,
    $Res Function(_$ContinueImpl) then,
  ) = _$$ContinueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EnemyModel newEnemy, PrimeModel usedPrime});

  $EnemyModelCopyWith<$Res> get newEnemy;
  $PrimeModelCopyWith<$Res> get usedPrime;
}

/// @nodoc
class _$$ContinueImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$ContinueImpl>
    implements _$$ContinueImplCopyWith<$Res> {
  _$$ContinueImplCopyWithImpl(
    _$ContinueImpl _value,
    $Res Function(_$ContinueImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newEnemy = null, Object? usedPrime = null}) {
    return _then(
      _$ContinueImpl(
        newEnemy: null == newEnemy
            ? _value.newEnemy
            : newEnemy // ignore: cast_nullable_to_non_nullable
                  as EnemyModel,
        usedPrime: null == usedPrime
            ? _value.usedPrime
            : usedPrime // ignore: cast_nullable_to_non_nullable
                  as PrimeModel,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyModelCopyWith<$Res> get newEnemy {
    return $EnemyModelCopyWith<$Res>(_value.newEnemy, (value) {
      return _then(_value.copyWith(newEnemy: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PrimeModelCopyWith<$Res> get usedPrime {
    return $PrimeModelCopyWith<$Res>(_value.usedPrime, (value) {
      return _then(_value.copyWith(usedPrime: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinueImpl implements _Continue {
  const _$ContinueImpl({
    required this.newEnemy,
    required this.usedPrime,
    final String? $type,
  }) : $type = $type ?? 'continue_';

  factory _$ContinueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContinueImplFromJson(json);

  @override
  final EnemyModel newEnemy;
  @override
  final PrimeModel usedPrime;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.continue_(newEnemy: $newEnemy, usedPrime: $usedPrime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinueImpl &&
            (identical(other.newEnemy, newEnemy) ||
                other.newEnemy == newEnemy) &&
            (identical(other.usedPrime, usedPrime) ||
                other.usedPrime == usedPrime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, newEnemy, usedPrime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContinueImplCopyWith<_$ContinueImpl> get copyWith =>
      _$$ContinueImplCopyWithImpl<_$ContinueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return continue_(newEnemy, usedPrime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return continue_?.call(newEnemy, usedPrime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (continue_ != null) {
      return continue_(newEnemy, usedPrime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return continue_(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return continue_?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (continue_ != null) {
      return continue_(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinueImplToJson(this);
  }
}

abstract class _Continue implements BattleResultModel {
  const factory _Continue({
    required final EnemyModel newEnemy,
    required final PrimeModel usedPrime,
  }) = _$ContinueImpl;

  factory _Continue.fromJson(Map<String, dynamic> json) =
      _$ContinueImpl.fromJson;

  EnemyModel get newEnemy;
  PrimeModel get usedPrime;
  @JsonKey(ignore: true)
  _$$ContinueImplCopyWith<_$ContinueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AwaitingVictoryClaimImplCopyWith<$Res> {
  factory _$$AwaitingVictoryClaimImplCopyWith(
    _$AwaitingVictoryClaimImpl value,
    $Res Function(_$AwaitingVictoryClaimImpl) then,
  ) = _$$AwaitingVictoryClaimImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EnemyModel newEnemy, PrimeModel usedPrime});

  $EnemyModelCopyWith<$Res> get newEnemy;
  $PrimeModelCopyWith<$Res> get usedPrime;
}

/// @nodoc
class _$$AwaitingVictoryClaimImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$AwaitingVictoryClaimImpl>
    implements _$$AwaitingVictoryClaimImplCopyWith<$Res> {
  _$$AwaitingVictoryClaimImplCopyWithImpl(
    _$AwaitingVictoryClaimImpl _value,
    $Res Function(_$AwaitingVictoryClaimImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newEnemy = null, Object? usedPrime = null}) {
    return _then(
      _$AwaitingVictoryClaimImpl(
        newEnemy: null == newEnemy
            ? _value.newEnemy
            : newEnemy // ignore: cast_nullable_to_non_nullable
                  as EnemyModel,
        usedPrime: null == usedPrime
            ? _value.usedPrime
            : usedPrime // ignore: cast_nullable_to_non_nullable
                  as PrimeModel,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyModelCopyWith<$Res> get newEnemy {
    return $EnemyModelCopyWith<$Res>(_value.newEnemy, (value) {
      return _then(_value.copyWith(newEnemy: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PrimeModelCopyWith<$Res> get usedPrime {
    return $PrimeModelCopyWith<$Res>(_value.usedPrime, (value) {
      return _then(_value.copyWith(usedPrime: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AwaitingVictoryClaimImpl implements _AwaitingVictoryClaim {
  const _$AwaitingVictoryClaimImpl({
    required this.newEnemy,
    required this.usedPrime,
    final String? $type,
  }) : $type = $type ?? 'awaitingVictoryClaim';

  factory _$AwaitingVictoryClaimImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwaitingVictoryClaimImplFromJson(json);

  @override
  final EnemyModel newEnemy;
  @override
  final PrimeModel usedPrime;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.awaitingVictoryClaim(newEnemy: $newEnemy, usedPrime: $usedPrime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwaitingVictoryClaimImpl &&
            (identical(other.newEnemy, newEnemy) ||
                other.newEnemy == newEnemy) &&
            (identical(other.usedPrime, usedPrime) ||
                other.usedPrime == usedPrime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, newEnemy, usedPrime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AwaitingVictoryClaimImplCopyWith<_$AwaitingVictoryClaimImpl>
  get copyWith =>
      _$$AwaitingVictoryClaimImplCopyWithImpl<_$AwaitingVictoryClaimImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return awaitingVictoryClaim(newEnemy, usedPrime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return awaitingVictoryClaim?.call(newEnemy, usedPrime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (awaitingVictoryClaim != null) {
      return awaitingVictoryClaim(newEnemy, usedPrime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return awaitingVictoryClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return awaitingVictoryClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (awaitingVictoryClaim != null) {
      return awaitingVictoryClaim(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AwaitingVictoryClaimImplToJson(this);
  }
}

abstract class _AwaitingVictoryClaim implements BattleResultModel {
  const factory _AwaitingVictoryClaim({
    required final EnemyModel newEnemy,
    required final PrimeModel usedPrime,
  }) = _$AwaitingVictoryClaimImpl;

  factory _AwaitingVictoryClaim.fromJson(Map<String, dynamic> json) =
      _$AwaitingVictoryClaimImpl.fromJson;

  EnemyModel get newEnemy;
  PrimeModel get usedPrime;
  @JsonKey(ignore: true)
  _$$AwaitingVictoryClaimImplCopyWith<_$AwaitingVictoryClaimImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WrongClaimImplCopyWith<$Res> {
  factory _$$WrongClaimImplCopyWith(
    _$WrongClaimImpl value,
    $Res Function(_$WrongClaimImpl) then,
  ) = _$$WrongClaimImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PenaltyRecordModel penalty, EnemyModel currentEnemy});

  $PenaltyRecordModelCopyWith<$Res> get penalty;
  $EnemyModelCopyWith<$Res> get currentEnemy;
}

/// @nodoc
class _$$WrongClaimImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$WrongClaimImpl>
    implements _$$WrongClaimImplCopyWith<$Res> {
  _$$WrongClaimImplCopyWithImpl(
    _$WrongClaimImpl _value,
    $Res Function(_$WrongClaimImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? penalty = null, Object? currentEnemy = null}) {
    return _then(
      _$WrongClaimImpl(
        penalty: null == penalty
            ? _value.penalty
            : penalty // ignore: cast_nullable_to_non_nullable
                  as PenaltyRecordModel,
        currentEnemy: null == currentEnemy
            ? _value.currentEnemy
            : currentEnemy // ignore: cast_nullable_to_non_nullable
                  as EnemyModel,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRecordModelCopyWith<$Res> get penalty {
    return $PenaltyRecordModelCopyWith<$Res>(_value.penalty, (value) {
      return _then(_value.copyWith(penalty: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyModelCopyWith<$Res> get currentEnemy {
    return $EnemyModelCopyWith<$Res>(_value.currentEnemy, (value) {
      return _then(_value.copyWith(currentEnemy: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$WrongClaimImpl implements _WrongClaim {
  const _$WrongClaimImpl({
    required this.penalty,
    required this.currentEnemy,
    final String? $type,
  }) : $type = $type ?? 'wrongClaim';

  factory _$WrongClaimImpl.fromJson(Map<String, dynamic> json) =>
      _$$WrongClaimImplFromJson(json);

  @override
  final PenaltyRecordModel penalty;
  @override
  final EnemyModel currentEnemy;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.wrongClaim(penalty: $penalty, currentEnemy: $currentEnemy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WrongClaimImpl &&
            (identical(other.penalty, penalty) || other.penalty == penalty) &&
            (identical(other.currentEnemy, currentEnemy) ||
                other.currentEnemy == currentEnemy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, penalty, currentEnemy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WrongClaimImplCopyWith<_$WrongClaimImpl> get copyWith =>
      _$$WrongClaimImplCopyWithImpl<_$WrongClaimImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return wrongClaim(penalty, currentEnemy);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return wrongClaim?.call(penalty, currentEnemy);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (wrongClaim != null) {
      return wrongClaim(penalty, currentEnemy);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return wrongClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return wrongClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (wrongClaim != null) {
      return wrongClaim(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WrongClaimImplToJson(this);
  }
}

abstract class _WrongClaim implements BattleResultModel {
  const factory _WrongClaim({
    required final PenaltyRecordModel penalty,
    required final EnemyModel currentEnemy,
  }) = _$WrongClaimImpl;

  factory _WrongClaim.fromJson(Map<String, dynamic> json) =
      _$WrongClaimImpl.fromJson;

  PenaltyRecordModel get penalty;
  EnemyModel get currentEnemy;
  @JsonKey(ignore: true)
  _$$WrongClaimImplCopyWith<_$WrongClaimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EscapeImplCopyWith<$Res> {
  factory _$$EscapeImplCopyWith(
    _$EscapeImpl value,
    $Res Function(_$EscapeImpl) then,
  ) = _$$EscapeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PenaltyRecordModel penalty, DateTime escapedAt});

  $PenaltyRecordModelCopyWith<$Res> get penalty;
}

/// @nodoc
class _$$EscapeImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$EscapeImpl>
    implements _$$EscapeImplCopyWith<$Res> {
  _$$EscapeImplCopyWithImpl(
    _$EscapeImpl _value,
    $Res Function(_$EscapeImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? penalty = null, Object? escapedAt = null}) {
    return _then(
      _$EscapeImpl(
        penalty: null == penalty
            ? _value.penalty
            : penalty // ignore: cast_nullable_to_non_nullable
                  as PenaltyRecordModel,
        escapedAt: null == escapedAt
            ? _value.escapedAt
            : escapedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRecordModelCopyWith<$Res> get penalty {
    return $PenaltyRecordModelCopyWith<$Res>(_value.penalty, (value) {
      return _then(_value.copyWith(penalty: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$EscapeImpl implements _Escape {
  const _$EscapeImpl({
    required this.penalty,
    required this.escapedAt,
    final String? $type,
  }) : $type = $type ?? 'escape';

  factory _$EscapeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EscapeImplFromJson(json);

  @override
  final PenaltyRecordModel penalty;
  @override
  final DateTime escapedAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.escape(penalty: $penalty, escapedAt: $escapedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EscapeImpl &&
            (identical(other.penalty, penalty) || other.penalty == penalty) &&
            (identical(other.escapedAt, escapedAt) ||
                other.escapedAt == escapedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, penalty, escapedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EscapeImplCopyWith<_$EscapeImpl> get copyWith =>
      _$$EscapeImplCopyWithImpl<_$EscapeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return escape(penalty, escapedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return escape?.call(penalty, escapedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (escape != null) {
      return escape(penalty, escapedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return escape(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return escape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (escape != null) {
      return escape(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EscapeImplToJson(this);
  }
}

abstract class _Escape implements BattleResultModel {
  const factory _Escape({
    required final PenaltyRecordModel penalty,
    required final DateTime escapedAt,
  }) = _$EscapeImpl;

  factory _Escape.fromJson(Map<String, dynamic> json) = _$EscapeImpl.fromJson;

  PenaltyRecordModel get penalty;
  DateTime get escapedAt;
  @JsonKey(ignore: true)
  _$$EscapeImplCopyWith<_$EscapeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeOutImplCopyWith<$Res> {
  factory _$$TimeOutImplCopyWith(
    _$TimeOutImpl value,
    $Res Function(_$TimeOutImpl) then,
  ) = _$$TimeOutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PenaltyRecordModel penalty, DateTime timedOutAt});

  $PenaltyRecordModelCopyWith<$Res> get penalty;
}

/// @nodoc
class _$$TimeOutImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$TimeOutImpl>
    implements _$$TimeOutImplCopyWith<$Res> {
  _$$TimeOutImplCopyWithImpl(
    _$TimeOutImpl _value,
    $Res Function(_$TimeOutImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? penalty = null, Object? timedOutAt = null}) {
    return _then(
      _$TimeOutImpl(
        penalty: null == penalty
            ? _value.penalty
            : penalty // ignore: cast_nullable_to_non_nullable
                  as PenaltyRecordModel,
        timedOutAt: null == timedOutAt
            ? _value.timedOutAt
            : timedOutAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRecordModelCopyWith<$Res> get penalty {
    return $PenaltyRecordModelCopyWith<$Res>(_value.penalty, (value) {
      return _then(_value.copyWith(penalty: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeOutImpl implements _TimeOut {
  const _$TimeOutImpl({
    required this.penalty,
    required this.timedOutAt,
    final String? $type,
  }) : $type = $type ?? 'timeOut';

  factory _$TimeOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeOutImplFromJson(json);

  @override
  final PenaltyRecordModel penalty;
  @override
  final DateTime timedOutAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.timeOut(penalty: $penalty, timedOutAt: $timedOutAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOutImpl &&
            (identical(other.penalty, penalty) || other.penalty == penalty) &&
            (identical(other.timedOutAt, timedOutAt) ||
                other.timedOutAt == timedOutAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, penalty, timedOutAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOutImplCopyWith<_$TimeOutImpl> get copyWith =>
      _$$TimeOutImplCopyWithImpl<_$TimeOutImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return timeOut(penalty, timedOutAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return timeOut?.call(penalty, timedOutAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (timeOut != null) {
      return timeOut(penalty, timedOutAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return timeOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return timeOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (timeOut != null) {
      return timeOut(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeOutImplToJson(this);
  }
}

abstract class _TimeOut implements BattleResultModel {
  const factory _TimeOut({
    required final PenaltyRecordModel penalty,
    required final DateTime timedOutAt,
  }) = _$TimeOutImpl;

  factory _TimeOut.fromJson(Map<String, dynamic> json) = _$TimeOutImpl.fromJson;

  PenaltyRecordModel get penalty;
  DateTime get timedOutAt;
  @JsonKey(ignore: true)
  _$$TimeOutImplCopyWith<_$TimeOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = _$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? details});
}

/// @nodoc
class _$$ErrorImplCopyWithImpl<$Res>
    extends _$BattleResultModelCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  _$$ErrorImplCopyWithImpl(_$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
    : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? details = freezed}) {
    return _then(
      _$ErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message, this.details, final String? $type})
    : $type = $type ?? 'error';

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String message;
  @override
  final String? details;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BattleResultModel.error(message: $message, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, details);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      _$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )
    victory,
    required TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )
    powerVictory,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    continue_,
    required TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)
    awaitingVictoryClaim,
    required TResult Function(
      PenaltyRecordModel penalty,
      EnemyModel currentEnemy,
    )
    wrongClaim,
    required TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)
    escape,
    required TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)
    timeOut,
    required TResult Function(String message, String? details) error,
  }) {
    return error(message, details);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult? Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult? Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult? Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult? Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult? Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult? Function(String message, String? details)? error,
  }) {
    return error?.call(message, details);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      DateTime completedAt,
      int battleDuration,
    )?
    victory,
    TResult Function(
      EnemyModel defeatedEnemy,
      int rewardPrime,
      int rewardCount,
      DateTime completedAt,
      int battleDuration,
    )?
    powerVictory,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)? continue_,
    TResult Function(EnemyModel newEnemy, PrimeModel usedPrime)?
    awaitingVictoryClaim,
    TResult Function(PenaltyRecordModel penalty, EnemyModel currentEnemy)?
    wrongClaim,
    TResult Function(PenaltyRecordModel penalty, DateTime escapedAt)? escape,
    TResult Function(PenaltyRecordModel penalty, DateTime timedOutAt)? timeOut,
    TResult Function(String message, String? details)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, details);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Victory value) victory,
    required TResult Function(_PowerVictory value) powerVictory,
    required TResult Function(_Continue value) continue_,
    required TResult Function(_AwaitingVictoryClaim value) awaitingVictoryClaim,
    required TResult Function(_WrongClaim value) wrongClaim,
    required TResult Function(_Escape value) escape,
    required TResult Function(_TimeOut value) timeOut,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Victory value)? victory,
    TResult? Function(_PowerVictory value)? powerVictory,
    TResult? Function(_Continue value)? continue_,
    TResult? Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult? Function(_WrongClaim value)? wrongClaim,
    TResult? Function(_Escape value)? escape,
    TResult? Function(_TimeOut value)? timeOut,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Victory value)? victory,
    TResult Function(_PowerVictory value)? powerVictory,
    TResult Function(_Continue value)? continue_,
    TResult Function(_AwaitingVictoryClaim value)? awaitingVictoryClaim,
    TResult Function(_WrongClaim value)? wrongClaim,
    TResult Function(_Escape value)? escape,
    TResult Function(_TimeOut value)? timeOut,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(this);
  }
}

abstract class _Error implements BattleResultModel {
  const factory _Error({required final String message, final String? details}) =
      _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  String get message;
  String? get details;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
